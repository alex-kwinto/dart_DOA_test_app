import 'package:flutter/material.dart';
import '../network/api_interface.dart';

class MyAppState extends ChangeNotifier {
  late Future<Joke> futureJoke = fetchJoke();

  Map<String, bool> filters = {
    'NSFW': false,
    'Religious': false,
    'Political': false,
    'Racist': false,
    'Sexist': false,
    'Explicit': false,
  };

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

  void toggleFilter(String key) {
    //TODO review if null protection relieble
    filters[key] = !filters[key]!;
    notifyListeners();
  }

}