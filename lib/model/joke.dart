import 'dart:convert';

class Joke {
  final int id;
  final String type;
  final String jokeText;
  final String category;
  final Map<String, bool> flags;

  const Joke({
    required this.id,
    required this.type,
    required this.jokeText,
    required this.category,
    required this.flags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Joke && other.jokeText == jokeText);

  @override
  int get hashCode => jokeText.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'jokeText': jokeText,
      'category': category,
      'flags': jsonEncode(flags), // Store the flags as a JSON string
    };
  }

  factory Joke.fromMap(Map<String, dynamic> map) {
    return Joke(
        id: map['id'],
        type: map['type'],
        jokeText: map['jokeText'],
        category: map['category'],
        flags: Map<String, bool>.from(json.decode(map['flags'])),
        );
  }

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'],
      type: json['type'],
      jokeText: json['joke'],
      category: json['category'],
      flags: Map<String, bool>.from(json['flags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'joke': jokeText,
      'category': category,
      'flags': flags,
    };
  }
}
