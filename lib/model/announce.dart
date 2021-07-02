import 'package:flutter/material.dart';

class Announce {
  final String id;
  final String description;
  final String category;
  String title;


  Announce({@required this.id,@required this.description,@required this.category, this.title});
}