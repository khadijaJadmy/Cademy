// import 'package:crypto_wallet/firestore/announceController.dart';
// import 'package:crypto_wallet/model/course.dart';

// import 'package:flutter/material.dart';
// import 'package:select_form_field/select_form_field.dart';
// //import 'databse.dart' as Cours;
// // import 'databse.dart';
// import 'myCourses.dart';
// import 'databse.dart' as D;

// class UpdateCourse extends StatefulWidget {
//   final Course course;
//   const UpdateCourse({Key key, this.course}) : super(key: key);

//   @override
//   _UpdateCourseState createState() => _UpdateCourseState();
// }

// class _UpdateCourseState extends State<UpdateCourse> {
//   String query;

//   bool progress = false;
//   TextEditingController queryTextEditingController =
//       new TextEditingController();
//   TextEditingController priceController = new TextEditingController();
//   TextEditingController descriptionController = new TextEditingController();
//   TextEditingController titleController = new TextEditingController();
//   TextEditingController prerequisController = new TextEditingController();
//   TextEditingController dureeController = new TextEditingController();
//   TextEditingController langueController = new TextEditingController();
//   TextEditingController categoryController = new TextEditingController();

//   ScrollController scrollController = new ScrollController();

//   String description, price, prerequis, title, category;
//   D.DatabaseService databaseService = new D.DatabaseService();

//   bool isLoading = false;
//   final snackBar = SnackBar(
//     content: Text('Update done successfully!'),
//     backgroundColor: Colors.green,
//   );

//   void updateCourse() async {
//     // if (_formKey.currentState.validate()) {
//     print("YOU ARE INSIDE UPDATE");
//     Map<String, String> courseData = {
//       "id": widget.course.id,
//       "description": descriptionController.text != ""
//           ? descriptionController.text
//           : widget.course.description,
//       "title": titleController.text != ""
//           ? titleController.text
//           : widget.course.nom_formation,
//       "price": priceController.text != ""
//           ? priceController.text
//           : widget.course.prix,
//       "prerequis": prerequisController.text != ""
//           ? prerequisController.text
//           : widget.course.prerequis,
//       "langue": langueController.text != ""
//           ? langueController.text
//           : widget.course.langue,
//       "duree": dureeController.text != ""
//           ? dureeController.text
//           : widget.course.duree,
//       // "category": categoryController.text != ""
//       //     ? categoryController.text
//       //     : widget.course.category
//     };
//     print(courseData);
//     databaseService.setCourseData(courseData, widget.course.id).then((value) {
//       print('dkhalt');
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);

//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => CourseList()));
//     });
//   }

//   @override
//   Future<void> initState() {
//     super.initState();

//     setState(() {
//       descriptionController.text = widget.course.description;
//       titleController.text = widget.course.nom_formation;
//       priceController.text = widget.course.prix;
//       prerequisController.text = widget.course.prerequis;
//       dureeController.text = widget.course.duree;
//       langueController.text = widget.course.langue;
//       categoryController.text = widget.course.category;
//     });
//   }

//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: buildAppBar(),
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           padding: const EdgeInsets.all(6),
//           child: Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         titleTextField(),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         priceTextField(),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         descriptionTextField(),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         prerequisTextField(),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         dureeTextField(),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         langueTextField(),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         // categoryTextField(),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             print("YOU HAVE JUST TAPPED TO UPDATE");
//                             updateCourse();
//                           },
//                           child: Container(
//                             width: 130,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Color(0xff09bdb4),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Submit",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//         ));
//   }

//   Widget descriptionTextField() {
//     return TextFormField(
//       controller: descriptionController,
//       maxLines: 4,
//       decoration: InputDecoration(

//           // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
//           // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
//           labelText: 'Description',
//           labelStyle: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Color(0xff09bdb4),
//             width: 1,
//           )),
//           hintStyle: TextStyle(
//             fontSize: 14,
//             // fontWeight: FontWeight.bold,

//             color: Colors.grey,
//           )),
//     );
//   }

//   Widget priceTextField() {
//     return TextFormField(
//       controller: priceController,
//       decoration: InputDecoration(

//           // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
//           // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
//           labelText: 'Price',
//           labelStyle: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Color(0xff09bdb4),
//             width: 1,
//           )),
//           hintStyle: TextStyle(
//             fontSize: 14,
//             // fontWeight: FontWeight.bold,

//             color: Colors.grey,
//           )),
//     );
//   }

//   Widget titleTextField() {
//     return TextFormField(
//       controller: titleController,
//       decoration: InputDecoration(

//           // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
//           // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
//           labelText: 'Title',
//           labelStyle: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Color(0xff09bdb4),
//             width: 1,
//           )),
//           hintStyle: TextStyle(
//             fontSize: 14,
//             // fontWeight: FontWeight.bold,

//             color: Colors.grey,
//           )),
//     );
//   }

//   Widget prerequisTextField() {
//     return TextFormField(
//       controller: prerequisController,
//       maxLines: 4,
//       decoration: InputDecoration(

//           // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
//           // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
//           labelText: 'Prerequis',
//           labelStyle: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Color(0xff09bdb4),
//             width: 1,
//           )),
//           hintStyle: TextStyle(
//             fontSize: 14,
//             // fontWeight: FontWeight.bold,

//             color: Colors.grey,
//           )),
//     );
//   }

//   Widget dureeTextField() {
//     return TextFormField(
//       controller: dureeController,
//       decoration: InputDecoration(
//           labelText: "Duration",
//           labelStyle: TextStyle(
//             color: Colors.black.withOpacity(1),
//             fontWeight: FontWeight.w600,
//             fontSize: 23,
//           ),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: 'Duration',
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Colors.blue,
//             width: 1,
//           )),
//           hintStyle: TextStyle(
//             fontSize: 14,
//             color: Colors.black.withOpacity(0.8),
//           )),
//     );
//   }

//   Widget langueTextField() {
//     return TextFormField(
//       controller: langueController,
//       decoration: InputDecoration(
//           labelText: "Language",
//           labelStyle: TextStyle(
//             color: Colors.black.withOpacity(1),
//             fontWeight: FontWeight.w600,
//             fontSize: 23,
//           ),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: 'Choose a language',
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Color(0xff09bdb4),
//             width: 1,
//           )),
//           hintStyle: TextStyle(
//             fontSize: 14,
//             color: Colors.black.withOpacity(0.8),

//             // fontWeight: FontWeight.bold,
//           )),
//     );
//   }

//   final List<Map<String, dynamic>> _items = [
//     {
//       'value': 'Design',
//       'label': 'Design',
//     },
//     {
//       'value': 'Developpement web',
//       'label': 'Developpement web',
//     },
//     {
//       'value': 'Developpement mobile',
//       'label': 'Developpement mobile',
//     },
//     {
//       'value': 'Finance et Comptabilité',
//       'label': 'Finance et Comptabilité',
//     },
//     {
//       'value': 'Business',
//       'label': 'Business',
//     },
//     {
//       'value': 'Marketing',
//       'label': 'Marketing',
//     },
//     {
//       'value': 'Maths',
//       'label': 'Maths',
//     },
//     {
//       'value': 'Physics',
//       'label': 'Physics',
//     },
//     {
//       'value': ' Santé',
//       'label': 'Santé',
//     },
//   ];
//   Widget categoryTextField() {
//     return SelectFormField(
//       validator: (val) => val.isEmpty ? "category" : null,
//       controller: categoryController,
//       items: _items,
//       onChanged: (val) {
//         print(val);
//         setState(() {
//           category = val;
//         });
//       },
//       onSaved: (val) {
//         setState(() {
//           category = val;
//         });
//       },
//       decoration: InputDecoration(

//           // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
//           // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
//           // labelText: "Video",
//           labelText: "Category",
//           labelStyle: TextStyle(
//             color: Colors.black.withOpacity(1),
//             fontWeight: FontWeight.w600,
//             fontSize: 23,
//           ),
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: 'Category',
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//             color: Color(0xff09bdb4),
//             width: 1,
//           )),
//           hintStyle: TextStyle(
//             fontSize: 14,
//             color: Colors.black.withOpacity(0.8),
//             // fontWeight: FontWeight.bold,
//           )),
//     );
//   }

//   _showSnakBar(String msg) {
//     Scaffold.of(context).showSnackBar(
//       SnackBar(
//         content: Text(msg),
//       ),
//     );
//   }

//   AppBar buildAppBar() {
//     return AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           'Update Course',
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black45,
//             size: 30,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ));
//   }
// }
import 'package:crypto_wallet/model/course.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'databse.dart';
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
  TextEditingController videoController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();
  TextEditingController categoryController = new TextEditingController();
  TextEditingController dureeController = new TextEditingController();
  TextEditingController langueController = new TextEditingController();
  // TextEditingController category = new TextEditingController();
  ScrollController scrollController = new ScrollController();

  String description, price, prerequis, title, category;

  bool isLoading = false;

  DatabaseService databaseService = new DatabaseService();
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
        "nom_formation": titleController.text != ""
            ? titleController.text
            : widget.course.nom_formation,
        "prix": priceController.text != ""
            ? priceController.text
            : widget.course.prix,
        "prerequis": prerequisController.text != ""
            ? prerequisController.text
            : widget.course.prerequis,
        "langue": langueController.text != ""
            ? langueController.text
            : widget.course.langue,
        "duree": dureeController.text != ""
            ? dureeController.text
            : widget.course.duree,
        // "video": videoController.text != ""
        //     ? videoController.text
        //     : widget.course.video,
        "image": widget.course.image,
        "category": categoryController.text != ""
            ? categoryController.text
            : widget.course.category,
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
      dureeController.text = widget.course.duree;
      langueController.text = widget.course.langue;
      categoryController.text = widget.course.category;
      // videoController.text = widget.course.video;
      // imageController.text = widget.course.image;
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Row(
              // Row(
              children: [
                Text(
                  "Update ",
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
                Row(
                  children: [
                    Text(
                      "Course",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ],
                )
              ],
            ),
            // // Spacer(),
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 70,
            //     ),
            //     Text(
            //       "Course",
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 35,
            //       ),
            //     ),
            //   ],
            // ),

            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black45,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => CourseList()));
              },
            )),
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(6),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Update ",
                        //       style: TextStyle(
                        //           color: Colors.black87, fontSize: 20),
                        //     ),
                        //   ],
                        // ),
                        // // Spacer(),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: 70,
                        //     ),
                        //     Text(
                        //       "Course",
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 35,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        titleTextField(),
                        SizedBox(
                          height: 30,
                        ),
                        // imageTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        // videoTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        descTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        prerequisTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        priceTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        dureeTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        langueTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        categoryTextField(),
                        SizedBox(
                          height: 20,
                        ),

                        // child: Container(
                        //   width: 130,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     color: Colors.green[300],
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: Center(
                        //     child: Text(
                        //       "Update",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 130,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  updateCourse();
                                },
                                child: Container(
                                  width: 130,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(9, 189, 180, 1),
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
                      ],
                    ),
                  )),
                ))));
  }

  Widget dureeTextField() {
    return TextFormField(
      controller: dureeController,
      decoration: InputDecoration(
          labelText: "Duration",
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(1),
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Duration',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.8),
          )),
    );
  }

  Widget imageTextField() {
    return TextFormField(
      controller: imageController,
      decoration: InputDecoration(
          labelText: "Image URL",
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(1),
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Image URL',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.8),
          )),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
        // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
        labelText: "Title",
        labelStyle: TextStyle(
          color: Colors.black.withOpacity(1),
          fontWeight: FontWeight.w600,
          fontSize: 23,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'Title',
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xff09bdb4),
          width: 1,
        )),
      ),
    );
  }

  Widget videoTextField() {
    return TextFormField(
      controller: videoController,
      maxLines: 2,
      decoration: InputDecoration(
          labelText: "Video Url",
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(1),
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Video URL',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.8),
          )),
    );
  }

  Widget langueTextField() {
    return TextFormField(
      controller: langueController,
      decoration: InputDecoration(
          labelText: "Language",
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(1),
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Choose a language',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.8),

            // fontWeight: FontWeight.bold,
          )),
    );
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Design',
      'label': 'Design',
    },
    {
      'value': 'Developpement web',
      'label': 'Developpement web',
    },
    {
      'value': 'Developpement mobile',
      'label': 'Developpement mobile',
    },
    {
      'value': 'Finance et Comptabilité',
      'label': 'Finance et Comptabilité',
    },
    {
      'value': 'Business',
      'label': 'Business',
    },
    {
      'value': 'Marketing',
      'label': 'Marketing',
    },
    {
      'value': 'Maths',
      'label': 'Maths',
    },
    {
      'value': 'Physics',
      'label': 'Physics',
    },
    {
      'value': ' Santé',
      'label': 'Santé',
    },
  ];
  Widget categoryTextField() {
    return SelectFormField(
      validator: (val) => val.isEmpty ? "category" : null,
      controller: categoryController,
      labelText: 'Maths',
      items: _items,
      onChanged: (val) {
        print(val);
        setState(() {
          category = val;
        });
      },
      onSaved: (val) {
        setState(() {
          category = val;
        });
      },
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          // labelText: "Video",
          labelText: "Category",
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(1),
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Category',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.8),
            // fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget descTextField() {
    return TextFormField(
      controller: descriptionController,
      maxLines: 4,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          // labelText: "Video",
          labelText: "Description",
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(1),
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Description',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.8),
          )),
    );
  }

  Widget priceTextField() {
    return TextFormField(
      controller: priceController,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          // labelText: "Video",
          labelText: "Price",
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(1),
            fontWeight: FontWeight.w600,
            fontSize: 23,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Price',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.8),
          )),
    );
  }

  Widget prerequisTextField() {
    return TextFormField(
        controller: prerequisController,
        maxLines: 4,
        decoration: InputDecoration(

            // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
            // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
            // labelText: "Video",
            labelText: "Requirements",
            labelStyle: TextStyle(
              color: Colors.black.withOpacity(1),
              fontWeight: FontWeight.w600,
              fontSize: 23,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: 'Requirements',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Color(0xff09bdb4),
              width: 1,
            )),
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
            )));
  }

  // void _showPicker(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return SafeArea(
  //           child: Container(
  //             child: new Wrap(
  //               children: <Widget>[
  //                 new ListTile(
  //                     leading: new Icon(Icons.video_library),
  //                     title: new Text('Photo Gallery'),
  //                     onTap: () {
  //                       getImage(source: ImageSource.gallery);
  //                       Navigator.of(context).pop();
  //                     }),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  // i.File _pickedVideo;

  // Future<void> getImage({ImageSource source}) async {
  //   final video = await ImagePicker.pickVideo(source: source);
  //   if (video != null) {
  //     setState(() {
  //       _pickedVideo = i.File(video.path);
  //     });
  //   }
  // }
}
