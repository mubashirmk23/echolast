
import 'package:echonote_new/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class TaskAddingExample extends StatefulWidget {
  @override
  State<TaskAddingExample> createState() => _TaskAddingExampleState();
}

class _TaskAddingExampleState extends State<TaskAddingExample> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime datetime=DateTime.now();

  @override
  Widget build(BuildContext context) {
    final date="${datetime.day}/${datetime.month}/${datetime.year}";
    final time="${datetime.hour}:${datetime.minute}";
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
                  "description": descriptionController.text,
                  "date":date,
                  "time":time,
                  "id":id,
                };
                setState(() {
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pop(context);
                });
                await DataBase.addTask(echonoteInfoMap, id);
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
              maxLines: 8,
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            SizedBox(height:10),
            Row(
              children: [
                Text("${date}"),
                Spacer(),
                Text("${time}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

