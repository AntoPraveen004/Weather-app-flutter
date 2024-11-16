import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PatientDetail_page.dart';
import 'appoinment.dart'; // Import your AppointmentDetailsPage

class AppointmentListPage extends StatelessWidget {
  final List<String> hospitalNames; // Define the parameter here

  AppointmentListPage({required this.hospitalNames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Replace 'patient_info' with your Firestore collection name
        stream: FirebaseFirestore.instance.collection('patient_info').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // Extract and display filtered appointment data
          final patient_info = snapshot.data!.docs.where((doc) {
            final appointmentData = doc.data() as Map<String, dynamic>;
            final String? name = appointmentData['patientName'] as String?;
            final String? date = appointmentData['date'] as String?;
            final String? time = appointmentData['time'] as String?;
            return name != null && date != null && time != null &&
                name.isNotEmpty && date.isNotEmpty && time.isNotEmpty;
          }).toList();

          return ListView.builder(
            itemCount: patient_info.length,
            itemBuilder: (context, index) {
              final appointmentData = patient_info[index].data() as Map<String, dynamic>;

              // Debug print to check the values of 'patientName', 'date', and 'time'
              final String name = appointmentData['patientName'];
              final String date = appointmentData['date'];
              final String time = appointmentData['time'];
              print('Name: $name');
              print('Date: $date');
              print('Time: $time');

              return ListTile(
                title: Text(name),
                subtitle: Text('$date - $time'),
                onTap: () {
                  final String documentId = patient_info[index].id;
                  // You can store or process the documentId as needed

                  // Navigate to AppointmentDetailsPage with the retrieved documentId
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentDetailPage(patient_info: documentId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
