
import 'package:echonote_new/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class TextAddingExample extends StatefulWidget {
  @override
  State<TextAddingExample> createState() => _TextAddingExampleState();
}

class _TextAddingExampleState extends State<TextAddingExample> {
  TextEditingController titleController = TextEditingController();
  TextEditingController ContentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Text',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () async {
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> echonoteInfoMap = {
                  "title": titleController.text,
                  "contents": ContentsController.text,
                  "id": id,
                };
                setState(() {
                  titleController.clear();
                  ContentsController.clear();
                  Navigator.pop(context);
                });
                await DataBase.addText(echonoteInfoMap, id);
              },
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 10,
              controller: ContentsController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contents',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
