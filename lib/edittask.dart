import 'package:echonote_new/database.dart';
import 'package:flutter/material.dart';


class EditTaskScreen extends StatefulWidget {
  final String title;
  final String description;
  final String id;

  const EditTaskScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.id});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController title;
  late TextEditingController description;
  DateTime datetime=DateTime.now();

  void initState() {
    super.initState();
    title = TextEditingController(text: widget.title);
    description = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
   final date="${datetime.day}/${datetime.month}/${datetime.year}";
    final time="${datetime.hour}:${datetime.minute}";
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Edit Task",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () async {
                 
                  Map<String, dynamic> updateInfo = {
                    "title": title.text,
                    "description": description.text,
                    "date":date,
                    "time":time,
                  
                  };
                  await DataBase.updateTaskDetails(widget.id,updateInfo);
                  Navigator.pop(context);
                  title.clear();
                  description.clear();
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label: Text("Title", style: TextStyle(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 8,
                controller: description,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label:
                        Text("Description", style: TextStyle(color: Colors.green)),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
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
        ));
  }
}
