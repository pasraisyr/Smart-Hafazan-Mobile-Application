import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_hafazan/custom_flashcard.dart';
import 'dashboard.dart';

class VerseListPage extends StatefulWidget {
  final String surahName;

  final Map<String, int> versesCount = {
    'Al-Mulk': 30,
    'As-Sajdah': 30,
    'Al-Insan': 31,
    'Al-Waqiah': 96,
    'Ad-Dukhan': 31,
  };

  VerseListPage(this.surahName, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerseListPageState createState() => _VerseListPageState();
}

class _VerseListPageState extends State<VerseListPage> {
  Set<String> answeredQuestions = <String>{};

  @override
  Widget build(BuildContext context) {
    int verseCount = widget.versesCount[widget.surahName] ?? 0;

    if (kDebugMode) {
      print('Answered Questions: $answeredQuestions');
    } // Add this line

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.surahName} Verses'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: verseCount,
        itemBuilder: (context, index) {
          int verseNumber = index + 1;
          bool isAnswered = answeredQuestions.contains('Ayat $verseNumber');
        

          return GestureDetector(
            onTap: () {
              _navigateToFlashcard('Ayat $verseNumber', context);
            },
            child: Card(
              elevation: 4.0,
              color: isAnswered ? Colors.lightGreenAccent : null, // Change the background color
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Ayat $verseNumber',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
          );
        },
        child: const Icon(Icons.dashboard),
      ),
    );
  }

void _navigateToFlashcard(String verse, BuildContext context) async {
  var result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CustomFlashcard(
        surahName: widget.surahName,
        verse: verse,
        onAnswered: (isCorrect) {
          if (isCorrect) {
            setState(() {
              answeredQuestions.add(verse);
              if (kDebugMode) {
                print('Answered Questions: $answeredQuestions');
              }
            });
          } else {
            // Remind the user to try again
            _showReminder(context);
          }
        },
      ),
    ),
  );

  // If the user didn't answer the question, remove it from answered questions
  if (result != null && !result) {
    setState(() {
      answeredQuestions.remove(verse);
    });
  }
}


  void _showReminder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bacaan Salah , tidak apa ambil masa untuk ingat. Ulanglah 10 kali, kemudian cuba lagi.'),
      ),
    );
  }
}