import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Mypy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _codeController = TextEditingController();
  TextEditingController _doctorController = TextEditingController();

  void _triggerPythonFunction() async {
    final response = await http.get(Uri.parse('http://192.168.95.170:5000/trigger_python_function'));

    if (response.statusCode == 200) {
      print('Python function triggered successfully');
      print('Response body: ${response.body}');
    } else {
      print('Failed to trigger Python function. Status code: ${response.statusCode}');
    }
  }

  void _submitButtonPressed() async {
    String code = _codeController.text;
    String doctor = _doctorController.text;

    if (code.isEmpty || doctor.isEmpty) {
      print('Please enter code and doctor.');
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.95.170:5000/book_appointment'),
      body: {
        'code': code,
        'doctor': doctor,
      },
    );

    if (response.statusCode == 200) {
      print('Submit button pressed, appointment booked successfully');
    } else {
      print('Failed to book appointment');
    }
  }

  void _deleteButtonPressed() async {
    String code = _codeController.text;
    String doctor = _doctorController.text;

    if (code.isEmpty || doctor.isEmpty) {
      print('Please enter code and doctor.');
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.95.170:5000/delete_appointment'),
      body: {
        'code': code,
        'doctor': doctor,
      },
    );

    if (response.statusCode == 200) {
      print('Delete button pressed, appointment deleted successfully');
    } else {
      print('Failed to delete appointment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _triggerPythonFunction,
              child: Text('Trigger Python Function'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter code',
                labelText: 'Code',
              ),
            ),
            TextField(
              controller: _doctorController,
              decoration: InputDecoration(
                hintText: 'Enter doctor',
                labelText: 'Doctor',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitButtonPressed,
              child: Text('Submit'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _deleteButtonPressed,
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}