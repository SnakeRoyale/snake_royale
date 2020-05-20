import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:snaake/game/service/score_model.dart';

class HightscoreService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    var file = File('$path/data.txt');
    if (await file.exists()) {
      print('File exists');

      return file;
    }
    print('returning created file..');

    return file.create();
  }

  Future<List<ScoreModel>> getHighscores() async {
    final file = await _localFile;
    if (await file.readAsString() == '') {
      return <ScoreModel>[];
    }

    var jsonList = await jsonDecode(file.readAsStringSync());
    var scores = <ScoreModel>[];
    for (var jsonEntry in jsonList) {
      scores.add(ScoreModel.fromJson(jsonEntry));
    }
    return scores;
  }

  Future<void> addScore(ScoreModel model) async {
    final file = await _localFile;

    final scores = await getHighscores();

    scores.add(model);

    await file.writeAsString(jsonEncode(scores));

    return;
  }
}
