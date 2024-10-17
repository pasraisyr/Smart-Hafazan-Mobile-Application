// custom_flashcard.dart

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:smart_hafazan/verse_data.dart';
import 'dashboard.dart';

class CustomFlashcard extends StatefulWidget {
  final String surahName;
  final String verse;
  final Function(bool isCorrect) onAnswered;

  const CustomFlashcard({super.key, 
    required this.surahName,
    required this.verse,
    required this.onAnswered,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomFlashcardState createState() => _CustomFlashcardState();
}

class _CustomFlashcardState extends State<CustomFlashcard> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool hasAnswered = false;

  void _showReminder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bacaan Salah'),
        content: const Text('Tidak apa ambil masa untuk ingat. Ulanglah 10 kali, kemudian cuba lagi.'),
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

  void _updateScore(bool isCorrect, String surahName, String verse) {
    if (isCorrect) {
      Dashboard.userScores[surahName] = (Dashboard.userScores[surahName] ?? 0) + 1;
      setState(() {});
      hasAnswered = true;

      // Add the answered Ayat to the list
      if (!Dashboard.answeredAyats.containsKey(surahName)) {
        Dashboard.answeredAyats[surahName] = [];
      }
      Dashboard.answeredAyats[surahName]?.add(verse);

      // Show congratulatory alert dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hebat!'),
          content: const Text('Anda baca ayat lengkap yang betul. Kembali, dan teruskan hafal ayat seterusnya'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onAnswered(true);
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      );
    } else {
      // Show a reminder for incorrect answers
      _showReminder(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    String surahName = widget.surahName;
    String verse = widget.verse;

    String question = VerseData.verseFlashcards[surahName]?[verse]?['Permulaan Ayat'] ?? '';
    String answer = VerseData.verseFlashcards[surahName]?[verse]?['Ayat Lengkap'] ?? '';

    int score = Dashboard.userScores[surahName] ?? 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 197, 247, 91),
        title: const Text('Kad Anda'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context, hasAnswered); // Pass whether the user has answered or not
          },
        ),
      ),
      body: Material(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 500.0,
            child: FlipCard(
              key: cardKey,
              flipOnTouch: false,
              front: GestureDetector(
                onTap: () {
                  cardKey.currentState?.toggleCard();
                },
                child: Card(
                  elevation: 4.0,
                  color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Permulaan Ayat:\n$question',
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              back: GestureDetector(
                onTap: () {
                  cardKey.currentState?.toggleCard();
                },
                child: Card(
                  elevation: 4.0,
                  color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ayat Lengkap:\n$answer',
                          style: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text('Markah: $score '),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            _updateScore(true, surahName, verse);
                            widget.onAnswered(true);
                          },
                          child: const Text('Betul'),
                        ),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            _updateScore(false, surahName, verse);
                            widget.onAnswered(false);
                          },
                          child: const Text('Salah'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}