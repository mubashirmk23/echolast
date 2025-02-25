import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echonote_new/database.dart';
import 'package:echonote_new/editlist.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Stream<QuerySnapshot>? ListStream;

  getontheload() async {
    ListStream = await DataBase.getListDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allListDetails() {
    return StreamBuilder(
        stream: ListStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(""),
            );
          }
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 201, 235, 133),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (ds['title'] ?? "N/A"),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) async {
                                  if (value == 'edit') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ListEditScreen(
                                                title: ds["title"],
                                                content: List<String>.from(
                                                    ds["content"]),
                                                id: ds["Id"],
                                              )),
                                    );
                                  } else if (value == 'delete') {
                                    await DataBase.deleteListDetails(ds['Id']);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return {'Edit', 'Delete'}
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice.toLowerCase(),
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                                icon: Icon(Icons.more_vert, color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            (ds["content"] != null && ds["content"].isNotEmpty)
                                ? ds["content"].join(", ")
                                : "N/A",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: allListDetails())],
      ),
    );
  }
}