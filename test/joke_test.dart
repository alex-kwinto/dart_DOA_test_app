import 'package:doa_test_app/model/joke.dart';
import 'package:test/test.dart';

void main() {
  test('Conversion from JSON.', () {
    final joke = Joke.fromJson( {
      "error": false,
      "category": "Programming",
      "type": "single",
      "joke": "Your momma is so fat, you need to switch to NTFS to store a picture of her.",
      "flags": {
        "nsfw": false,
        "religious": false,
        "political": false,
        "racist": false,
        "sexist": false,
        "explicit": true
      },
      "id": 55,
      "safe": false,
      "lang": "en"
    });
    expect(joke.id, 55);
    expect(joke.type, "single");
    expect(joke.jokeText, "Your momma is so fat, you need to switch to NTFS to store a picture of her.");
    expect(joke.category, "Programming");
    expect(joke.flags, Map<String, bool>.from({
      "nsfw": false,
      "religious": false,
      "political": false,
      "racist": false,
      "sexist": false,
      "explicit": true
    }));
  });

  test('Conversion to JSON.', () {
    final joke = Joke(
        id: 306,
        category: "Misc",
        type: "single",
        jokeText: "Yo mama is so old, she knew Burger King while he was still a prince.",
        flags: {
          "nsfw": false,
          "religious": false,
          "political": false,
          "racist": false,
          "sexist": false,
          "explicit": false
        }
    );

    final json = joke.toMap();

    expect(json, {
      "category": "Misc",
      "type": "single",
      "jokeText": "Yo mama is so old, she knew Burger King while he was still a prince.",
      "flags": '{"nsfw":false,"religious":false,"political":false,"racist":false,"sexist":false,"explicit":false}', // Compare as a string
      "id": 306
    }, reason: 'Check if the serialization is correct');
  });


}
