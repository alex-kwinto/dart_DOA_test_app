import 'package:doa_test_app/model/database_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:doa_test_app/network/api_interface.dart';
import 'package:doa_test_app/model/joke.dart';

class MyAppState extends ChangeNotifier {
  DatabaseWrapper databaseWrapper = DatabaseWrapper();
  Map<String, bool> filters = {
    'nsfw': false,
    'religious': false,
    'political': false,
    'racist': false,
    'sexist': false,
    'explicit': false,
  };
  late Future<Joke> futureJoke = fetchJokeWithFilters(filters);

  MyAppState(){
    databaseWrapper.initDatabase();
  }

  void getNext() {
    futureJoke = fetchJokeWithFilters(filters);
    notifyListeners();
  }

  // var favorites = <Joke>[];

  void toggleFavorite(Joke joke) {
    databaseWrapper.toggleItem(joke);
    // if (favorites.contains(joke)) {
    //   favorites.remove(joke);
    // } else {
    //   favorites.add(joke);
    // }
    notifyListeners();
  }

  void toggleFilter(String key) {
    //TODO review if null protection reliable
    filters[key] = !filters[key]!;
    notifyListeners();
  }

}