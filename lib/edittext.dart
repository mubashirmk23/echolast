import 'package:echonote_new/database.dart';
import 'package:flutter/material.dart';



class EditTextScreen extends StatefulWidget {
  final String title;
  final String content;
  final String id;

  const EditTextScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.id});

  @override
  State<EditTextScreen> createState() => _EditTextScreenState();
}

class _EditTextScreenState extends State<EditTextScreen> {
  late TextEditingController title;
  late TextEditingController content;

  void initState() {
    super.initState();
    title = TextEditingController(text: widget.title);
    content = TextEditingController(text: widget.content);
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
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
            "Edit Note",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () async {
                 
                  Map<String, dynamic> updateInfo = {
                    "title": title.text,
                    "contents": content.text,
                  
                  };
                  await DataBase.updateTextDetails(widget.id,updateInfo);

                  Navigator.pop(context);
                  title.clear();
                  content.clear();
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
                maxLines: 10,
                controller: content,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label:
                        Text("Content", style: TextStyle(color: Colors.green)),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              )
            ],
          ),
        ));
  }
}
