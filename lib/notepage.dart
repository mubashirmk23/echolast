import 'package:echonote_new/addlist.dart';
import 'package:echonote_new/addtask.dart';
import 'package:echonote_new/addtext.dart';
import 'package:echonote_new/displaylist.dart';
import 'package:echonote_new/displaytask.dart';
import 'package:echonote_new/displaytext.dart';
import 'package:flutter/material.dart';

class Notepage extends StatefulWidget {
  @override
  State<Notepage> createState() => _notpage();
}

class _notpage extends State<Notepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Echo note',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightGreen,
          bottom: const TabBar(
              tabs: [
                Tab(text: 'Text'),
                Tab(text: 'List'),
                Tab(
                  text: 'Task',
                ),
              ],
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                DisplayText(),
                ListScreen(),
                DisplayTask(),
              ],
            )
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.lightGreen,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskAddingExample()));
              },
              child: Icon(Icons.check_circle),
              mini: true,
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              backgroundColor: Colors.lightGreen,
              onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ListAddingExample()));
              
              },
              child: Icon(Icons.check_box),
              mini: true,
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              backgroundColor: Colors.lightGreen,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TextAddingExample()));
              },
              child: Icon(Icons.menu),
            ),
          ],
        ),
      ),
    );
  }
}
