import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class DatabaseService {
  // final String uid;
  // UserCredential result;

  // DatabaseService({this.uid});
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> addAnnounceData(Map profData) async {
    final User user = auth.currentUser;
    String announceId = randomAlphaNumeric(16);
    final uid = user.uid;
    await Firestore.instance
        .collection("Users")
        .doc(uid)
        .collection("announce")
        .doc(announceId)
        .setData(profData)
        .catchError((e) {
      print(e);
    });
  }

  getAnnounceData() async {
    return await Firestore.instance.collection("announce").snapshots();
  }

  Future<bool> removeAnnounce(String id) async {
    print(id);
    String uid = FirebaseAuth.instance.currentUser.uid;

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("announce")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        if (element.data()['id'] == id) {
          print(element.documentID);
          print("here delete");
          FirebaseFirestore.instance
              .collection("Users")
              .doc(uid)
              .collection("announce")
              .doc(element.id)
              .delete();
        }
      },
    );
    return true;
  }

  Future<void> setAnnounceData(Map profData, String announceId) async {
    final User user = auth.currentUser;
    // String announceId = randomAlphaNumeric(16);
    final uid = user.uid;
    print(profData['id']);
    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("announce")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        if (element.data()['id'] == profData['id']) {
          Firestore.instance
              .collection("Users")
              .doc(uid)
              .collection("announce")
              .doc(element.id)
              .setData(profData)
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
