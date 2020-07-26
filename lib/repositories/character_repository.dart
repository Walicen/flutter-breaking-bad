import 'package:dio/dio.dart';
import 'package:flutter_breaking_bad/config/injection.dart';
import 'package:flutter_breaking_bad/models/character_model.dart';
import 'package:flutter_breaking_bad/repositories/i_character_repository.dart';

class CharacterRepository implements ICharacterRepository {
  final Dio _dio = getIt<Dio>();

  Future<List<Character>> fetchCharacter() async {
    Response response = await _dio.get('https://www.breakingbadapi.com/api/characters/');
    return (response.data as List).map((e) => Character.fromJson(e)).toList();
  }
}
