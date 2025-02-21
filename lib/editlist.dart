import 'package:echonote_new/database.dart';

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class ListEditScreen extends StatefulWidget {
  final String title;
  final List<dynamic> content;
  final String id;
  const ListEditScreen(
      {super.key,
      required this.title,
      required this.content,
      required this.id});
  @override
  State<ListEditScreen> createState() => _ListEditScreenState();
}

class _ListEditScreenState extends State<ListEditScreen> {
  late TextEditingController listC;
  late TextEditingController addList;
  late TextEditingController editListC;
  int? _editingIndex;

  void _removeList(int index) {
    setState(() {
      _listS.removeAt(index);
    });
  }

  void initState() {
    super.initState();
    listC = TextEditingController(text: widget.title);
    addList = TextEditingController();
    editListC = TextEditingController();
    _listS = List<String>.from(widget.content);
  }

  @override
  void dispose() {
    listC.dispose();
    addList.dispose();
    editListC.dispose();
    super.dispose();
  }

  List<String> _listS = [];
  
  void _addTextToList() {
    setState(() {
      if (addList.text.isNotEmpty) {
        _listS.add(addList.text);
        addList.clear();
      }
    });
  }

  void _editList(int index) {
    setState(() {
      _editingIndex = index;
      editListC.text = _listS[index];
    });
  }

  void _saveEditedItem() {
    if (_editingIndex != null && editListC.text.isNotEmpty) {
      setState(() {
        _listS[_editingIndex!] = editListC.text;
        _editingIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Edit List",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  
                  Map<String, dynamic> updateInfo = {
                    "title": listC.text,
                    "content": _listS,
                    
                  };
                  await DataBase.updateListDetails(widget.id, updateInfo);
                  Navigator.of(context).pop();
                  listC.clear();
                  addList.clear();
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
                controller: listC,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label: Text("Title", style: TextStyle(color: Colors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: addList,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          _addTextToList();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                        )),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    label: Text("Add to List",
                        style: TextStyle(color: Colors.green)),
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: _listS.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: _editingIndex == index
                              ? TextField(
                                  controller: editListC,
                                  decoration: InputDecoration(
                                      labelText: 'Edit Item',
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                )
                              : Text(_listS[index]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _editList(index);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _removeList(index);
                                },
                                icon: Icon(Icons.cancel_outlined),
                              ),
                              if (_editingIndex == index)
                                IconButton(
                                  onPressed: () {
                                    _saveEditedItem();
                                  },
                                  icon: Icon(Icons.save, color: Colors.black),
                                ),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}