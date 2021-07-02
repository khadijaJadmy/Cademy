import 'package:crypto_wallet/firestore/announceController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;

import 'package:random_string/random_string.dart';

import 'databse.dart' as Cours;
import 'myCourses.dart';

class AddCourse extends StatefulWidget {
  final String profId;
  AddCourse(this.profId);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  Cours.DatabaseService databaseService;
  final _formKey = GlobalKey<FormState>();
  bool circular = false;
  bool isLoading = false;

  String title, description, prerequis, price;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userUid;
  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  // Future uploadToStorage() async {
  //   final User user = auth.currentUser;
  //   final uid = user.uid;
  //   try {
  //     final DateTime now = DateTime.now();
  //     final int millSeconds = now.millisecondsSinceEpoch;
  //     final String month = now.month.toString();
  //     final String date = now.day.toString();
  //     final String storageId = (millSeconds.toString() + uid);
  //     final String today = ('$month-$date');

  //     final file = await ImagePicker.pickVideo(source: ImageSource.gallery);

  //     StorageReference ref =
  //         FirebaseStorage.instance.ref().child("video/$userUid");

  //     StorageUploadTask uploadTask =
  //         ref.putFile(file, StorageMetadata(contentType: 'video/mp4'));
  //     StorageTaskSnapshot snapshot = await uploadTask.onComplete;
  //     var videoUrl = await snapshot.ref.getDownloadURL();
  //     return videoUrl;
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  var videoMap;
  Future _uploadVideo({i.File video}) async {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("videos/$userUid");
   StorageUploadTask uploadTask = storageReference.putFile(
        video, StorageMetadata(contentType: 'video/mp4'));
  StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    var videoUrl = await snapshot.ref.getDownloadURL();
    print("video url =");
    print(videoUrl);
    return videoUrl;
  }

  uploadProfData() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
        circular = true;
      });

      videoMap = await _uploadVideo(video: _pickedVideo);

      Map<String, String> courseMap = {
        "id": randomAlphaNumeric(16),
        "nom_formation": title,
        "description": description,
        "prix": price,
        "prerequis": prerequis,
        "userId": uid,
        "video": videoMap
      };
      print(courseMap);

      // print("${widget.profId}");
      databaseService.addCourseData(courseMap, uid).then((value) {
        title = "";
        description = "";
        price = "";
        prerequis = "";

        // setState(() {
        //   isLoading = false;
        // }
        setState(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => CourseList(),
            ),
          );
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("error is happening ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black54,
            onPressed: () => Navigator.of(context).pop()
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => HomePage()))
                
            ),

        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.video_library),
                    title: Text("Pick Form gallery"),
                    onTap: () {
                      _showPicker(context);
                    },
                  ),

                  titleTextField(),
                  SizedBox(
                    height: 5,
                  ),
                  descTextField(),
                  SizedBox(
                    height: 8,
                  ),
                  priceTextField(),
                  SizedBox(
                    height: 8,
                  ),
                  prerequisTextField(),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      uploadProfData();
                    },
                    child: Container(
                      child: Center(
                        child: Container(
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: circular
                                ? CircularProgressIndicator()
                                : Text(
                                    "Ajouter",
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
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 70,
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         uploadProfData();
                  //         circular = true;
                  //       },
                  //       child: Center(
                  //         child: Container(
                  //           width: 150,
                  //           height: 50,
                  //           decoration: BoxDecoration(
                  //             color: Colors.teal,
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: Center(
                  //             child: circular
                  //                 ? CircularProgressIndicator()
                  //                 : Text(
                  //                     "add Course",
                  //                     style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 18,
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //                   ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "title" : null,
      onChanged: (val) {
        title = val;
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
          Icons.title,
          color: Colors.green,
        ),
        labelText: "Course title",
      ),
    );
  }

  Widget descTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? " description " : null,
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
        prefixIcon: Icon(
          Icons.description,
          color: Colors.green,
        ),
        labelText: "Course description",
      ),
    );
  }

  Widget priceTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "price " : null,
      onChanged: (val) {
        price = val;
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
          Icons.monetization_on,
          color: Colors.green,
        ),
        labelText: "price",
      ),
    );
  }

  Widget prerequisTextField() {
    return TextFormField(
      validator: (val) => val.isEmpty ? "prerequis " : null,
      onChanged: (val) {
        prerequis = val;
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
        prefixIcon: Icon(
          Icons.receipt,
          color: Colors.green,
        ),
        labelText: "Prerequis",
      ),
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.video_library),
                      title: new Text('Photo Gallery'),
                      onTap: () {
                        getImage(source: ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  i.File _pickedVideo;

  Future<void> getImage({ImageSource source}) async {
    final video = await ImagePicker.pickVideo(source: source);
    if (video != null) {
      setState(() {
        _pickedVideo = i.File(video.path);
      });
    }
  }
}
