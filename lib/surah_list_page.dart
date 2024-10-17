//surah_list_page
import 'package:flutter/material.dart';
import 'verse_list_page.dart';

class SurahListPage extends StatelessWidget {
  final List<String> surahName = ['Al-Mulk', 'As-Sajdah', 'Al-Waqiah', 'Ad-Dukhan', 'Al-Insan'];

  SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah List'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: surahName.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                surahName[index],
                style: const TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerseListPage(surahName[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
