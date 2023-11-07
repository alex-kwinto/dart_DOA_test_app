import 'package:sqflite/sqflite.dart';
import 'package:doa_test_app/model/joke.dart';

class DatabaseWrapper {
  late Database database;

  Future<void> clearDatabase() async {
    // Get a reference to the database
    final db = await database;

    // Delete all records from the 'jokes' table
    await db.delete('jokes');
  }

  Future<void> initDatabase() async {
    database = await openDatabase('joke_database.db', version: 1,
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE jokes('
        'id INTEGER PRIMARY KEY,'
        'type TEXT,'
        'jokeText TEXT,'
        'category TEXT,'
        'flags TEXT' // Define the 'flags' field as a TEXT column
        ')',
      );
    });
  }

  Future<void> insertDatabase(Joke joke) async {
    await database.insert('jokes', joke.toMap());
  }

  Future<List<Joke>> getFilteredData(Map<String, bool> filters) async {
    final query = StringBuffer('SELECT * FROM jokes WHERE 1=1');

    for (final entry in filters.entries) {
      if (entry.value) {
        // Use json_extract to check if the key exists and the value is 0
        query.write(' AND json_extract(flags, "\$.${entry.key}") = 0');
      }
    }

    print(query);

    final List<Map<String, dynamic>> data = await database.rawQuery(query.toString());

    return data.map((item) => Joke.fromMap(item)).toList();
  }


  Future<List<Joke>> getAllData() async {
    final List<Map<String, dynamic>> data = await database.query('jokes');
    print(data);
    return data.map((item) => Joke.fromMap(item)).toList();
  }

  Future<void> toggleItem(Joke joke) async {
    var existingItem = await getItemById(joke.id);
    
    if (existingItem != false) {
      await database.delete('jokes', where: 'id = ?', whereArgs: [joke.id]);
      existingItem = await getItemById(joke.id);
    } else {
      await database.insert('jokes', joke.toMap());
    }
  }

  Future<bool> getItemById(int id) async {
    final List<Map<String, dynamic>> jokes = await database.query(
      'jokes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (jokes.isEmpty) {
      print('EMPTY!');
      return false;
    } else {
      return true;
    }
  }
}
