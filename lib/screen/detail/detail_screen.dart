import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tourism_app/data/models/tourism.dart';
import 'package:tourism_app/data/models/tourism_detail_response.dart';

import 'package:tourism_app/provider/detail/bookmark_icon_provider.dart';
import 'package:tourism_app/provider/detail/tourism_detail_provider.dart';
import 'package:tourism_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:tourism_app/screen/detail/bookmark_icon_widget.dart';
import 'package:tourism_app/static/tourism_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final int tourismID;

  const DetailScreen({
    super.key,
    required this.tourismID,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // final Completer<Tourism> _completerTourism = Completer<Tourism>();
  // late Future<TourismDetailResponse> _futureTourismDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Udah ga diperluin lagi soalnya diganti sama provider
    // _futureTourismDetail = ApiServices().getTourismDetail(widget.tourismID);
    Future.microtask(() {
      context
          .read<TourismDetailProvider>()
          .fetchTourismDetail(widget.tourismID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism Detail"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<TourismDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  TourismDetailLoadedState(data: var tourism) =>
                    BookmarkIconWidget(tourism: tourism),
                  _ => const SizedBox(),
                };
              },
            ),
          )
        ],
      ),
      body: Consumer<TourismDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            TourismDetailLoadingState() => Center(
                child: CircularProgressIndicator(),
              ),
            TourismDetailLoadedState(data: var tourism) =>
              BodyOfDetailScreenWidget(tourism: tourism),
            TourismDetailErrorState(error: var message) => Center(
                child: Text(message),
              ),
            _ => SizedBox(),
          };
        },
      ),
    );
  }
}
