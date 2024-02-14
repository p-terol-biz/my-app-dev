import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DeckProperty {
  final String cardInDeckId;

  final String cardId;

  final Future<String> cardImageURL;

  DeckProperty(this.cardInDeckId, this.cardId, this.cardImageURL);
}

class UserDeckInformation {
  final String deckId;

  final String cardInDeckId;

  final String cardId;

  final Future<String> cardImageURL;

  UserDeckInformation(
      this.deckId, this.cardInDeckId, this.cardId, this.cardImageURL);

  Map<String, dynamic> toMap() {
    return {
      'deckId': deckId,
      'cardInDeckId': cardInDeckId,
      'cardId': cardId,
      'cardImageURL': cardImageURL,
    };
  }
}

class DeckModelsObject {
  Future<Database> getDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'deck_models.db'),
    );
    return database;
  }

  void createDatabase() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'deck_models.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE T_DECK_MODELS(deckid TEXT PRIMARY KEY, cardInDeckId TEXT, cardId, TEXT, cardImageURL TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertDatabase(UserDeckInformation userDeckInformation) async {
    final Database db = await getDatabase();

    await db.insert(
      'deck_models',
      userDeckInformation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserDeckInformation>> getUserDeckInformation() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('deck_models');
    return List.generate(maps.length, (i) {
      return UserDeckInformation(maps[i]['deckId'], maps[i]['cardInDeckId'],
          maps[i]['cardId'], maps[i]['cardImageURL']);
    });
  }
}
