import 'package:flutter/material.dart';
import 'patient_data.dart'; // Import the PatientData class

class DetailsPage extends StatefulWidget {
  final PatientData patientData;

  DetailsPage({required this.patientData});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Patient Name', widget.patientData.patientName),
            _buildDetailItem('Age', widget.patientData.age),
            _buildDetailItem('Disease', widget.patientData.disease),
            _buildDetailItem('Hospital', widget.patientData.hospital),
            _buildDetailItem('Date', widget.patientData.date),
            _buildDetailItem('Time', widget.patientData.time),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Divider(),
      ],
    );
  }
}
