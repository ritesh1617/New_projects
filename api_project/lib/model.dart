import 'package:flutter/foundation.dart';

class AlbumModel {
  final int userId;
  final int id;
  final String title;

  AlbumModel({required this.userId, required this.id, required this.title});

  factory AlbumModel.fromJsonObject(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
      title: json['title'] ?? 'Unknown Title',
      userId: json['UserId'] != null ? int.parse(json['UserId'].toString()) : 0,
    );
  }
}
