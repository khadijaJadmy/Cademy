import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Student.dart';
import 'package:crypto_wallet/services/StudentService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as i;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController roleController = new TextEditingController();
  TextEditingController NSController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
 var imageMap;
 PickedFile _image;
  StudentService databaseService = new StudentService();
  bool exist = false;
  bool isObscurePassword = true;
 i.File _pickedImage;
  final snackBar = SnackBar(
    content: Text('Add done successfully'),
    backgroundColor: Colors.green,
  );

  void UpdateStudent() async {
    // if (_formKey.currentState.validate()) {

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Map<String, String> studentData = {
      "id": FirebaseAuth.instance.currentUser.uid,
      "name": nameController.text,
      "location": locationController.text,
      "niveau_scholaire": NSController.text,
      "image":imageMap,
    };
    // print(studentData);
    databaseService.addStudentsData(studentData).then((value) {
      // print("GOOD");
      verifyProfile();
    });
  }

  void CreateStudent() async {
    // if (_formKey.currentState.validate()) {

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
   imageMap = await _uploadImage(image: _pickedImage);
    Map<String, String> studentData = {
      "id": FirebaseAuth.instance.currentUser.uid,
      "name": nameController.text,
      "location": locationController.text,
      "role": roleController.text,
      "niveau_scholaire": NSController.text,
      "image":imageMap,
    };
    print(studentData);
    databaseService.addStudentsData(studentData).then((value) {
      //  print("GOOD");
      nameController.text = "";
      locationController.text = "";
      NSController.text = "";
      emailController.text = "";
    });
  }

  verifyProfile() async {
    Student student;
    QuerySnapshot featureSnapShot1 =
        await FirebaseFirestore.instance.collection("Students").get();
    featureSnapShot1.docs.forEach((element) {
      if (element.documentID == FirebaseAuth.instance.currentUser.uid) {
        student = Student(
          name: element.data()['name'],
          location: element.data()['location'],
          niveau_scholaire: element.data()['niveau_scholaire'],
          id: element.data()['id'],
        );
        setState(() {
          nameController.text = student.name;
          locationController.text = student.location;
          NSController.text = student.niveau_scholaire;
          emailController.text = FirebaseAuth.instance.currentUser.email;
          exist = true;
        });
        // print(student.niveau_scholaire);
        // print(student.name);
      }
    });
  }

 

  
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = i.File(_image.path);
      });
    }
  }

  String userUid;

  Future _uploadImage({i.File image}) async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child("image/$userUid");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    var imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  
  }

  Widget imageProfile() {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Pick Form Camera"),
              onTap: () {
                getImage(source: ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Pick Form Gallery"),
              onTap: () {
                getImage(source: ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

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

  @override
  void initState() {
    verifyProfile();
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = FirebaseAuth.instance.currentUser.email;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            //  color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: 
                              NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png',
                              ))),
                       child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _pickedImage,
                            // width: 100,
                            // height: 100,
                            fit: BoxFit.cover,
                          ),
                          
                        )
                      : Container(
                        
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                              
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
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: buildTextFieldName(
                          "Full Name*", "Enter your full name", false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: buildTextFieldEmail(
                          "Email*", "example@gmail.com", false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: buildTextFieldLocation(
                          "Location", "Enter your location adresse", false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: buildTextFieldNS(
                          "School level", "Enter your school level", false),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  ElevatedButton(
                    onPressed: () {
                      exist != true ? CreateStudent() : UpdateStudent();
                    },
                    child: Text(
                      exist != true ? "SAVE" : 'UPDATE',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldName(
      String labelText, String placeholder, bool isPassworder) {
    return TextField(
      controller: nameController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          isDense: true,
          suffixIcon: isPassworder
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              : null,
          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: labelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
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

  Widget buildTextFieldEmail(
      String labelText, String placeholder, bool isPassworder) {
    return TextField(
      controller: emailController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              : null,
          ////contentPadding::: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
    );
  }

  Widget buildTextFieldRole(
      String labelText, String placeholder, bool isPassworder) {
    return TextField(
      controller: roleController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              : null,
          ////contentPadding::: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
    );
  }

  Widget buildTextFieldLocation(
      String labelText, String placeholder, bool isPassworder) {
    return TextField(
      controller: locationController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              : null,
          ////contentPadding::: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
    );
  }

  Widget buildTextFieldNS(
      String labelText, String placeholder, bool isPassworder) {
    return TextField(
      controller: NSController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              : null,
          ////contentPadding::: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 15,
            // fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
    );
  }

  Widget buildTextFieldPassword(
      String labelText, String placeholder, bool isPassworder) {
    return TextField(
      controller: passwordController,
      obscureText: isPassworder ? true : false,
      decoration: InputDecoration(
          suffixIcon: isPassworder
              ? IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                )
              : null,
          ////contentPadding::: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 16,
            // fontWeight: FontWeight.bold,
            color: Colors.grey,
          )),
    );
  }
}
