import 'package:bloc/bloc.dart';
import 'package:my_project/model/tv_series_detail.dart';

class TvSeriesDetailBloc extends Bloc<int, List<TvSeriesDetail>> {
  @override
  List<TvSeriesDetail> get initialState => [];

  @override
  Stream<List<TvSeriesDetail>> mapEventToState(int event) async* {
    try {
      List<TvSeriesDetail> list = await TvSeriesDetail.getTvSeriesDetails();
      yield list;
    } catch (e) {
      e.toString();
    }
  }
}
