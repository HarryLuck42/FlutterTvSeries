import 'package:my_project/model/episode.dart';

class Season {
  int season;
  List<Episode> episodes;

  Season({this.season, this.episodes});

  factory Season.createSeason(Map<String, dynamic> object) {
    return Season(season: object['season'], episodes: object['episodes']);
  }

  factory Season.fromJson(dynamic json) {
    if (json['episodes'] != null) {
      var episodesObjsJson = json['episodes'] as List;
      List<Episode> _episodes = episodesObjsJson
          .map((episodeJson) => Episode.fromJson(episodeJson))
          .toList();
      return Season(season: json['season'] as int, episodes: _episodes);
    } else {
      return Season(season: json['season'] as int);
    }
  }
}
