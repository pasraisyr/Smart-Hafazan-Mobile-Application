import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_hafazan/dashboard.dart';
//import 'package:smart_hafazan_new/dashboard_page.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to show an alert dialog
  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DaftarAkaun'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Kata Laluan'),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                try {
                  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  print('User created: ${userCredential.user?.email}');

                  // Show success alert
                  _showAlertDialog('Berjaya Daftar', 'Akaun berjaya didaftarkan!');
                } catch (e) {
                  // Handle different error scenarios and show respective alerts
                  if (e is FirebaseAuthException) {
                    if (e.code == 'email-already-in-use') {
                      _showAlertDialog('Daftar Gagal', 'Email telah digunakan.');
                    } else if (e.code == 'invalid-email') {
                      _showAlertDialog('Daftar Gagal', 'Format email tidak sah.');
                    } else if (e.code == 'weak-password') {
                      _showAlertDialog('Daftar Gagal', 'Kata Laluan lemah. Sila cuba lagi.');
                    }
                  }

                  print('Error creating user: $e');
                }
              },
              child: const Text('Daftar Akaun'),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Sudah ada akaun ? "),
                TextButton(
                  onPressed: () {
                    // Navigate to the login screen (replace LoginScreen with your login screen)
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text('Log Masuk'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Masuk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Kata Laluan'),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                try {
                  UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  
                  print('Berjaya Masuk !: ${userCredential.user?.email}');

                  // Check if the user is not null
                  if (userCredential.user != null) {
                    // Navigate to the dashboard page (replace DashboardPage with your actual dashboard)
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                  }
                } catch (e) {
                  print('Error logging in: $e');
                }
              },
              child: const Text('Log Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}

