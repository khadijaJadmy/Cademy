import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // final String uid;
  // UserCredential result;

  // DatabaseService({this.uid});
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> addProfData(Map profData, String profId) async {
    final User user = auth.currentUser;
    final uid = user.uid;
    await Firestore.instance
        .collection("Professors")
        .document(uid)
        .setData(profData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addCourseData(profData, String profId) async {
    final User user = auth.currentUser;
    final uid = user.uid;
    await Firestore.instance
        .collection("Professors")
        .document(uid)
        .collection("formations")
        .add(profData)
        .catchError((e) {
      print(e);
    });
  }

  getProfData() async {
    return await Firestore.instance.collection("Professors").snapshots();
  }

  getCourseData(String profId) async {
    final User user = auth.currentUser;
    final uid = user.uid;
    return await Firestore.instance
        .collection("Professors")
        .document(profId)
        .collection("formations")
        .getDocuments();
  }

  Future<bool> removeCourse(String id) async {
    print(id);
    String uid = FirebaseAuth.instance.currentUser.uid;

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Professors")
        .doc(uid)
        .collection("formations")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        if (element.data()['id'] == id) {
          FirebaseFirestore.instance
              .collection("Professors")
              .doc(uid)
              .collection("formations")
              .doc(element.id)
              .delete();
        }
      },
    );
    return true;
  }

  Future<void> setCourseData(Map courseData, String courseId) async {
    final User user = auth.currentUser;
    // String announceId = randomAlphaNumeric(16);
    final uid = user.uid;
    print(courseData['id']);
    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Professors")
        .doc(uid)
        .collection("formations")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        if (element.data()['id'] == courseData['id']) {
          Firestore.instance
              .collection("Professors")
              .doc(uid)
              .collection("formations")
              .doc(element.id)
              .setData(courseData)
              .catchError((e) {
            print(e);
          });
        }
      },
    );
    //   .doc(profData['id'])
    //   .setData(profData)
    //   .catchError((e) {
    // print(e);
    // });
  }
}
