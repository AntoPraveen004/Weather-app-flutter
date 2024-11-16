import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AppointmentDetailPage extends StatefulWidget {
  final String patient_info; // Define the parameter

  AppointmentDetailPage({required this.patient_info}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Build the UI for displaying appointment details
    // Use the patient_info parameter to retrieve and display data
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Patient Info: $patient_info'),
            // Add more widgets to display appointment details
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _AppointmentDetailsPageState extends State<AppointmentDetailPage> {
  Map<String, dynamic>? appointmentData;

  @override
  void initState() {
    super.initState();
    fetchPatientInfo(widget.patient_info); // Calling fetchPatientInfo with the provided patient_info parameter
  }


  Future<void> fetchPatientInfo(String patientInfoId) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('patient_info').doc(patientInfoId).get();

    // Now, you have the specific patient's information in the 'snapshot' variable.
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: appointmentData != null
          ? ListView(
        children: [
          ListTile(
            title: Text('Name: ${appointmentData!['name']}'),
          ),
          ListTile(
            title: Text('Age: ${appointmentData!['age']}'),
          ),
          ListTile(
            title: Text('Hospital: ${appointmentData!['hospital']}'),
          ),
          ListTile(
            title: Text('Symptoms: ${appointmentData!['symptoms']}'),
          ),
          ListTile(
            title: Text('Date: ${appointmentData!['date']}'),
          ),
          ListTile(
            title: Text('Time: ${appointmentData!['time']}'),
          ),
          // Add more details as needed
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
