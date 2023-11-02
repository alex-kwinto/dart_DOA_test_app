import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/joke.dart';

//https://sv443.net/jokeapi/v2/
//https://v2.jokeapi.dev/joke/Any
//https://v2.jokeapi.dev/joke/Any?type=single

Future<Joke> fetchJoke() async {
  final response =
      await http.get(Uri.parse('https://v2.jokeapi.dev/joke/Any?type=single'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    await Future.delayed(Duration(seconds: 1));
    return Joke.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load joke');
  }
}

