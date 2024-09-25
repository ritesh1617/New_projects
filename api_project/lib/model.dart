import 'package:flutter/foundation.dart';

class modelalbums {
  final int UserId;
  final int id;
  final String title;

  modelalbums({required this.UserId, required this.id, required this.title});

  factory modelalbums.FromJsonObject(Map<String, dynamic> json) {
    return modelalbums(
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
      title: json['title'] ?? 'Unknown Title',
      UserId: json['UserId'] != null ? int.parse(json['UserId'].toString()) : 0,
    );
  }
}
