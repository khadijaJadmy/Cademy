import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfessorsRepository {
  int PharmacyCount;
  Map<int, Professor> Pharmacys = {
    1: Professor(
        category: 'description',
        image: 'r_code.jpg',
        formation: 'casa',
        name: 'pharmacy1',
        course: new Course(description: "description", category: "category")),
  };

  PharmacysRepository() {
    this.PharmacyCount = Pharmacys.length;
  }

  Future allPharmacys() async {
    List<Professor> newList = [];
    Professor featureData;
    int index = 1;
    print("here i am stuck");
    print("you are in here");
    List<Course> newList1 = [];
    List<Professor> newList2 = [];
    // List<Widget> newList=[];

    String uid = FirebaseAuth.instance.currentUser.uid;
    Course featureData1;
    Professor featureData2;
    print("Process ......... LOADING");

    final profRef = Firestore.instance.collection("Professors");

    Firestore.instance.collection('Professors').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot doc) async {
        profRef.doc(doc.id).get().then(
          (DocumentSnapshot document) async {
          QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
              // querySnapshot.docs.forEach((result) {
              .collection("Professors")
              .doc(doc.id)
              .collection("formations")
              .get();
              // .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((result) {
              featureData1 = Course(
                description: result.data()["description"],
                category: result.data()['category'],
              );
              featureData2 = Professor(
                name: document.data()["name"],
                formation: document.data()["formation"],
                category: document.data()["category"],
                image: document.data()["image"],
                course: featureData1,
              );
              Pharmacys = {
                index: featureData2,
              };
              // return featureData1;
              print(Pharmacys);
            // });
            // return querySnapshot;
          });
          // featureSnapShot1.docs.forEach(
          //   (element) {
          //     featureData1 = Course(
          //       description: element.data()["description"],
          //       category: element.data()['category'],
          //     );
          //     // print(featureData1);
          //     newList1.add(featureData1);
          //   },
          // );
          // featureData2 = Professor(
          //   name: document.data()["name"],
          //   formation: document.data()["formation"],
          //   category: document.data()["category"],
          //   image: document.data()["image"],
          //   course: featureData1,
          // );
          // print(featureData2.course);
          // Pharmacys = {
          //   index: featureData2,
          // };
        });
      });
      if (newList != null) {
        print(Pharmacys.values.toList());
        return Pharmacys.values.toList();
      } else {
        throw new Exception('Internet Error');
      }
    });
  }

  // final profRef = Firestore.instance.collection("Professors");
  // profRef.getDocuments().then((QuerySnapshot querySnapshot) {
  //   querySnapshot.documents.forEach((DocumentSnapshot doc) async {
  //     // print(doc.id);

  //     profRef.document(doc.id).get().then((DocumentSnapshot document) async {
  //       QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
  //           .collection("Professors")
  //           .doc(doc.id)
  //           .collection("formations")
  //           .get();
  //       featureSnapShot1.docs.forEach(
  //         (element) {
  //           featureData1 = Course(
  //             description: element.data()["description"],
  //             category: element.data()['category'],
  //           );
  //           // print(featureData1);
  //           newList1.add(featureData1);
  //         },
  //       );
  // print("listCourses");

  // print(document.exists);
  // print(document.id);
  // print(document.data()['image']);
  //       featureData2 = Professor(
  //         name: document.data()["name"],
  //         formation: document.data()["formation"],
  //         category: document.data()["category"],
  //         image: document.data()["image"],
  //         course: featureData1,
  //       );
  //       // print(featureData2.course);
  //     Pharmacys = {
  //       index: featureData2,
  //     };
  //       // newList2.add(featureData2);
  //       // print("docuement");
  //       // print(newList2);

  //     });
  //   });
  //   // AsyncSnapshot.waiting();
  // });
  // print("Process ......... LOADED");

  //  return Pharmacys.values.toList();
  // print(newList);

  // if (newList != null) {
  //   print(Pharmacys.values.toList());
  //   return Pharmacys.values.toList();
  // } else {
  //   throw new Exception('Internet Error');
  // }

  // Future pharmacyByLocation(String location) async {}
}
