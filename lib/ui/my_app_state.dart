import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doa_test_app/model/database_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:doa_test_app/network/api_interface.dart';
import 'package:doa_test_app/model/joke.dart';

class MyAppState extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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

  MyAppState() {
    databaseWrapper.initDatabase();
    getFilters();
    getFavorite();
    getJoke();
  }

  void getNext() async {
    futureJoke = fetchJokeWithFilters(filters);
    isFavorite = true;
    setFavorite();
    setJoke();
    notifyListeners();
  }

  Future setFavorite() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isFavorite', isFavorite);
  }

  Future setFilters(Map<String, bool> filters) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('filters', jsonEncode(filters));
  }

  Future setJoke() async {
    final SharedPreferences prefs = await _prefs;
    final Joke joke = await futureJoke;
    prefs.setString('futureJoke', jsonEncode(joke));
  }

  Future getFilters() async {
    final SharedPreferences prefs = await _prefs;
    final String filtersJson = prefs.getString('filters') ?? '';
    if (filtersJson.isNotEmpty) {
      filters = Map<String, bool>.from(jsonDecode(filtersJson));
    } else {
      filters = {
        'nsfw': false,
        'religious': false,
        'political': false,
        'racist': false,
        'sexist': false,
        'explicit': false,
      };
      setFilters(filters);
    }
  }

  Future getJoke() async {
    final SharedPreferences prefs = await _prefs;
    final String jokeJson = prefs.getString('futureJoke') ?? '';
    if (jokeJson.isNotEmpty) {
      futureJoke = Future.value(Joke.fromJson(jsonDecode(jokeJson)));
    } else {
      futureJoke = fetchJokeWithFilters(filters);
      isFavorite = true;
      setJoke();
      setFavorite();
    }
  }

  Future getFavorite() async {
    final SharedPreferences prefs = await _prefs;
    isFavorite = prefs.getBool('isFavorite') ?? true;
    setFavorite();
    notifyListeners();
  }

  void toggleFavorite(Joke joke) async {
    isFavorite = await databaseWrapper.toggleItem(joke);
    await setFavorite();
    notifyListeners();
  }

  void toggleFilter(String key) {
    //TODO review if null protection reliable
    filters[key] = !filters[key]!;
    setFilters(filters);
    notifyListeners();
  }
}
