import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fops/src/model/trending_repositories_model.dart';
import 'package:fops/src/ui/landing_page_widgets.dart/loading.dart';
import 'package:shimmer/shimmer.dart';

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
        }, builder: (context, state) {
          if (state.isLoading) {
            return landingLoading();
          }
          if (state.isLoaded) {
            return ListView.builder(
                shrinkWrap: false,
                physics: ScrollPhysics(),
                itemCount: state.trendingRepositoriesList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  TrendingRepositoriesModel item =
                      state.trendingRepositoriesList[index];
                  return ExpansionTile(
                    trailing: Container(
                      width: 1,
                    ),
                    leading: CircleAvatar(
                      maxRadius: 17,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) =>
                              CircularProgressIndicator(
                            value: progress.progress,
                          ),
                          imageUrl: item.avatar,
                        ),
                      ),
                    ),
                    title: Text(item.author,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black)),
                    subtitle: Text(
                      item.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                    children: <Widget>[
                      Container(
                        child: Text(item.description),
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(75, 0, 20, 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(75, 0, 20, 10),
                        child: Row(
                          children: <Widget>[
                            expandedItem(
                                ClipOval(
                                    child: Container(
                                  height: 5,
                                  width: 5,
                                  color: Colors.red,
                                )),
                                item.language),
                            expandedItem(
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                (item.stars ?? 0).toString()),expandedItem(Icon(Icons.call_split), (item.forks??'NA').toString())
                          ],
                        ),
                      )
                    ],
                  );
                });
            
          }
          if (state.isError) {
            return Center(
              child: FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    _landingPageBloc.add(FetchAll());
                  },
                  child: Text('Retry')),
            );
          }
          return Container();
        }));
  }
}

Widget expandedItem(Widget child, String title) {
  return Row(
    children: <Widget>[
      child,
      Padding(
        padding: EdgeInsets.only(left: 0, right: 15),
        child: Text(title),
      )
    ],
  );
}
