import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/course.dart';
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

  Future<bool> removeCours(String id) async {
    print(id);
    String uid = FirebaseAuth.instance.currentUser.uid;

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("professors")
        .doc(uid)
        .collection("formations")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        if (element.data()['id'] == id) {
          print(element.documentID);

          FirebaseFirestore.instance
              .collection("professors")
              .doc(uid)
              .collection("formations")
              .doc(element.documentID)
              .delete();
        }
      },
    );
    return true;
  }

  Future<List<Course>> queryData() async {
    Professor featureData;
    List<Professor> newList = [];
    String queryData = "PYTHON";
    print(queryData.toUpperCase());
    print("RAE WE HER");
    List<Course> newList1 = [];
    List<Professor> newList2 = [];
    Course featureData1;
    Professor featureData2;
    String uid = FirebaseAuth.instance.currentUser.uid;
    int index = 0;
    // final profRef = Firestore.instance.collection("Professors");
    // profRef.getDocuments().then((QuerySnapshot querySnapshot) {
    // querySnapshot.documents.forEach((DocumentSnapshot doc) async {
    // profRef.document(doc.id).get().then((DocumentSnapshot document) async {
    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Professors")
        .doc(uid)
        .collection("formations")
        .where('nom_formation', isEqualTo: queryData.toUpperCase())
        .get();
    featureSnapShot1.docs.forEach((element) {
      featureData1 = Course(
        description: element.data()["description"],
        category: element.data()['category'],
        nom_formation: element.data()["nom_formation"],
        prix: element.data()["prix"],
        date_sortie: element.data()["date_sortie"],
        langue: element.data()["langue"],
        image: element.data()["image"],
        nombre_participants: element.data()["nombre_participants"],
      );

      // setState(() {
      newList1.add(featureData1);
      print(featureData2.course.category);
      // index++;
      // });
    });
    print("THHHHHEE END OF SEARCH");
    print(newList1);
    return newList1;

    // });
    // });
    // });
  }

  Future<void> setCourseData(Map courseData, String courseId) async {
    final User user = auth.currentUser;
    // String announceId = randomAlphaNumeric(16);
    final uid = user.uid;
    print(courseData['id']);
    print("DKHOLL");
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
