import 'dart:math';

import 'package:api_project/model.dart';
import 'package:flutter/material.dart';

class Apidetails extends StatelessWidget {
  final AlbumModel album;

  const Apidetails({required this.album});
  
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(156) + 100,
      random.nextInt(156) + 100,
      random.nextInt(156) + 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Album Single details")),
      ),
      body: Center(
        child: Container(
          height: 150,
          width: 400,
          decoration: BoxDecoration(
              color: getRandomColor(),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("User ID: ${album.userId}",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Text("Album ID: ${album.id}", style: TextStyle(fontSize: 16)),
                Text("Album Title: ${album.title}",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
