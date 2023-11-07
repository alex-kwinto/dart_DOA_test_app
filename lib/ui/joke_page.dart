import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doa_test_app/model/joke.dart';
import 'package:doa_test_app/ui/my_app_state.dart';

class JokePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    late Future<Joke> futureJoke = appState.futureJoke;

    IconData icon;
    icon = Icons.favorite_border;
    //TODO
    // if (appState.favorites.contains(pair)) {
    //   icon = Icons.favorite;
    // } else {
    //   icon = Icons.favorite_border;
    // }

    return Center(
      child: FutureBuilder<Joke>(
        future: futureJoke,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.done &&
          //     snapshot.hasData)
          //   print(snapshot.data!.flags);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData)
                Text(snapshot.data!.jokeText),
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasError)
                Text('${snapshot.error}'),
              if (snapshot.connectionState == ConnectionState.waiting)
                CircularProgressIndicator(),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      appState.toggleFavorite(
                          snapshot.data!); // Pass the data, not the snapshot
                    },
                    icon: Icon(Icons.favorite),
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