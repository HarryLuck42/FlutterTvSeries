import 'package:hive/hive.dart';
import 'package:my_project/model/season.dart';
part 'tv_series_detail_hive.g.dart';

@HiveType(typeId: 1)
class TvSeriesDetailHive {
  @HiveField(0)
  int id;
  @HiveField(1)
  String creator;
  @HiveField(2)
  String cast;
  @HiveField(3)
  String genre;
  @HiveField(4)
  int id_tv_series;
  @HiveField(5)
  String seasons;

  TvSeriesDetailHive(
      {this.id,
      this.creator,
      this.cast,
      this.genre,
      this.id_tv_series,
      this.seasons});
}
