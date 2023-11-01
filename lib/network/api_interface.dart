import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//https://sv443.net/jokeapi/v2/
//https://v2.jokeapi.dev/joke/Any
//https://v2.jokeapi.dev/joke/Any?type=single

Future<Joke> fetchJoke() async {
  final response = await http
      .get(Uri.parse('https://v2.jokeapi.dev/joke/Any?type=single'));

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

class Joke {
  final String type;
  final String jokeText;
  final String category;
  final bool is_nsfw;
  final bool is_religious;
  final bool is_political;
  final bool is_racist;
  final bool is_sexist;
  final bool is_explicit;

  const Joke({
    required this.type,
    required this.jokeText,
    required this.category,
    required this.is_nsfw,
    required this.is_religious,
    required this.is_political,
    required this.is_racist,
    required this.is_sexist,
    required this.is_explicit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Joke && other.jokeText == jokeText);

  @override
  int get hashCode => jokeText.hashCode;

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      type: json['type'],
      jokeText: json['joke'],
      category: json['category'],
      is_nsfw: json['flags']['nsfw'],
      is_religious: json['flags']['religious'],
      is_political: json['flags']['political'],
      is_racist: json['flags']['racist'],
      is_sexist: json['flags']['sexist'],
      is_explicit: json['flags']['explicit'],
    );
  }
}
