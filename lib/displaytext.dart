import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echonote_new/database.dart';
import 'package:echonote_new/edittext.dart';
import 'package:flutter/material.dart';

class DisplayText extends StatefulWidget {
  const DisplayText({super.key});

  @override
  State<DisplayText> createState() => _DisplayTextState();
}

class _DisplayTextState extends State<DisplayText> {
  Stream<QuerySnapshot>? textStream;

  getontheload() async {
    textStream = await DataBase.getTextDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allTextDetails() {
    return StreamBuilder(
        stream: textStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("An Error has occured ${snapshot.error}");
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Data is not available"));
          }
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 2),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot Ds = snapshot.data!.docs[index];
                    return Container(
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 201, 235, 133),
                          border: Border.all(width: 0.8, color: Colors.white)),
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "" + (Ds["title"] ?? "N/A"),
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                      
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "" + (Ds["contents"] ?? "N/A"),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditTextScreen(
                                                        title: Ds['title'],
                                                        content: Ds['contents'],
                                                        id: Ds["id"])));

                                      },
                                      child: Icon(Icons.edit,
                                          color: Colors.black)),
                                  GestureDetector(
                                      onTap: () async {
                                        
                                        await DataBase.deleteTextDetails(
                                            Ds["id"]);
                                          
                                      },
                                      child: Icon(Icons.delete,
                                          color: Colors.black)),
                                ],
                              ),
                            ],
                          )),
                    );
                  }));
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: allTextDetails(),
    );
  }
}
