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

  bool isFavorite = true;

  MyAppState(){
    databaseWrapper.initDatabase();
  }

  void getNext() {
    futureJoke = fetchJokeWithFilters(filters);
    isFavorite = true;
    notifyListeners();
  }

  void toggleFavorite(Joke joke) async{
    isFavorite = await databaseWrapper.toggleItem(joke);
    notifyListeners();
  }

  void toggleFilter(String key) {
    //TODO review if null protection reliable
    filters[key] = !filters[key]!;
    notifyListeners();
  }

}