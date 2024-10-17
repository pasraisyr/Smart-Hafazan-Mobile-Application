import 'package:flutter/material.dart';
import 'hukum1.dart'; // Import your Hukum1.dart file
import 'hukum2.dart'; // Import your Hukum1.dart file
import 'hukum3.dart';

class TajwidPage extends StatelessWidget {
  const TajwidPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nota Tajwid'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First Choice
          ChoiceCard(
            title: 'Hukum Nun Mati',
            onTap: () {
              // Handle the tap for Option 1
              print('Option 1 tapped!');
              // Navigate to Hukum1.dart when Option 1 is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HukumNunMatiPage()),
              );
            },
          ),
          
          // Second Choice
          ChoiceCard(
            title: 'Hukum Mim Mati',
            onTap: () {
              // Handle the tap for Option 2
              print('Option 2 tapped!');
              // Navigate to Hukum2.dart when Option 1 is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HukumMimMatiPage()),
              );
            },
          ),
          
          // Third Choice
          ChoiceCard(
            title: 'Mad',
            onTap: () {
              // Handle the tap for Option 2
              print('Option 3 tapped!');
              // Navigate to Hukum3.dart when Option 1 is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HukumMadPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ChoiceCard({required this.title, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: TajwidPage(),
  ));
}
