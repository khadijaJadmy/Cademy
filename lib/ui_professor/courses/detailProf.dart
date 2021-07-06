import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/ui_professor/annonce_student_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'notification_button.dart';

class DetailProf extends StatefulWidget {
  @override
  _DetailProfState createState() => _DetailProfState();
}

class _DetailProfState extends State<DetailProf> {
  Professor prof;
  String userUid;
  TextEditingController description;
  TextEditingController profession;
  TextEditingController name;
  TextEditingController email;
  TextEditingController niveau;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  Widget _buildContainerPart() {
    description = TextEditingController(text: prof.description);
    name = TextEditingController(text: prof.name);
    profession = TextEditingController(text: prof.profession);
    email = TextEditingController(text: prof.email);
    niveau = TextEditingController(text: prof.niveau);

    return ListView(
      children: <Widget>[
        ListTile(
            // title: Text('Nom & Prénom',
            //     style: TextStyle(fontWeight: FontWeight.w600)),
            //     subtitle: TextFormField(
            //   controller: name,
            // )
            subtitle: TextFormField(
          cursorColor: Colors.black,
          controller: name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 90, bottom: 11, top: 1, right: 18),
          ),
        )),
        ListTile(
            subtitle: TextFormField(
          controller: email,
          decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                EdgeInsets.only(left: 70, bottom: 11, top: -40, right: 18),
          ),
        )),
        buildFor(context),
        SizedBox(
          height: 15,
        ),
        ListTile(
            title: Text('About', style: TextStyle(fontWeight: FontWeight.w700)),
            subtitle: TextFormField(
              controller: description,
              maxLines: 3,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            )),
        SizedBox(
          height: 15,
        ),
        ListTile(
            title: Text('Profession',
                style: TextStyle(fontWeight: FontWeight.w700)),
            subtitle: TextFormField(
              controller: profession,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            )),
        SizedBox(
          height: 10,
        ),
        ListTile(
            title: Text('Niveau Etudes',
                style: TextStyle(fontWeight: FontWeight.w700)),
            subtitle: TextFormField(
              controller: niveau,
              decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            )),
        SizedBox(
          height: 10,
        ),
        ListTile(
          subtitle: Column(
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  setState(() {
                    edit = true;
                  });
                },
                borderSide: BorderSide(width: 5, color: Colors.teal),
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 19),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
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
        });
  }

  void vaildation() async {
    if (name.text.isEmpty && description.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("All Flied Are Empty"),
        ),
      );
    } else if (profession.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name Is Empty "),
        ),
      );
    } else if (description.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Name Must Be 6 "),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  File _pickedImage;

  PickedFile _image;
  Future<void> getImage({ImageSource source}) async {
    _image = await ImagePicker().getImage(source: source);
    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  Future<String> _uploadImage({File image}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("UserImage/$userUid");
    StorageUploadTask uploadTask = storageReference.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  bool centerCircle = false;
  var imageMap;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    FirebaseFirestore.instance.collection("prof").doc(userUid).update({
      "name": name.text == "" ? prof.name : name.text,
      "description":
          description.text == "" ? prof.description : description.text,
      "image": imageMap,
      "profession": profession.text == "" ? prof.profession : profession.text,
      "email": email.text == "" ? prof.email : email.text,
      "niveauEtudes": niveau.text == "" ? prof.niveau : niveau.text,
    });
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  String userImage;
  bool edit = false;
  //widget for edit
  Widget _buildTextFormFliedPart() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
            child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                children: <Widget>[
              // MyTextFormField(
              //   controller: name,
              // ),
              TextFormField(
                  controller: name,
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
                    labelText: "Nom & Prénom",
                  )),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                  controller: email,
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
                  )),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                  maxLines: 5,
                  controller: description,
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
                      Icons.text_format,
                      color: Colors.green,
                    ),
                    labelText: "Description",
                  )),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  controller: profession,
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
                    labelText: "Profession",
                  )),
              SizedBox(
                height: 32,
              ),
              TextFormField(
                  controller: niveau,
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
                    labelText: "Niveau d'études",
                  )),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    getUserUid();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => AnnounceListStudents(),
                      ),
                    );
                  });
                },
              ),
        backgroundColor: Colors.white,
        actions: [
          // edit == false
              // ? NotificationButton()
            //  : 
              IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: Color(0xff746bc9),
                  ),
                  onPressed: () {
                    vaildation();
                  },
                ),
        ],
      ),
      body: centerCircle == false
          ? ListView(
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("prof")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var myDoc = snapshot.data.docs;
                      myDoc.forEach((checkDocs) {
                        if (checkDocs.data()["userId"] == userUid) {
                          prof = Professor(
                            name: checkDocs.data()["name"],
                            email: checkDocs.data()["email"],
                            description: checkDocs.data()["description"],
                            profession: checkDocs.data()["profession"],
                            niveau: checkDocs.data()["niveauEtudes"],
                            image: checkDocs.data()["image"],
                          );
                        }
                      });
                      return Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(6),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // CircleAvatar(
                                          //     radius: 55,
                                          //     backgroundColor:
                                          //         Color(0xffFDCF09),
                                          //     backgroundImage: _pickedImage ==
                                          //             null
                                          //         ? prof.image == null
                                          //             ? AssetImage(
                                          //                 "images/prof.png")
                                          //             : NetworkImage(prof.image)
                                          //         : FileImage(_pickedImage)),
                                          CircleAvatar(
                                              radius: 70,
                                              backgroundColor:
                                                  Color(0xffFDCF09),
                                              backgroundImage: _pickedImage ==
                                                      null
                                                  ? prof.image == null
                                                      ? AssetImage(
                                                          "images/prof.png")
                                                      : NetworkImage(prof.image)
                                                  : FileImage(_pickedImage)),
                                        ],
                                      ),
                                    ),
                                    edit == true
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .viewPadding
                                                        .left +
                                                    220,
                                                top: MediaQuery.of(context)
                                                        .viewPadding
                                                        .left +
                                                    110),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  myDialogBox(context);
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Color(0xff746bc9),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                                Container(
                                  height: 350,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: edit == true
                                              ? _buildTextFormFliedPart()
                                              : _buildContainerPart(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget buildDivider() =>
      Container(height: 24, child: VerticalDivider(color: Colors.black));

  buildFor(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '4.8', 'Ranking'),
          buildDivider(),
          buildButton(context, '35', 'Following'),
          buildDivider(),
          buildButton(context, '50', 'Followers'),
        ],
      );
}
