import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget landingLoading() {
  return Column(
    children: <Widget>[
      Expanded(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: true,
          child: ListView.builder(
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Container(
                          width: 45,
                          height: 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 8.0,
                          color: Colors.white,margin: const EdgeInsets.only(bottom: 10),
                        ),
                       
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,margin: const EdgeInsets.only(right: 20),
                        ),
                       
                      ],
                    ),
                  )
                ],
              ),
            ),
            itemCount: 6,
          ),
        ),
      ),
    ],
  );
}
