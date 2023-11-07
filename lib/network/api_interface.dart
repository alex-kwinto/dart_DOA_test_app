import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doa_test_app/model/joke.dart';

//https://sv443.net/jokeapi/v2/
//https://v2.jokeapi.dev/joke/Any
//https://v2.jokeapi.dev/joke/Any?type=single

Future<Joke> fetchJoke() async {
  final response =
      await http.get(Uri.parse('https://v2.jokeapi.dev/joke/Any?type=single'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Joke.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load joke');
  }
}

Uri buildJokeRequestURL(Map<String, bool> filters) {
  final List<String> activeFilters = filters.entries
      .where((entry) => entry.value)
      .map((entry) => entry.key)
      .toList();

  const baseUrl = 'https://v2.jokeapi.dev/joke/Any?type=single';

  // If no active filters, build the request URL without blacklistFlags
  if (activeFilters.isEmpty) {
    return Uri.parse(baseUrl);
  }

  // If filters are active, include them in the request URL
  final blacklistFlags = activeFilters.join(',');
  final requestUrl = Uri.parse('$baseUrl&blacklistFlags=$blacklistFlags');
  return requestUrl;
}

Future<Joke> fetchJokeWithFilters(Map<String, bool> filters) async {
  final requestUrl = buildJokeRequestURL(filters);
  print(requestUrl.toString());
  final response = await http.get(requestUrl);

  if (response.statusCode == 200) {
    await Future.delayed(Duration(seconds: 1));
    return Joke.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load joke');
  }
}

