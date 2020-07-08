import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fops/src/model/trending_repositories_model.dart';

import 'bloc/bloc.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LandingPageBloc>(
      create: (context) => LandingPageBloc(),
      child: _LandingPage(),
    );
  }
}

class _LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<_LandingPage> {
  LandingPageBloc _landingPageBloc;
  @override
  void initState() {
    super.initState();
    _landingPageBloc = BlocProvider.of<LandingPageBloc>(context);
    _landingPageBloc.add(FetchAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Trending'),
          centerTitle: true,
        ),
        body: BlocConsumer<LandingPageBloc, LandingPageState>(
            listener: (context, state) {
          // do stuff here based on BlocA's state
        }, builder: (context, state) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.isLoaded) {
            return ListView.builder(
                shrinkWrap: false,
                physics: ScrollPhysics(),
                itemCount: state.trendingRepositoriesList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  TrendingRepositoriesModel item =
                      state.trendingRepositoriesList[index];
                  return Text(item.name);
                });
          }
          if (state.isError) {
            return Scaffold(
                backgroundColor: Colors.blue,
                body: Center(
                  child: FlatButton(
                      color: Colors.red,
                      onPressed: () {
                        _landingPageBloc.add(FetchAll());
                      },
                      child: Text('Retry')),
                ));
          }
          return Container();
        }));
  }
}
