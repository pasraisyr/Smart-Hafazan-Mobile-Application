// dashboard.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  static Map<String, int> userScores = {};
  static Map<String, List<String>> answeredAyats = {};

  const Dashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Function to reset user scores and answered Ayats
  void _resetScores() {
    setState(() {
      Dashboard.userScores.clear();
      Dashboard.answeredAyats.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prestasi Anda'),
        actions: [
          // Add a reset button to the app bar
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetScores,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DashboardPage(), // Add the DashboardPage widget
            Expanded(
              child: ListView(
                children: Dashboard.userScores.keys.map((surahName) {
                  int score = Dashboard.userScores[surahName] ?? 0;
                  List<String> answeredAyats = Dashboard.answeredAyats[surahName] ?? [];

                  return Card(
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        surahName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('Markah: $score '),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          score.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Add an "more" icon to the trailing property of the ListTile
                      trailing: IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          // Show details in a dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Info Lain $surahName'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Markah: $score '),
                                  const SizedBox(height: 8.0),
                                  Text('Berjaya Hafal: ${answeredAyats.join(', ')}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Keluar'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await FirebaseAuth.instance.signOut();
            // After logging out, you may want to navigate back to the login screen
            // You can replace the line below with the appropriate navigation logic
            Navigator.pop(context);
          } catch (e) {
            print('Error logging out: $e');
          }
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the currently authenticated user
    User? user = FirebaseAuth.instance.currentUser;
    String initials = user?.email?.isNotEmpty ?? false ? user!.email![0].toUpperCase() : 'U';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: const Color.fromARGB(255, 153, 245, 78),
            child: Text(
              initials,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Welcome to the Dashboard,',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Hello ! ${user?.email ?? ''}',
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
        ],
      ),
    );
  }
}
