import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doa_test_app/ui/my_app_state.dart';
import 'package:doa_test_app/ui/favorites_page.dart';
import 'package:doa_test_app/ui/joke_page.dart';
import 'package:doa_test_app/ui/filter_button.dart';

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
                            FilterButton(buttonIcon: Icons.work_off, buttonString: 'nsfw', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.church, buttonString: 'religious', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.how_to_reg, buttonString: 'political', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.group_off, buttonString: 'racist', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.volunteer_activism, buttonString: 'sexist', buttonCondition: constraints.maxWidth >= 600),
                            FilterButton(buttonIcon: Icons.explicit, buttonString: 'explicit', buttonCondition: constraints.maxWidth >= 600),
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




