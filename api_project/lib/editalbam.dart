import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as libhttp;

class EditAlbumForm extends StatefulWidget {
  final modelalbums;
  EditAlbumForm({required this.modelalbums}) : super();
  @override
  State<EditAlbumForm> createState() =>
      _EditAlbumFormState(modelalbums: this.modelalbums);
}

class _EditAlbumFormState extends State<EditAlbumForm> {
  final modelalbums;
  _EditAlbumFormState({required this.modelalbums});
  final TextEditingController UserIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  final apiURL = "http://localhost:8000/albums";
  @override
  void initState() {
    super.initState();
    UserIdController.text = this.modelalbums.UserId.toString();
    titleController.text = this.modelalbums.title;
  }

  void SendEditAlbumRequest() async {
    // URL Patch Request
    final response = await libhttp.patch(
      Uri.parse('$apiURL/${modelalbums.id}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'UserId': int.tryParse(UserIdController.text),
        'title': titleController.text,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Album Edited successfully!'),
      ));
      //
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Failed to Edited album, please try again.: ${response.body}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Edit Album Details: ${this.modelalbums.id.toString()}"),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              TextField(
                controller: UserIdController,
                decoration: InputDecoration(labelText: "Album UserID"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Album Title"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: SendEditAlbumRequest,
                    child: Text("Edit"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
