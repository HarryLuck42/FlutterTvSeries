class Episode {
  int episode;
  String title;
  String duration;

  Episode(this.episode, this.title, this.duration);

  factory Episode.fromJson(dynamic json) {
    return Episode(json['episode'] as int, json['title'] as String,
        json['duration'] as String);
  }
}
