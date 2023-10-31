import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './apiWork.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  late Future<Joke> futureJoke = fetchJoke();

  void getNext() {
    futureJoke = fetchJoke();
    notifyListeners();
  }

  var favorites = <Joke>[];

  void toggleFavorite(Joke joke) {
    if (favorites.contains(joke)) {
      favorites.remove(joke);
    } else {
      favorites.add(joke);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = JokePage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Column(
                  children: [
                    Expanded(child: Container(child: page)),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50, // Adjust the height as needed
                        color: Theme.of(context).colorScheme.onPrimary,
                        child: Row(
                          children: [
                            SizedBox(width: 30),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Handle the press event here
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.work_off),
                                    // Replace with your icon
                                    if (constraints.maxWidth >= 600)
                                      Text('NSFW'),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Handle the press event here
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.church),
                                    // Replace with your icon
                                    if (constraints.maxWidth >= 600)
                                      Text('Religious'),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Handle the press event here
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.how_to_reg),
                                    // Replace with your icon
                                    if (constraints.maxWidth >= 600)
                                      Text('Political'),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Handle the press event here
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.group_off),
                                    // Replace with your icon
                                    if (constraints.maxWidth >= 600)
                                      Text('Racist'),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Handle the press event here
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.volunteer_activism),
                                    // Replace with your icon
                                    if (constraints.maxWidth >= 600)
                                      Text('Sexist'),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Handle the press event here
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.explicit),
                                    // Replace with your icon
                                    if (constraints.maxWidth >= 600)
                                      Text('Explicit'),
                                  ],
                                ),
                              ),
                            ),
/*bool isToggled = false;

GestureDetector(
  onTap: () {
    setState(() {
      isToggled = !isToggled; // Toggle the state
    });
  },
  child: Stack(
    children: [
      // Widget for the untoggled state
      Visibility(
        visible: !isToggled,
        child: Container(
          width: 100,
          height: 50,
          color: Colors.blue, // Change to your desired appearance
        ),
      ),
      // Widget for the toggled state
      Visibility(
        visible: isToggled,
        child: Container(
          width: 100,
          height: 50,
          color: Colors.green, // Change to your desired appearance
        ),
      ),
    ],
  ),
)
*/
                            SizedBox(width: 30),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

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

// class GeneratorPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();
//     // var pair = appState.current;
//
//     IconData icon;
//     icon = Icons.favorite_border;
//     // if (appState.favorites.contains(pair)) {
//     //   icon = Icons.favorite;
//     // } else {
//     //   icon = Icons.favorite_border;
//     // }
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // BigCard(pair: pair),
//           SizedBox(height: 10),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: () {
//                   appState.toggleFavorite();
//                 },
//                 icon: Icon(icon),
//                 label: Text('Like'),
//               ),
//               SizedBox(width: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   appState.getNext();
//                 },
//                 child: Text('Next'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BigCard extends StatelessWidget {
//   const BigCard({
//     super.key,
//     required this.pair,
//   });
//
//   final WordPair pair;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final style = theme.textTheme.displayMedium!.copyWith(
//       color: theme.colorScheme.onPrimary,
//     );
//
//     return Card(
//       color: theme.colorScheme.primary,
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Text(
//           pair.asLowerCase,
//           style: style,
//           semanticsLabel: "${pair.first} ${pair.second}",
//         ),
//       ),
//     );
//   }
// }

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
              title: Text(extractFirstWordsLimited(
                  joke.jokeText, constraints.maxWidth >= 600 ? 60 : 25)),
            ),
        ],
      );
    });
  }
}
