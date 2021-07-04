import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:random_string/random_string.dart';

import 'dart:io' as i;

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
  TextEditingController idController = new TextEditingController();

  bool isLoading = false;
  String profId;
  bool exist = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  i.File _pickedImage;
   final snackBar = SnackBar(
    content: Text('Update done successfully'),
    backgroundColor: Colors.green,
  );

  PickedFile _image;
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = i.File(_image.path);
        imageController.text=null;
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
          id: element.data()['userId'],
        );
        setState(() {
          nameController.text = professor.name;
          professionController.text = professor.profession;
          descriptionController.text = professor.description;
          niveauController.text = professor.niveau;
          emailcontroller.text = professor.email;
          imageController.text = professor.image;
          idController.text=professor.id;
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
       imageController.text=null;
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
    final uid = exist==false?user.uid:idController.text;
    profId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      // setState(() {
      //   isLoading = true;
      //   circular = true;
      // });

      imageMap = exist==true?imageController.text:await _uploadImage(image: _pickedImage);
      print(imageMap);
      Map<String, String> profData = {
        "name": nameController.text,
        "profession": professionController.text,
        "description": descriptionController.text,
        "niveauEtudes": niveauController.text,
        "email": emailcontroller.text,
        "userId":uid,
        "image": imageMap
      };
      print(name);
      print(profession);
      print(profData);

      databaseService.addProfData(profData, uid,exist).then((value) {
        print("GGGOOOOD");
        print(exist);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // setState(() {
        //   isLoading = false;
        // });
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => AddCourse(uid)));
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
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            SizedBox(
              height: 32,
            ),
             CircleAvatar(
               backgroundImage: imageController.text==null? NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png',
                              ): NetworkImage( imageController.text),
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
                          color: Colors.blue,
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
      validator: (val) => val.isEmpty ? " profes" : null,
      controller: professionController,
      onChanged: (val) {
        profession = val;
        print(profession);
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
      controller: descriptionController,
      onChanged: (val) {
        description = val;
        print(description);
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
      controller: emailcontroller,
      onChanged: (val) {
        email = val;
        print(email);
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
      controller: niveauController,
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
}
