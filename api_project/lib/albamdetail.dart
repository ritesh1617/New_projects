import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as libhttp;

class CreateAlbumDetails extends StatefulWidget {
  const CreateAlbumDetails({Key? key}) : super(key: key);

  @override
  _CreateAlbumDetailsState createState() => _CreateAlbumDetailsState();
}

class _CreateAlbumDetailsState extends State<CreateAlbumDetails> {
  final TextEditingController IdController = TextEditingController();
  final TextEditingController UserIdController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  final apiURL = "http://localhost:8000/albums";

  void SendCreateAlbumRequest() async {
    // URL post Request
    final response = await libhttp.post(
      Uri.parse(apiURL),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': int.tryParse(IdController.text),
        'UserId': int.tryParse(UserIdController.text),
        'title': titleController.text,
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Album created successfully!'),
      ));
      //
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Failed to create album, please try again.: ${response.body}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Create Album Details")),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: IdController,
                decoration: InputDecoration(labelText: "ID"),
                keyboardType: TextInputType.number,
              ),
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
                    onPressed: SendCreateAlbumRequest,
                    child: Text("Submit"),
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
