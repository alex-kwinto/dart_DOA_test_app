import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doa_test_app/ui/my_app_state.dart';
import 'package:doa_test_app/model/joke.dart';

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
    final appState = context.watch<MyAppState>();
    final Future<List<Joke>> favorites = appState.databaseWrapper.getFilteredData(appState.filters);

    return FutureBuilder<List<Joke>>(
      future: favorites,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done  && snapshot.hasData) {
            var jokes = snapshot.data; // The list of Joke objects
            if (jokes!.isEmpty) {
              return Center(
                child: Text('No such favorites yet.'),
              );
            } else {
              return LayoutBuilder(builder: (context, constraints) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text('You have '
                          '${jokes.length} favorites:'),
                    ),
                    for (var joke in jokes)
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
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError)
          return Text('${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return Text('should never trigger');
      },
    );
  }
}