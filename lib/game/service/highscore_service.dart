import 'package:localstorage/localstorage.dart';
import 'package:snaake/game/service/score_model.dart';

class HightscoreService {
  final LocalStorage storage = new LocalStorage('highscroes');

  List<ScoreModel> getHighscores() {
    print('HIT MOCK IMPLEMENTATION');
  }

  void addScore(ScoreModel model) {
    print('HIT MOCK IMPLEMENTATION');
  }
}
