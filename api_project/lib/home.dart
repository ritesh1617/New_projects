import 'dart:convert';
import 'dart:math';

import 'package:api_project/albamdetail.dart';
import 'package:api_project/deatils.dart';
import 'package:api_project/editalbam.dart';
import 'package:api_project/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as libhttp;

class FakeApi extends StatefulWidget {
  const FakeApi({super.key});

  @override
  State<FakeApi> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FakeApi> {
  final apiURL = "http://localhost:8000/albums";

  late List albumData;
  late bool hashFailed;
  late bool isLoading;
  @override
  void initState() {
    super.initState();
    albumData = []; // empty

    hashFailed = false;
    isLoading = false;
    // start request api
    getallAlbums(); // background run
  }

  Future<void> getallAlbums() async {
    try {
      setState(() {
        isLoading = true;
        hashFailed = false;
      });

      final response = await libhttp.get(Uri.parse(apiURL));

      if (response.statusCode == 200) {
        List<dynamic> JesonArray = jsonDecode(response.body);
        // dart album object -> convert to json object -> dart object
        List<modelalbums> albumList = JesonArray.map(
            (Jesonobject) => modelalbums.FromJsonObject(Jesonobject)).toList();
        setState(() {
          hashFailed = false;
          albumData = albumList;
        });
      } else {
        throw Error.safeToString("Status Code Not 200");
      }
    } catch (e) {
      print("Error occurred: $e".toString());
      setState(() {
        hashFailed = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void DeleteAlbum(int id) async {
    final response =
        await libhttp.delete(Uri.parse(apiURL + '/' + id.toString()));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      //snakBar - Deleted
      getallAlbums();
    }
  }

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(156) + 100,
      random.nextInt(156) + 100,
      random.nextInt(156) + 100,
    );
  }

  Widget GetUI() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (hashFailed) {
        return Center(child: Text("Failed to Load Data"));
      } else {
        return Column(
          children: [
            Expanded(
              // Wrap ListView.builder with Expanded
              child: Container(
                width: double.infinity,
                child: albumData.isNotEmpty
                    ? RefreshIndicator(
                        child: ListView.builder(
                          itemCount: albumData.length,
                          itemBuilder: (context, index) {
                            final modelalbums album = albumData[index];
                            Color backgroundColor = getRandomColor();

                            return Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: ListTile(
                                  title: Text(album.title),
                                  subtitle: Text(
                                      "UserId: ${album.UserId},\n ID: ${album.id}"),
                                  leading: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditAlbumForm(
                                              modelalbums: album,
                                            ),
                                          ));
                                    },
                                    icon: Icon(Icons.edit),
                                    color:
                                        const Color.fromARGB(255, 2, 92, 165),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      DeleteAlbum(album.id);
                                    },
                                    icon: Icon(Icons.delete_forever),
                                    color: Colors.redAccent,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Apidetails(album: album),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        onRefresh: getallAlbums)
                    : Center(child: Text("No Data Found")),
              ),
            ),
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateAlbumDetails(),
              ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Album Details'),
      ),
      body: GetUI(),
    );
  }
}
