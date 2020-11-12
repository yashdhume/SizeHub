import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:size_hub/data/PostData.dart';
import 'package:size_hub/data/UserMeasurementData.dart';
import 'package:size_hub/data/database/Database.dart';

import 'PostWidget/PostWidget.dart';

class GroupedPosts extends StatefulWidget {
  GroupedPosts({Key key}) : super(key: key);

  @override
  _GroupedPostsState createState() => _GroupedPostsState();
}

class _GroupedPostsState extends State<GroupedPosts> {
  Database _database;

  @override
  void initState() {
    _database = Database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _database.readAllNew(),
        builder: (BuildContext context,
            AsyncSnapshot<Stream<QuerySnapshot>> snapshot) {
          if (snapshot.data == null) return Text("No data");
          return StreamBuilder(
              stream: snapshot.data,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error ${snapshot.error}");
                if (snapshot.connectionState == ConnectionState.waiting)
                  return FlareActor(
                    "assets/animations/Loading.flr",
                    animation: "Loading",
                    fit: BoxFit.contain,
                  );
                List<PostData> posts = [];
                snapshot.data.docs.forEach((e) {
                  posts.add(PostData(
                      e.id,
                      _database.getUsername(e["userId"]),
                      (e["photoUrls"] as List<dynamic>)
                          .map((e) => e as String)
                          .toList(),
                      UserMeasurementData(
                          e["userMeasurementsData"]["weight"],
                          e["userMeasurementsData"]["height"])));
                });
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    PostData post = posts[index];
                    return PostWidget(
                        id: post.id,
                        userName: post.author,
                        picture:
                            post.photoUrls == null || post.photoUrls.isEmpty
                                ? ""
                                : post.photoUrls[0]);
                  },
                  staggeredTileBuilder: (index) =>
                      StaggeredTile.count(2, index.isEven ? 2 : 3),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                );
              });
        });
  }
}
