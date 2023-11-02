
class Joke {
  final String type;
  final String jokeText;
  final String category;
  final Map<String, bool> flags;

  const Joke({
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

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
        type: json['type'],
        jokeText: json['joke'],
        category: json['category'],
        flags: {
          'NSFW': json['flags']['nsfw'],
          'Religious': json['flags']['religious'],
          'Political': json['flags']['political'],
          'Racist': json['flags']['racist'],
          'Sexist': json['flags']['sexist'],
          'Explicit': json['flags']['explicit'],
        });
  }
}