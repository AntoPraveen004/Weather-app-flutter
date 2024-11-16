import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Add Firebase import
import 'sign_up.dart';
import 'drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SecondPage(),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login Page'),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF64B5F6),
                  Color(0xFF81C784),
                ], // Adjusted gradient colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _incorrectPassword = false;

  void _login() async {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: enteredUsername, // Use email as the username
        password: enteredPassword,
      );

      // Successful login
      // You can now access user information using userCredential.user
      Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));
      print('Login successful');

      setState(() {
        _incorrectPassword = false;
      });

      // Navigate to the next screen or perform necessary actions
      // For example:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Menu()),
      // );
    } catch (e) {
      // Invalid credentials or other login errors
      print('Login error: $e');
      setState(() {
        _incorrectPassword = true;
      });
    }
  }


  void _signIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
    print('Sign In button pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Username',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white, // Match the gradient color
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Password',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white, // Match the gradient color
                ),
              ),
              errorText: _incorrectPassword ? 'Incorrect password' : null,
            ),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _login,
                  child: Padding(
                    padding: EdgeInsets.all(12.0), // Adjusted padding
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0), // Adjusted spacing between buttons
              Expanded(
                child: ElevatedButton(
                  onPressed: _signIn,
                  child: Padding(
                    padding: EdgeInsets.all(12.0), // Adjusted padding
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
