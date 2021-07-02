import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class StudentService {
  // final String uid;
  // UserCredential result;

  // DatabaseService({this.uid});
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> addStudentsData(Map studentData) async {
    final User user = auth.currentUser;
    String uid = FirebaseAuth.instance.currentUser.uid;
    print("INSIDE ADD STUDENT FUNCTION");
    await Firestore.instance
        .collection("Students")
        .doc(uid)
        .setData(studentData)
        .catchError((e) {
      print(e);
    });
  }

  getAnnounceData() async {
    return await Firestore.instance.collection("announce").snapshots();
  }

  Future<void> setStudentData(Map studentData, String studentId) async {
    final User user = auth.currentUser;
    // String announceId = randomAlphaNumeric(16);
    final uid = user.uid;
    print(studentData['id']);
    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("announce")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        if (element.data()['id'] == studentData['id']) {
          Firestore.instance
              .collection("Users")
              .doc(uid)
              .collection("announce")
              .doc(element.id)
              .setData(studentData)
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
