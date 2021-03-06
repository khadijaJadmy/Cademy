import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:random_string/random_string.dart';

import 'dart:io' as i;

import '../annonce_student_list.dart';
import 'addCourse.dart';
import 'databse.dart';

class CreateProf extends StatefulWidget {
  @override
  _CreateProfState createState() => _CreateProfState();
}

class _CreateProfState extends State<CreateProf> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool circular = false;

  String name, profession, description, niveau, email;
  UserCredential result;

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController professionController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController niveauController = new TextEditingController();
  TextEditingController imageController = new TextEditingController();

  bool isLoading = false;
  String profId;
  bool exist = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  i.File _pickedImage;

  PickedFile _image;
 int selectedIndex = 0;
  int _selectedIndex = 2;
   void _onItemTapped(int index) {
    if (index == 0) {
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              AnnounceListStudents(),
        ),
      );
    }
    if (index == 1) {
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              AddCourse(FirebaseAuth.instance.currentUser.uid),
        ),
      );
    }
    if (index == 2) {
      print("index $index");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              CreateProf(),
        ),
      );
    }
  }
  
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = i.File(_image.path);
        imageController.text = null;
      });
    }
  }

  verifyProfile() async {
    Professor professor;
    QuerySnapshot featureSnapShot1 =
        await FirebaseFirestore.instance.collection("Professors").get();
    featureSnapShot1.docs.forEach((element) {
      if (element.documentID == FirebaseAuth.instance.currentUser.uid) {
        professor = Professor(
          name: element.data()['name'],
          profession: element.data()['profession'],
          description: element.data()['description'],
          email: element.data()['email'],
          image: element.data()['image'],
          niveau: element.data()['niveauEtudes'],
        );
        setState(() {
          nameController.text = professor.name;
          professionController.text = professor.profession;
          descriptionController.text = professor.description;
          niveauController.text = professor.niveau;
          emailcontroller.text = professor.email;
          imageController.text = professor.image;
          exist = true;
          print(professor.description);
          print("HERE INSIDE VERIFY");
        });
        // print(student.niveau_scholaire);
        // print(student.name);
      }
    });
  }

  String userUid;

  Future _uploadImage({i.File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("image/$userUid");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    var imageUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imageController.text = null;
    });
    return imageUrl;
  }

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  bool centerCircle = false;
  var imageMap;

  void createProf() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    profId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
        circular = true;
      });

      imageMap = await _uploadImage(image: _pickedImage);
      print(imageMap);
      Map<String, String> profData = {
        "name": nameController.text,
        "profession": professionController.text,
        "description": descriptionController.text,
        "niveauEtudes": niveauController.text,
        "email": emailcontroller.text,
        "userId": uid,
        "image": imageMap
      };
      print(name);
      print(profession);
      print(profData);

      databaseService.addProfData(profData, uid).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AddCourse(uid)));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    verifyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buttonBar(),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
          onPressed: () => Navigator.of(context).pop(),
          //Navigator.pushReplacement(
          //   context, MaterialPageRoute(builder: (context) => HomePage()))
        ),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("Profil"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            // SizedBox(
            //   height: 12,
            // ),
            CircleAvatar(
              backgroundImage: imageController.text == null
                  ? NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png',
                    )
                  : NetworkImage(imageController.text),
              radius: 60,
              // width: 100,
              // height: 100,
              // decoration: BoxDecoration(
              //     border: Border.all(width: 4, color: Colors.white),
              //     // borderRadius: BorderRadius.circular(26),
              //     boxShadow: [
              //       BoxShadow(
              //           spreadRadius: 2,
              //           blurRadius: 10,
              //           color: Colors.black.withOpacity(0.1))
              //     ],
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image:
              //         NetworkImage(
              //           'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png',
              //         ))),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.file(
                        _pickedImage,
                        // width: 100,
                        // height: 100,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                        // shape: BoxShape.circle,
                      ),

                      // width: 100,
                      // height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Colors.white,
                  ),
                  color: Color.fromRGBO(9, 189, 180, 1),
                ),
                child: GestureDetector(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onTap: () {
                    _showPicker(context);
                  },
                ),
              ),
            ),

            // Center(
            //   child: GestureDetector(
            //     onTap: () {
            //       _showPicker(context);
            //     },
            //     child: CircleAvatar(
            //         radius: 55,
            //         backgroundColor: Color(0xffFDCF09),
            //         child: imageController.text != null
            //             ? CircleAvatar(
            //                 backgroundImage: NetworkImage(imageController.text)
            //             )

            //: FileImage(_pickedImage)),
            // child: _image != null
            // : ClipRRect(
            //     borderRadius: BorderRadius.circular(50),
            //     child: Image.file(
            //       _pickedImage,
            //       width: 100,
            //       height: 100,
            //       fit: BoxFit.fitHeight,
            //     ),
            //   )
            //     : Container(
            //         decoration: BoxDecoration(
            //             color: Colors.grey[200],
            //             borderRadius: BorderRadius.circular(50)),
            //         width: 100,
            //         height: 100,
            //         child: Icon(
            //           Icons.camera_alt,
            //           color: Colors.grey[800],
            //         ),
            //       ),
            //      ),
            //    ),
            //    ),
            SizedBox(
              height: 10,
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
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                createProf();
              },
              child: Container(
                child: Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff09bdb4),
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

  // Widget imageProfile() {
  //   return AlertDialog(
  //     content: SingleChildScrollView(
  //       child: ListBody(
  //         children: [
  //           ListTile(
  //             leading: Icon(Icons.camera_alt),
  //             title: Text("Pick Form Camera"),
  //             onTap: () {
  //               getImage(source: ImageSource.camera);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.photo_library),
  //             title: Text("Pick Form Gallery"),
  //             onTap: () {
  //               getImage(source: ImageSource.gallery);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Gallery'),
                      onTap: () {
                        getImage(source: ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });

    
  }

  Widget nameTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "Enter your name " : null,
      controller: nameController,
      onChanged: (val) {
        name = val;
        print(name);
      },
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Name',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget professionTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? " profes" : null,
      controller: professionController,
      onChanged: (val) {
        profession = val;
        print(profession);
      },
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Profession',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget descriptionTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "descrip " : null,
      controller: descriptionController,
      onChanged: (val) {
        description = val;
        print(description);
      },
      maxLines: 4,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Description',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "email " : null,
      controller: emailcontroller,
      onChanged: (val) {
        email = val;
        print(email);
      },
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Email',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget niveauTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "Niveau d'etudes " : null,
      controller: niveauController,
      onChanged: (val) {
        niveau = val;
      },
      maxLines: 2,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Level',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }
  BottomNavigationBar buttonBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
              color: Color.fromRGBO(9, 189, 180, 1),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Color.fromRGBO(9, 189, 180, 1),
              ),
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.plusCircle,
                color: Color.fromRGBO(9, 189, 180, 1),
                size: 20.0,
              ),
              title: Text('Add course',
                  style: TextStyle(
                    color: Color.fromRGBO(9, 189, 180, 1),
                  )),
             ),
          BottomNavigationBarItem(
            icon:Icon(
                FontAwesomeIcons.user,
                color: Color.fromRGBO(9, 189, 180, 1),
                size: 20.0,
              ),
            title: Text('Profile',
                style: TextStyle(
                  color: Color.fromRGBO(9, 189, 180, 1),
                )),
         
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5);
  }
}
