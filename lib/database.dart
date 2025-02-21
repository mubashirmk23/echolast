import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  
  static Future addText(Map<String, dynamic> textInfoMap, String id) {
    return FirebaseFirestore.instance
        .collection('TextNew')
        .doc(id)
        .set(textInfoMap);
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getTextDetails() {
    return FirebaseFirestore.instance.collection('TextNew').snapshots();
  }
   static Future<void> deleteTextDetails(String id) {
    return FirebaseFirestore.instance.collection('TextNew').doc(id).delete();
  }

  static Future<void> updateTextDetails(
      String id, Map<String, dynamic> updateInfo) {
    return FirebaseFirestore.instance
        .collection("TextNew")
        .doc(id)
        .update(updateInfo);
  }

  //Task

  static Future addTask(Map<String, dynamic> taskInfoMap, String id) {
    return FirebaseFirestore.instance
        .collection('TaskNew')
        .doc(id)
        .set(taskInfoMap);
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getTaskDetails() {
    return FirebaseFirestore.instance.collection('TaskNew').snapshots();
  }
   static Future<void> deleteTaskDetails(String id) {
    return FirebaseFirestore.instance.collection('TaskNew').doc(id).delete();
  }

  static Future<void> updateTaskDetails(
      String id, Map<String, dynamic> updateInfo) {
    return FirebaseFirestore.instance
        .collection("TaskNew")
        .doc(id)
        .update(updateInfo);
  }

  //List
   static Future addList(Map<String, dynamic> listInfoMap, String id) {
    return FirebaseFirestore.instance
        .collection('ListNew')
        .doc(id)
        .set(listInfoMap);
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getListDetails() {
    return FirebaseFirestore.instance.collection('ListNew').snapshots();
  }
   static Future<void> deleteListDetails(String id) {
    return FirebaseFirestore.instance.collection('ListNew').doc(id).delete();
  }

  static Future<void> updateListDetails(
      String id, Map<String, dynamic> updateInfo) {
    return FirebaseFirestore.instance
        .collection("ListNew")
        .doc(id)
        .update(updateInfo);
  }



}