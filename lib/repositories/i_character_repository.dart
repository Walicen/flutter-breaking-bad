import 'package:flutter_breaking_bad/models/character_model.dart';

abstract class ICharacterRepository {
  Future<List<Character>> fetchCharacter();
}
