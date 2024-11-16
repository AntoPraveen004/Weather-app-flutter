import 'package:anto/view_appoinment.dart';
import 'package:flutter/material.dart';
import 'ThirdPage.dart';
import 'view_appoinment.dart';
import 'package:anto/PatientDetail_page.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate some initialization work or loading data
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Your Splash Screen Content',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

class NotificationPage extends StatelessWidget {
  final String doctorName;
  final String appointmentTime;

  NotificationPage({
    required this.doctorName,
    required this.appointmentTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Doctor: $doctorName',
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              'Appointment Time: $appointmentTime',
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> governmentHospitals = [
    'Hospital 1',
    'Hospital 2',
    'Hospital 3',
    'Hospital 4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Notification bell icon
            onPressed: () {
              // Navigate to the NotificationPage with appointment details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(
                    doctorName:
                    'Dr. John Doe', // Replace with the actual doctor's name
                    appointmentTime:
                    '10:00 AM', // Replace with the actual appointment time
                    // Add more appointment details here if needed
                  ),
                ),
              ); // Add your notification action here.
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Your Name"),
              accountEmail: Text("youremail@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('View Appointment'),
              onTap: () {
                // Navigate to the View Appointments page.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentListPage(hospitalNames: []),
                  ),
                );

              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Book Appointment'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Terms and Conditions'),
              onTap: () {
                // Add your Terms and Conditions page navigation logic here.
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                // Add your Feedback page navigation logic here.
                Navigator.pop(context); // Close the drawer
                // Navigate to the Feedback page here.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Add your About page navigation logic here.
                Navigator.pop(context); // Close the drawer
                // Navigate to the About page here.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                // Show a confirmation dialog when clicking on "Logout."
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Logout'),
                      content: Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Logout'),
                          onPressed: () {
                            // Add your logout logic here.
                            Navigator.of(context).pop(); // Close the dialog
                            // Perform logout action.
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // List of government hospitals
              Column(
                children: governmentHospitals
                    .map((hospital) => Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    hospital,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ))
                    .toList(),
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Appointment Booking page.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      'Book Appointment',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the View Appointments page.
                  // Navigate to the View Appointments page with an empty list for hospitalNames
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentListPage(hospitalNames: []),
                    ),
                  );

                },
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      'View Appointments',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This app is used to solve the queue in govt hospitals and to reduce the queue time among the people and to make a schedule to overcome the wastage of time and to get proper treatment.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'This app was made by BHARATHRAJ E, AMRITH BHARATH, ANTONY PRAVEEN, HARIRAM L, AHALYA, JANNANI KATRHIGA',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate us:',
              style: TextStyle(fontSize: 16.0),
            ),
            // Add your rating widget here
            SizedBox(height: 16.0),
            Text(
              'Comments:',
              style: TextStyle(fontSize: 16.0),
            ),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter your comments here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add your feedback submission logic here.
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}
