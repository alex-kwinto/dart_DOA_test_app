import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'network/api_interface.dart';
import 'ui/my_app_state.dart';
import 'ui/favorites_page.dart';
import 'ui/filter_button.dart';

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
        title: 'JokesApp',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        home: MyHomePage(),
      ),
    );
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
                            FilterButton(buttonIcon: Icons.work_off, buttonString: 'NSFW', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.church, buttonString: 'Religious', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.how_to_reg, buttonString: 'Political', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.group_off, buttonString: 'Racist', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.volunteer_activism, buttonString: 'Sexist', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.explicit, buttonString: 'Explicit', buttonCondition: constraints.maxWidth >= 600),
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


