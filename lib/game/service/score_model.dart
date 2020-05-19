class ScoreModel {
  final int points;
  final DateTime date;

  ScoreModel(this.points, this.date);

  ScoreModel.fromJson(Map<String, dynamic> json)
      : points = json['points'],
        date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {
        'points': points,
        'date': date.toString(),
      };
}
