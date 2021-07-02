

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:flutter/cupertino.dart';

Future<List<Course>> getListFormations() async{
  print("FUNCTION GETLISTFORMATION IS LOADDINGG");
  List<Course> list=[ new Course(description: "description", category: "categorie", createur: "createur", date_sortie: "date_sortie", langue: "langue", nom_formation: "nom_formation", prix: "prix", image: "image", nombre_participants: "nombre_participants")];
  Course featureData;


return list;
}