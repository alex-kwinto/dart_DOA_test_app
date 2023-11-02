import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './my_app_state.dart';
import '../model/joke.dart';

class FavoritesPage extends StatelessWidget {
  String extractFirstWordsLimited(String input, int maxLength) {
    List<String> words = input.split(' ');
    List<String> selectedWords = [];
    int currentLength = 0;

    for (var word in words) {
      if (currentLength + word.length + selectedWords.length > maxLength) {
        break; // Stop if adding the next word exceeds the maxLength.
      }
      selectedWords.add(word);
      currentLength += word.length;
    }

    return selectedWords.join(' ');
  }

  void showPopup(BuildContext context, Joke joke) {
    showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        var appState = context.watch<MyAppState>();

        return AlertDialog(
          title: Text('Popup Header'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(joke.jokeText),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                appState.toggleFavorite(joke);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      return ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('You have '
                '${appState.favorites.length} favorites:'),
          ),
          for (var joke in appState.favorites)
            ListTile(
              leading: Icon(Icons.favorite),
              onTap: (){ showPopup(context, joke);},
              title: Text(extractFirstWordsLimited(
                  joke.jokeText, constraints.maxWidth >= 600 ? 60 : 25)),
            ),
        ],
      );
    });
  }
}