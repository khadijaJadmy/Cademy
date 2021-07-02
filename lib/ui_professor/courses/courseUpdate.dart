import 'package:crypto_wallet/firestore/announceController.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:crypto_wallet/ui_professor/courses/databse.dart';
import 'package:flutter/material.dart';
import 'databse.dart' as Cours;

import 'myCourses.dart';

class UpdateCourse extends StatefulWidget {
  final Course course;
  const UpdateCourse({Key key, this.course}) : super(key: key);

  @override
  _UpdateCourseState createState() => _UpdateCourseState();
}

class _UpdateCourseState extends State<UpdateCourse> {
  String query;

  bool progress = false;
  TextEditingController queryTextEditingController =
      new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  TextEditingController prerequisController = new TextEditingController();

  ScrollController scrollController = new ScrollController();

  String description, price, prerequis, title;

  bool isLoading = false;

  Cours.DatabaseService databaseService;
  final snackBar = SnackBar(
    content: Text('Update done successfully!'),
    backgroundColor: Colors.green,
  );

  void updateCourse() async {
    if (_formKey.currentState.validate()) {
      Map<String, String> courseData = {
        "id": widget.course.id,
        "description": descriptionController.text != ""
            ? descriptionController.text
            : widget.course.description,
        "title": titleController.text != ""
            ? titleController.text
            : widget.course.nom_formation,
        "price": priceController.text != ""
            ? priceController.text
            : widget.course.prix,
        "prerequis": prerequisController.text != ""
            ? prerequisController.text
            : widget.course.prerequis,
      };

      databaseService.setCourseData(courseData, widget.course.id).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CourseList()));
      });
    }
  }

  @override
  Future<void> initState() {
    super.initState();

    setState(() {
      descriptionController.text = widget.course.description;
      titleController.text = widget.course.nom_formation;
      priceController.text = widget.course.prix;
      prerequisController.text = widget.course.prerequis;
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(6),
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      titleTextField(),
                      SizedBox(
                        height: 30,
                      ),
                      priceTextField(),
                      SizedBox(
                        height: 20,
                      ),
                      descriptionTextField(),
                      SizedBox(
                        height: 20,
                      ),
                      prerequisTextField(),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          updateCourse();
                          progress = true;
                        },
                        child: Container(
                          width: 130,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget descriptionTextField() {
    return TextFormField(
        controller: descriptionController,
        maxLines: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Description",
        ));
  }

  Widget priceTextField() {
    return TextFormField(
        controller: priceController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Price",
        ));
  }

  Widget titleTextField() {
    return TextFormField(
        controller: titleController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Title",
        ));
  }

  Widget prerequisTextField() {
    return TextFormField(
        controller: prerequisController,
        maxLines: 4,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.orange,
            width: 2,
          )),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.green,
          ),
          labelText: "Prerequis",
        ));
  }

  _showSnakBar(String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Update Course',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
