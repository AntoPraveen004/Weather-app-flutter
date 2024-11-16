import 'package:flutter/material.dart';

void main() {
  runApp(SuccessPage());
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Submission App',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Form Submission Successful"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                "Form Submitted Successfully!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the previous screen or exit the app
                  Navigator.of(context).pop();
                },
                child: Text("Back to Previous Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
