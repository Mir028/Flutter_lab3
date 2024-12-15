// lib/widgets/joke_card.dart
import 'package:flutter/material.dart';

// Custom widget for displaying jokes in a card
class JokeCard extends StatelessWidget {
  final String setup;
  final String punchline;

  // Constructor for passing setup and punchline
  JokeCard({required this.setup, required this.punchline});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,  // Optional, adds shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),  // Rounded corners
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              setup,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              punchline,
              style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
