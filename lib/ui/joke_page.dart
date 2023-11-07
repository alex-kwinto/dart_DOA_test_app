import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doa_test_app/model/joke.dart';
import 'package:doa_test_app/ui/my_app_state.dart';

class JokePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    late Future<Joke> futureJoke = appState.futureJoke;

    return Center(
      child: FutureBuilder<Joke>(
        future: futureJoke,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(snapshot.data!.jokeText),
                ),
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasError)
                Text('${snapshot.error}'),
              if (snapshot.connectionState == ConnectionState.waiting)
                CircularProgressIndicator(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleFavorite(
                          snapshot.data!);
                    },
                    icon: Icon(appState.isFavorite ?Icons.favorite_border:Icons.favorite),
                    label: Text('Like'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      appState.getNext();
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}