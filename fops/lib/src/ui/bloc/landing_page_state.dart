import 'package:flutter/material.dart';
import 'package:fops/src/model/trending_repositories_model.dart';

@immutable
class LandingPageState {
  final bool isLoading;
  final bool isError;
  final bool isLoaded;
  final String error;
  final List<TrendingRepositoriesModel> trendingRepositoriesList;

  LandingPageState({
    @required this.isLoading,
    @required this.isError,
    @required this.isLoaded,
    this.error,
    @required this.trendingRepositoriesList,
  });

  factory LandingPageState.uninitialized() {
    return LandingPageState(
      isError: false,
      isLoading: false,
      isLoaded: false,
      error: '',
      trendingRepositoriesList: [],
    );
  }

  LandingPageState update({
    bool isError,
    bool isLoading,
    bool isLoaded,
    String error,
    List<TrendingRepositoriesModel> trendingRepositoriesList,
  }) {
    return copyWith(
      isError: isError,
      isLoading: isLoading,
      isLoaded: isLoaded,
      error: error,
      trendingRepositoriesList: trendingRepositoriesList,
    );
  }

  LandingPageState copyWith({
    bool isError,
    bool isLoading,
    bool isLoaded,
    String error,
    List<TrendingRepositoriesModel> trendingRepositoriesList,
  }) {
    return LandingPageState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      error: error ?? this.error,
      trendingRepositoriesList:
          trendingRepositoriesList ?? this.trendingRepositoriesList,
    );
  }
}
