import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:my_project/bloc/tvseriesdetailbloc.dart';
import 'package:my_project/model/episode.dart';
import 'package:my_project/model/season.dart';
import 'package:my_project/model/tv_series_detail.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SecondPage extends StatelessWidget {
  int idTvSeries;
  SecondPage(this.idTvSeries);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TV Series Netflix")),
      body: DetailTvSeriesUI(idTvSeries),
    );
  }
}

class SecondTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Second Page"),
    );
  }
}

class DetailTvSeriesUI extends StatefulWidget {
  int idTvSeries;
  DetailTvSeriesUI(this.idTvSeries);
  @override
  _DetailTvSeriesUIState createState() => _DetailTvSeriesUIState(idTvSeries);
}

class _DetailTvSeriesUIState extends State<DetailTvSeriesUI> {
  int idTvSeries;
  _DetailTvSeriesUIState(this.idTvSeries);
  ProgressDialog progressApi;
  TvSeriesDetail tvSeriesDetail = TvSeriesDetail();
  List<Season> listSeason = [];
  List<Episode> episodes = [];

  List<Widget> listEpisode = [];
  List<int> _seasons = [];
  List<DropdownMenuItem<int>> _dropdownSeason;
  int _selectedSeason = 1;

  @override
  void initState() {
    progressApi = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressApi.style(
      message: "Loading",
    );
    progressApi.show();

    TvSeriesDetailBloc detailBloc =
        BlocProvider.of<TvSeriesDetailBloc>(context);

    super.initState();
    detailBloc.add(1);
  }

  List<DropdownMenuItem<int>> buildDropdownMenuItems(List seasonsindex) {
    List<DropdownMenuItem<int>> items = List();
    for (int value in seasonsindex) {
      items.add(DropdownMenuItem(value: value, child: Text("$value")));
    }
    return items;
  }

  onChageDropdownItem(int selectedSeason) {
    Season seasonChoice = Season();
    setState(() {
      for (var season in listSeason) {
        if (season.season == selectedSeason) {
          seasonChoice = season;
        }
      }
      episodes = [];
      for (var value in seasonChoice.episodes) {
        episodes.add(value);
      }
      listEpisode = [];
      for (var episode in episodes) {
        listEpisode.add(cardEpisodeItem(episode));
      }
      _selectedSeason = selectedSeason;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesDetailBloc, List<TvSeriesDetail>>(
        builder: (context, list) {
      if (list.length != 0) {
        progressApi.hide();

        for (var details in list) {
          if (details.id_tv_series == idTvSeries) {
            tvSeriesDetail = details;
          }
        }
        listSeason = tvSeriesDetail.seasons;
        _seasons = [];
        for (var season in listSeason) {
          _seasons.add(season.season);
        }
        _dropdownSeason = buildDropdownMenuItems(_seasons);
      } else {
        Future.delayed(Duration(seconds: 3)).then((onValue) {
          progressApi.hide();
        });
      }
      return list.length != 0
          ? Column(
              children: <Widget>[
                HeaderDetailTvSeries("Creator", tvSeriesDetail.creator),
                HeaderDetailTvSeries("Cast", tvSeriesDetail.cast),
                HeaderDetailTvSeries("Genre", tvSeriesDetail.genre),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: Text(
                        "Season  ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    DropdownButton(
                      value: _selectedSeason,
                      items: _dropdownSeason,
                      onChanged: onChageDropdownItem,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(shrinkWrap: true, children: listEpisode),
                ),
              ],
            )
          : Center(
              child: Center(child: CircularProgressIndicator()),
            );
    });
  }

  Widget HeaderDetailTvSeries(String caption, String desc) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: width * 0.2,
              child: Text(caption,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Container(
              width: width * 0.05,
              child: Text(
                ":",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Container(
            width: width * 0.65,
            child: Text(
              desc,
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget cardEpisodeItem(Episode episode) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Text(
                    episode.episode.toString() + " ",
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),
                  )),
              Flexible(
                  flex: 3,
                  child: Text(
                    episode.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      child: Text(
                        " " + episode.duration,
                        style: TextStyle(color: Colors.grey[600], fontSize: 20),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
