import 'package:dio/dio.dart';
import 'package:flutter_breaking_bad/controllers/home_controller.dart';
import 'package:flutter_breaking_bad/repositories/character_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerFactory(() => Dio());
  getIt.registerFactory(() => CharacterRepository());
  getIt.registerFactory(() => HomeController());
}
