import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class TvSeries {
  int id;
  String title;
  String img_url;
  String year;
  String sinopsis;

  TvSeries({this.id, this.title, this.img_url, this.year, this.sinopsis});

  factory TvSeries.createTvSeries(Map<String, dynamic> object) {
    return TvSeries(
        id: object['id'],
        title: object['title'],
        img_url: object['img_url'],
        year: object['year'],
        sinopsis: object['sinopsis']);
  }

  static Future<List<TvSeries>> getTvSeries() async {
    String apiURL = "http://hariyantosubang.com/json/tv_series_netflix.json";

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listTvSeries =
        (jsonObject as Map<String, dynamic>)['tv_series'];
    List<TvSeries> tvSeries = [];
    for (int i = 0; i < listTvSeries.length; i++) {
      tvSeries.add(TvSeries.createTvSeries(listTvSeries[i]));
    }
    return tvSeries;
  }
}
