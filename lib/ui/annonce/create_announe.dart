import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/firestore/announceController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'dart:io' as i;

class CreateAnnounce extends StatefulWidget {
  @override
  _CreateAnnounceState createState() => _CreateAnnounceState();
}

class _CreateAnnounceState extends State<CreateAnnounce> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool circular = false;

  String name, profession, description, niveau, email;
  UserCredential result;

  bool isLoading = false;
  String profId;
  final FirebaseAuth auth = FirebaseAuth.instance;






  String userUid;

 

  bool centerCircle = false;
  var imageMap;

  void CreateProf() async {
    
   // profId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        centerCircle = true;
      });

     // imageMap = await _uploadImage(image: _pickedImage);

      Map<String, String> profData = {
    
        "category": profession,
        "description": description,
       
      };

      databaseService.addAnnounceData(profData).then((value) {
        setState(() {
          isLoading = false;
        });
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => 
        //     AddCourse(uid)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            children: <Widget>[
              SizedBox(
                height: 32,
              ),
          
              SizedBox(
                height: 20,
              ),
              nameTextField(),
              SizedBox(
                height: 20,
              ),
              professionTextField(),
              SizedBox(
                height: 20,
              ),
              descriptionTextField(),
              SizedBox(
                height: 20,
              ),
              emailTextField(),
              SizedBox(
                height: 20,
              ),
              niveauTextField(),
              GestureDetector(
                onTap: () {
                  CreateProf();
                  circular = true;
                },
                child: Container(
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: circular
                            ? CircularProgressIndicator()
                            : Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        
      ),
    );
  }

  // Widget bottomSheet() {
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: 20,
  //       vertical: 20,
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Text(
  //           "Choose Profile photo",
  //           style: TextStyle(
  //             fontSize: 20.0,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           FlatButton.icon(
  //             icon: Icon(Icons.camera),
  //             onPressed: () {
  //               takePhoto(ImageSource.camera);
  //             },
  //             label: Text("Camera"),
  //           ),
  //           FlatButton.icon(
  //             icon: Icon(Icons.image),
  //             onPressed: () {
  //               takePhoto(ImageSource.gallery);
  //             },
  //             label: Text("Gallery"),
  //           ),
  //         ])
  //       ],
  //     ),
  //   );
  // }

  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.getImage(
  //     source: source,
  //   );
  //   setState(() {
  //     _imageFile = pickedFile;
  //   });
  // }

  Widget nameTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "Enter your name " : null,
      onChanged: (val) {
        name = val;
      },
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
        labelText: "Name",
        helperText: "Name can't be empty",
      ),
    );
  }

  Widget professionTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? " profession" : null,
      onChanged: (val) {
        profession = val;
      },
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
        labelText: "profession",
        helperText: "It can't be empty",
      ),
    );
  }

  Widget descriptionTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "descrip " : null,
      onChanged: (val) {
        description = val;
      },
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
        labelText: "Description",
        helperText: "Write about yourself",
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "email " : null,
      onChanged: (val) {
        email = val;
      },
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
          Icons.email,
          color: Colors.green,
        ),
        labelText: "Email",
      ),
    );
  }

  Widget niveauTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "Niveau d'etudes " : null,
      onChanged: (val) {
        niveau = val;
      },
      maxLines: 2,
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
        labelText: "Niveau d'etudes",
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       leading: BackButton(
  //         color: Colors.black54,
  //       ),

  //       brightness: Brightness.light,
  //       elevation: 0.0,
  //       backgroundColor: Colors.transparent,
  //       //brightness: Brightness.li,
  //     ),
  //     body: Form(
  //       key: _formKey,
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 24),
  //         child: Column(
  //           children: [
  //             TextFormField(
  //               validator: (val) => val.isEmpty ? "Enter your name " : null,
  //               decoration: InputDecoration(hintText: " name"),
  //               onChanged: (val) {
  //                 name = val;
  //               },
  //             ),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             TextFormField(
  //               validator: (val) => val.isEmpty ? " title" : null,
  //               decoration: InputDecoration(hintText: "title"),
  //               onChanged: (val) {
  //                 title = val;
  //               },
  //             ),
  //             SizedBox(
  //               height: 5,
  //             ),
  //             TextFormField(
  //               validator: (val) => val.isEmpty ? "descrip " : null,
  //               decoration: InputDecoration(hintText: " desc"),
  //               onChanged: (val) {
  //                 name = val;
  //               },
  //             ),
  //             Spacer(),
  //             GestureDetector(
  //               onTap: () {
  //                 CreateProf();
  //               },
  //               child: Container(
  //                 alignment: Alignment.center,
  //                 width: MediaQuery.of(context).size.width,
  //                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
  //                 decoration: BoxDecoration(
  //                     color: Colors.blue,
  //                     borderRadius: BorderRadius.circular(30)),
  //                 child: Text(
  //                   "Create profile",
  //                   style: TextStyle(fontSize: 16, color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 60,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
