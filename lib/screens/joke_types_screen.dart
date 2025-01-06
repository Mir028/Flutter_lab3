import 'package:flutter/material.dart';
import '../services/api_services.dart';
import 'jokes_list_screen.dart';
import 'favorites_screen.dart';  // Import the new screen

class JokeTypesScreen extends StatefulWidget {
  @override
  _JokeTypesScreenState createState() => _JokeTypesScreenState();
}

class _JokeTypesScreenState extends State<JokeTypesScreen> {
  List<String> favoriteJokes = [];  // List to store favorite jokes

  // Function to fetch and show a random joke
  void _fetchRandomJoke(BuildContext context) async {
    try {
      final randomJoke = await ApiService.getRandomJoke();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Random Joke'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(randomJoke.setup),
              SizedBox(height: 10),
              Text(randomJoke.punchline),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            // Button to add to favorites
            TextButton(
              onPressed: () {
                setState(() {
                  favoriteJokes.add('${randomJoke.setup} - ${randomJoke.punchline}');
                });
                Navigator.of(context).pop();
              },
              child: Text('Add to Favorites'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Handle error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to load random joke: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types'),
        actions: [
          // Add a button to fetch a random joke
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () => _fetchRandomJoke(context),
          ),
          // Add a button to navigate to the favorites screen
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(favoriteJokes: favoriteJokes),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: ApiService.getJokeTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final types = snapshot.data!;
            return ListView.builder(
              itemCount: types.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(types[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokesListScreen(type: types[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
