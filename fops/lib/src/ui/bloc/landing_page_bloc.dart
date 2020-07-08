import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:fops/src/model/trending_repositories_model.dart';
import 'package:fops/src/utilities/contants.dart';

import 'bloc.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingPageBloc() : super(LandingPageState.uninitialized());

  @override
  Stream<LandingPageState> mapEventToState(event) async* {
    if (event is FetchAll) {
      try {
        yield state.update(isError: false, error: '', isLoading: true);
        final responses = await Future.wait([_fetchTrendingRepositories()]);
        yield state.update(
            isLoading: false,
            isLoaded: true,
            trendingRepositoriesList: responses[0]);
      } catch (e) {
        yield state.update(
            isError: true, error: e.toString(), isLoading: false);
        //  yield state.update(isError: false, error: '');
      }
    }
  }

  Future<List<TrendingRepositoriesModel>> _fetchTrendingRepositories() async {
    final Response<String> response = await Dio().get(
      '$BASE_URL/repositories',
      options: Options(),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.data) as List;
      return data.map((rawPost) {
        return TrendingRepositoriesModel.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
