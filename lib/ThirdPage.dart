import 'package:anto/SucessPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  String? _selectedHospital; // Initially no hospital selected
  String? _selectedDate;
  String? _selectedTime;

  List<String> _nearbyHospitals = [
    'Hospital A',
    'Hospital B',
    'Hospital C',
    'Hospital D',
  ];
  TextEditingController _patientNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController(); // Add mobile number controller

  @override
  void initState() {
    super.initState();
    initializeFirebase(); // Initialize Firebase when this page is created
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    // Now Firebase is initialized and can be used in this page
  }

  void _triggerPythonFunction() async {
    final response = await http.get(Uri.parse('http://192.168.146.170:5000/trigger_python_function'));

    if (response.statusCode == 200) {
      print('Python function triggered successfully');
      print('Response body: ${response.body}');
    } else {
      print('Failed to trigger Python function. Status code: ${response.statusCode}');
    }
  }
  void _handleSubmit() async {
    if (_selectedHospital == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a hospital.'),
      ));
      return;
    }
    String patientName = _patientNameController.text;
    String age = _ageController.text;
    String disease = _diseaseController.text;
    String mobileNumber = _mobileNumberController.text; // Get mobile number

    if (patientName.isEmpty || age.isEmpty || disease.isEmpty || mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill in all the fields.'),
      ));
      return;
    }

    if (_selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a time.'),
      ));
      return;
    }

    // Remove colons and meridian (AM/PM) from the selected time
    String result = _selectedTime!.replaceAll(RegExp(r'[^0-9]'), '');

    // Save data to Firebase Firestore
    await FirebaseFirestore.instance.collection('patient_info').add({
      'patientName': _patientNameController.text,
      'age': _ageController.text,
      'disease': _diseaseController.text,
      'hospital': _selectedHospital,
      'date': _selectedDate,
      'time': result, // Save the formatted time
      'mobileNumber': _mobileNumberController.text, // Save mobile number
    });

    _patientNameController.clear();
    _ageController.clear();
    _diseaseController.clear();
    _mobileNumberController.clear(); // Clear mobile number field
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessPage()), // Replace with the page you want to navigate to
    );

    // Handle submit button press
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data submitted successfully.'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('Patient Information'),
              SizedBox(height: 20.0),
              _buildTextField('Patient Name'),
              SizedBox(height: 20.0),
              _buildTextField('Age'),
              SizedBox(height: 20.0),
              _buildTextField('Disease Suffering From'),
              SizedBox(height: 20.0),
              _buildDropdown(),
              SizedBox(height: 20.0),
              _buildDateTimePickers(),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _triggerPythonFunction;
                  // Handle submit button press
                  _handleSubmit();
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  primary: Colors.blue, // Change the button color
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Change the text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold, // Make the title bold
          ),
        ),
        SizedBox(height: 10.0), // Add spacing below the title
        Divider(
          color: Colors.blue, // Change the divider color
          thickness: 2.0, // Adjust the thickness
        ),
      ],
    );
  }

  Widget _buildTextField(String labelText) {
    return TextField(
      controller: labelText == 'Patient Name'
          ? _patientNameController
          : labelText == 'Age'
          ? _ageController
          : labelText == 'Mobile Number' // Check for mobile number label
          ? _mobileNumberController // Use the mobile number controller
          : _diseaseController,
      keyboardType: labelText == 'Mobile Number'
          ? TextInputType.phone // Set the keyboard type to phone for mobile number
          : TextInputType.text, // Use the default keyboard type for other fields
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Nearby Hospital:',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        DropdownButtonFormField<String>(
          value: _selectedHospital,
          onChanged: (String? newValue) {
            setState(() {
              _selectedHospital = newValue;
            });
          },
          items: _nearbyHospitals.map((String hospital) {
            return DropdownMenuItem<String>(
              value: hospital,
              child: Text(hospital),
            );
          }).toList(),
        ),
        SizedBox(height: 20.0), // Add spacing below the hospital dropdown
        _buildTextField('Mobile Number'), // Add the mobile number input field
      ],
    );
  }

  Widget _buildDateTimePickers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Date and Time:',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null)
                  setState(() {
                    _selectedDate = pickedDate.toLocal().toString();
                  });
              },
              child: Text('Pick Date'),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null)
                  setState(() {
                    _selectedTime = pickedTime.format(context);
                  });
              },
              child: Text('Pick Time'),
            ),
          ],
        ),
      ],
    );
  }
}
