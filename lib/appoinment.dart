// Define a data model for appointments
import 'package:flutter/material.dart';
class Appointment {
  final String name;
  final int age;
  final String hospital;
  final String symptoms;
  final String date;
  final String time;

  Appointment({
    required this.name,
    required this.age,
    required this.hospital,
    required this.symptoms,
    required this.date,
    required this.time,
  });
}

// In your appointment list page, fetch and display appointments
class AppointmentListsPage extends StatelessWidget {
  // Fetch appointments from Firestore or any other data source
  List<Appointment> _fetchAppointments() {
    // Implement fetching logic here
    // This could involve querying Firestore or any other backend service.
    // Return a list of Appointment objects.
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final appointments = _fetchAppointments();

    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];

          return ListTile(
            title: Text(appointment.name),
            subtitle: Text(appointment.date),
            onTap: () {
              // Navigate to the appointment details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentDetailsPage(appointment: appointment),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Create a separate page for displaying appointment details
class AppointmentDetailsPage extends StatelessWidget {
  final Appointment appointment;

  AppointmentDetailsPage({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${appointment.name}'),
            Text('Age: ${appointment.age}'),
            Text('Hospital: ${appointment.hospital}'),
            Text('Symptoms: ${appointment.symptoms}'),
            Text('Date: ${appointment.date}'),
            Text('Time: ${appointment.time}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
