import 'package:flutter/material.dart';

class Course {
   String category;
   String description;
   String createur;
   String date_sortie;
   String langue;
   String nom_formation;
   String prix;
   String image;
   String nombre_participants;
   String prerequis;
   String id; 
   String video;
   String duree;


  Course({@required this.description,@required this.category,this.createur,this.date_sortie,this.duree,this.langue,this.image,this.prix,this.nombre_participants,this.nom_formation,this.id,this.prerequis,this.video});
}