import 'package:bloc/bloc.dart';
import 'package:my_project/model/tv_series.dart';

class TvSeriesBloc extends Bloc<int, List<TvSeries>> {
  @override
  List<TvSeries> get initialState => [];

  @override
  Stream<List<TvSeries>> mapEventToState(int event) async* {
    try {
      List<TvSeries> list = await TvSeries.getTvSeries();
      yield list;
    } catch (e) {}
  }
}
