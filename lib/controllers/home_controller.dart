import 'package:flutter_breaking_bad/config/injection.dart';
import 'package:flutter_breaking_bad/models/character_model.dart';
import 'package:flutter_breaking_bad/repositories/character_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final CharacterRepository _repository = getIt<CharacterRepository>();

  @observable
  ObservableList<Character> characters = ObservableList.of([]);

  @action
  setCharacters(ObservableList<Character> value) => characters = value;

  @observable
  bool loading = false;

  @action
  setLoading(bool value) => loading = value;

  getAllCharacters() {
    setLoading(true);
    _repository
        .fetchCharacter()
        .then((value) {
          setCharacters(value.asObservable());
        })
        .catchError((e) => print(e))
        .whenComplete(() => setLoading(false));
  }
}
