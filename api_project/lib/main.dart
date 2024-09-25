
import 'package:api_project/home.dart';
import 'package:flutter/material.dart';

////http://localhost:8000/albums
//npx json-server data.json -p 8000
void main() {
  runApp(ParentWidget());
}

class ParentWidget extends StatelessWidget {
  const ParentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Homescreen() ,
    );
  }
}
