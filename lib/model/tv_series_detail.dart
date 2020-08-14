import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_project/model/season.dart';

class TvSeriesDetail {
  int id;
  String creator;
  String cast;
  String genre;
  int id_tv_series;
  List<Season> seasons;

  TvSeriesDetail(
      {this.id,
      this.creator,
      this.cast,
      this.genre,
      this.id_tv_series,
      this.seasons});

  factory TvSeriesDetail.createTvSeries(Map<String, dynamic> object) {
    return TvSeriesDetail(
        id: object['id'],
        creator: object['creator'],
        cast: object['cast'],
        genre: object['genre'],
        id_tv_series: object['id_tv_series'],
        seasons: object['seasons']);
  }

  factory TvSeriesDetail.fromJson(dynamic json) {
    if (json['seasons'] != null) {
      var seasonObjsJson = json['seasons'] as List;
      List<Season> _seasons = seasonObjsJson
          .map((seasonJson) => Season.fromJson(seasonJson))
          .toList();
      return TvSeriesDetail(
          id: json['id'] as int,
          creator: json['creator'] as String,
          cast: json['cast'] as String,
          genre: json['genre'] as String,
          id_tv_series: json['id_tv_series'] as int,
          seasons: _seasons);
    } else {
      return TvSeriesDetail(
        id: json['id'] as int,
        creator: json['creator'] as String,
        cast: json['cast'] as String,
        genre: json['genre'] as String,
        id_tv_series: json['id_tv_series'] as int,
      );
    }
  }

  @override
  String toString() {
    return '{ ${this.id}, ${this.creator}, ${this.cast}, ${this.genre}, ${this.id_tv_series}, ${this.seasons} }';
  }

  static Future<List<TvSeriesDetail>> getTvSeriesDetails() async {
    String apiURL =
        "http://hariyantosubang.com/json/detail_tv_series_netflix.json";

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listTvSeriesDetail =
        (jsonObject as Map<String, dynamic>)['tv_series_detail'];
    List<TvSeriesDetail> tvSeriesdetails = [];
    for (int i = 0; i < listTvSeriesDetail.length; i++) {
      tvSeriesdetails.add(TvSeriesDetail.fromJson(listTvSeriesDetail[i]));
    }
    return tvSeriesdetails;
  }
}
