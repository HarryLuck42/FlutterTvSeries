import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/bloc/tvseriesdetailbloc.dart';
import 'package:my_project/model/tv_series.dart';
import 'package:my_project/bloc/tvseriesbloc.dart';
import 'package:my_project/model/tv_series_detail.dart';
import 'package:my_project/model/tv_series_detail_hive.dart';
import 'package:my_project/ui/detail_tv_series_ui.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(MyApp());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageOne(),
    );
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SecondTest();
        }));
      }),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TvSeriesBloc>(create: (context) => TvSeriesBloc()),
          BlocProvider<TvSeriesDetailBloc>(
              create: (context) => TvSeriesDetailBloc())
        ],
        child: List_Tv_Series(),
      ),
    );
  }
}

class List_Tv_Series extends StatefulWidget {
  @override
  _List_Tv_SeriesState createState() => _List_Tv_SeriesState();
}

class _List_Tv_SeriesState extends State<List_Tv_Series> {
  List<TvSeries> tvList = [];
  Box _openDetail;
  Box details;

  @override
  void initState() {
    TvSeriesBloc bloc = BlocProvider.of<TvSeriesBloc>(context);
    // TvSeriesDetailBloc detailBloc =
    //     BlocProvider.of<TvSeriesDetailBloc>(context);
    // TODO: implement initState
    super.initState();
    bloc.add(1);
    // Future.delayed(Duration(seconds: 5)).then((onValue) {
    //   detailBloc.add(1);
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listTvSeries = [];
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 2;
    final double itemWidth = size.width / 2;
    return BlocBuilder<TvSeriesBloc, List<TvSeries>>(builder: (context, list) {
      for (var value in list) {
        listTvSeries.add(buildCardTvSeries(value, context));
      }

      return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("TV Series Netflix"),
        ),
        body: listTvSeries.length != 0
            ? GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                shrinkWrap: true,
                children: listTvSeries,
              )
            : Center(child: CircularProgressIndicator()),
      );
    });
  }
}

Widget buildCardTvSeries(TvSeries tvSeries, BuildContext context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  final double itemHeight = (height - kToolbarHeight - 50) / 2;
  final double itemWidth = (width - 20) / 2;
  return Card(
    elevation: 5,
    child: Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Image(
            height: itemHeight / 1.5,
            width: itemWidth,
            image: NetworkImage(tvSeries.img_url),
          ),
          Container(
              margin: EdgeInsets.only(top: 4),
              child: Text(
                tvSeries.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
          Text(tvSeries.year),
          RaisedButton(
            onPressed: () {
              _dialog("Sinopsis", tvSeries.sinopsis, context);
            },
            child: Text("Sinopsis"),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MultiBlocProvider(providers: [
                  BlocProvider<TvSeriesBloc>(
                      create: (context) => TvSeriesBloc()),
                  BlocProvider<TvSeriesDetailBloc>(
                      create: (context) => TvSeriesDetailBloc())
                ], child: SecondPage(tvSeries.id));
              }));
            },
            child: Text("Detail"),
          )
        ],
      ),
    ),
  );
}

Future<void> _dialog(String title, String message, BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
