import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/announce.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:crypto_wallet/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<String> SignIn(String email, String password) async {
  String value;
  try {
    var credentials = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credentials.user.uid;
  } catch (e) {
    print(e);
    return "false";
  }
}

Future<bool> Register(String email, String password, String statut) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {

      Firestore.instance.collection("Users").doc(value.user.uid).setData(
          {'name': value.user.displayName, 'email': email, 'statut': statut}).catchError((e) {
        print(e);
      });

    });
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    String uid = FirebaseAuth.instance.currentUser.uid;
    var value = double.parse(amount);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Coins")
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshots = await transaction.get(documentReference);
      if (!snapshots.exists) {
        documentReference.set({"Amount": value});
        return true;
      }
      double newAmount = snapshots.data()['Amount'] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
  } catch (e) {
    return false;
  }
}

Future<bool> removeCoin(String id) async {
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}

Future<List<Professor>> getListCourses() async {
  print("you are in here");
  List<Course> newList1 = [];
  List<Professor> newList2 = [];
  // List<Widget> newList=[];

  Course featureData1;
  Professor featureData2;
  String uid = FirebaseAuth.instance.currentUser.uid;

  final profRef = Firestore.instance.collection("Professors");
  profRef.getDocuments().then((QuerySnapshot querySnapshot) {
    querySnapshot.documents.forEach((DocumentSnapshot doc) async {
      print(doc.id);

      profRef.document(doc.id).get().then((DocumentSnapshot document) async {
        QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
            .collection("Professors")
            .doc(doc.id)
            .collection("formations")
            .get();
        featureSnapShot1.docs.forEach(
          (element) {
            featureData1 = Course(
              description: element.data()["description"],
              category: element.data()['category'],
            );
            print(featureData1);
            newList1.add(featureData1);
          },
        );
        print("listCourses");

        print(document.exists);
        print(document.id);
        print(document.data()['image']);
        featureData2 = Professor(
          name: document.data()["name"],
          formation: document.data()["formation"],
          category: document.data()["category"],
          image: document.data()["image"],
          course: featureData1,
        );
        print(featureData2.course);
        newList2.add(featureData2);
        print("docuement");
        print(newList2);
        // return newList2;
      });
    });
    // AsyncSnapshot.waiting();
  });
  print("nex list courses $newList2");
  return newList2;
}

Future<List<Professor>> getListProf() async {
  List<Professor> newList = [];
  // List<Widget> newList=[];
  Professor featureData;
  String id;
  String uid = FirebaseAuth.instance.currentUser.uid;
  // var docRef = db.collection("cities").doc("SF");
  QuerySnapshot featureSnapShot =
      await FirebaseFirestore.instance.collection("Professors").get();

  featureSnapShot.docs.forEach(
    (element) {
      featureData = Professor(
          name: element.data()["name"],
          formation: element.data()["formation"],
          category: element.data()["category"],
          image: element.data()["image"],
          profession: element.data()["profession"],
          course: new Course(description: "description", category: "category"));
      // final documentID = userDocument.documentID;
      newList.add(featureData);
    },
  );
  // print(newList[0].category);
  return newList;
}

Future<List<Professor>> getListProfByCategory(String category) async {
  List<Professor> newList = [];
  // List<Widget> newList=[];
  Professor featureData;
  // String uid = FirebaseAuth.instance.currentUser.uid;
  if (category == 'All') {
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("Professors").get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Professor(
            name: element.data()["name"],
            formation: element.data()["formation"],
            category: element.data()["category"],
            image: element.data()["image"],
            course:
                new Course(description: "description", category: "category"));

        newList.add(featureData);
      },
    );
  } else {
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("Professors")
        .where('category', isEqualTo: category)
        .get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Professor(
            name: element.data()["name"],
            formation: element.data()["formation"],
            category: element.data()["category"],
            image: element.data()["image"],
            course:
                new Course(description: "description", category: 'category'));

        newList.add(featureData);
      },
    );
  }

  return newList;
}

Future<List<Professor>> queryData(String queryData) async {
  Professor featureData;
  List<Professor> newList = [];
  print(queryData.toLowerCase());
  String firstLetterCapital =
      queryData.substring(0, 1).toUpperCase() + queryData.substring(1);
  print(firstLetterCapital);
  QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
      .collection("Professors")
      .where('nom_formation', isGreaterThanOrEqualTo: queryData.toUpperCase())
      .get();
  featureSnapShot.docs.forEach(
    (element) {
      featureData = Professor(
          name: element.data()["name"],
          formation: element.data()["formation"],
          category: element.data()["category"],
          image: element.data()["image"],
          course: new Course(description: "description", category: "category"));

      newList.add(featureData);
    },
  );
  print(newList[0].formation);
  return newList;
}

Future<List<Professor>> getDispoProfessor(String queryData) async {
  Professor featureData;
  List<Professor> newList = [];
  print(queryData.toLowerCase());
  String firstLetterCapital =
      queryData.substring(0, 1).toUpperCase() + queryData.substring(1);
  print(firstLetterCapital);
  QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
      .collection("Professors")
      .where('name', isGreaterThanOrEqualTo: firstLetterCapital)
      .get();
  featureSnapShot.docs.forEach(
    (element) {
      featureData = Professor(
          name: element.data()["name"],
          formation: element.data()["formation"],
          category: element.data()["category"],
          image: element.data()["image"],
          profession: element.data()["profession"],
          course: new Course(description: "description", category: 'category'));

      newList.add(featureData);
    },
  );
  print(newList[0].formation);
  return newList;
}

Future<List<Professor>> getListCoursesByCategory(String category) async {
  print("you are in here");
  List<Course> newList1 = [];
  List<Professor> newList2 = [];
  Course featureData1;
  Professor featureData2;
  String uid = FirebaseAuth.instance.currentUser.uid;
  final profRef = Firestore.instance.collection("Professors");
  profRef.getDocuments().then((QuerySnapshot querySnapshot) {
    querySnapshot.documents.forEach((DocumentSnapshot doc) async {
      print(doc.id);
      QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
          .collection("Professors")
          .doc(doc.id)
          .collection("formations")
          .where('category', isEqualTo: category)
          .get();

      profRef.document(doc.id).get().then((DocumentSnapshot document) {
        featureData2 = Professor(
          name: document.data()["name"],
          formation: document.data()["formation"],
          category: document.data()["category"],
          image: document.data()["image"],
          course: featureData1,
        );

        newList2.add(featureData2);
      });
      featureSnapShot1.docs.forEach(
        (element) {
          featureData1 = Course(
            description: element.data()["description"],
            category: element.data()['category'],
          );

          newList1.add(featureData1);
        },
      );
    });
  });

  return newList2;
}

Future<List<Announce>> getAnnounceList() async {
  print("you are in here");

  List<Announce> newList2 = [];

  Announce featureData1;

  String uid = FirebaseAuth.instance.currentUser.uid;

  QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
      .collection("Users")
      .doc(uid)
      .collection("announce")
      .get();
  featureSnapShot1.docs.forEach(
    (element) {
      featureData1 = Announce(
        description: element.data()["description"],
        category: element.data()['category'],
        id: element.data()['id'],
      );
      print(featureData1);
    },
  );

//         // return newList2;
//       });

//     });
//   }

// );
  return newList2;
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
            .doc(element.documentID)
            .delete();
      }
    },
  );
  return true;
}
