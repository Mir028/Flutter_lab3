import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<String> favoriteJokes;

  FavoritesScreen({required this.favoriteJokes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Омилени шеги")),
      body: favoriteJokes.isEmpty
          ? Center(child: Text('Нема омилени шеги.')) // Message when the list is empty
          : ListView.builder(
        itemCount: favoriteJokes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteJokes[index]),
          );
        },
      ),
    );
  }
}
