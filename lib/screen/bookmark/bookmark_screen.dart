import 'package:flutter/material.dart';
import 'package:tourism_app/models/tourism.dart';
import 'package:tourism_app/screen/home/tourism_card_widget.dart';
import 'package:tourism_app/static/navigation_route.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark List"),
      ),
      body: ListView.builder(
          itemCount: bookmarkTourismList.length,
          itemBuilder: (context, index) {
            final tourism = bookmarkTourismList[index];
            return TourismCard(
              tourism: tourism,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  NavigationRoute.detailRoute.name,
                  arguments: tourism,
                );
              },
            );
          }),
    );
  }
}
