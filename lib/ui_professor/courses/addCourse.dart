import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as i;

import 'package:random_string/random_string.dart';
import 'package:select_form_field/select_form_field.dart';

import '../annonce_student_list.dart';
import 'createProf.dart';
import 'databse.dart';
import 'myCourses.dart';

class AddCourse extends StatefulWidget {
  final String profId;
  AddCourse(this.profId);

  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  DatabaseService databaseService = new DatabaseService();
  final _formKey = GlobalKey<FormState>();
  bool circular = false;
  bool isLoading = false;

  String title,
      description,
      prerequis,
      price,
      video =
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      duree,
      datePub,
      langue,
      photo =
          "https://www.mathweb.fr/euclide/wp-content/uploads/2019/06/maths.jpg",
      category;
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  TextEditingController prerequisController = new TextEditingController();

  TextEditingController categoryController = new TextEditingController();
  TextEditingController dureeController = new TextEditingController();
  TextEditingController langueController = new TextEditingController();

  String userUid;
   int selectedIndex = 0;
  int _selectedIndex = 1;

  void getUserUid() {
    User myUser = FirebaseAuth.instance.currentUser;
    userUid = myUser.uid;
  }

  i.File _pickedImage;

  // PickedFile _image;
  // Future<void> getImage({ImageSource source}) async {
  //   _image = await ImagePicker().getImage(source: source);
  //   if (_image != null) {
  //     setState(() {
  //       _pickedImage = i.File(_image.path);
  //     });
  //   }
  // }

  // Future _uploadImage({i.File image}) async {
  //   StorageReference storageReference =
  //       FirebaseStorage.instance.ref().child("imageFormations/$userUid");
  //   StorageUploadTask uploadTask = storageReference.putFile(image);
  //   StorageTaskSnapshot snapshot = await uploadTask.onComplete;
  //   var imageUrl = await snapshot.ref.getDownloadURL();
  //   return imageUrl;
  // }
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

  var imageMap;
  uploadProfData() async {
    final User user = auth.currentUser;
    final uid = user.uid;
    // if (_formKey.currentState.validate()) {
    //   setState(() {
    //     isLoading = true;
    //   });
    //   setState(() {
    //     circular = true;
    //   });

    // videoMap = await _uploadVideo(video: _pickedVideo);
    // DateTime now = new DateTime.now();
    // Timestamp stamp = Timestamp.now();
    // DateTime date = stamp.toDate();
    // imageMap = await _uploadImage(image: _pickedImage);
    Map<String, dynamic> courseMap = {
      "id": randomAlphaNumeric(16),
      "nom_formation": titleController.text.toUpperCase(),
      "description": descriptionController.text,
      "prix": priceController.text,
      "prerequis": prerequisController.text,
      "userId": uid,
      "video":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
      "langue": langueController.text,
      "category": categoryController.text,
      // "datePub": date,
      "duree": dureeController.text,
      "image":
          "https://www.mathweb.fr/euclide/wp-content/uploads/2019/06/maths.jpg"
    };
    print(courseMap);

    // print("${widget.profId}");
    databaseService.addCourseData(courseMap, uid).then((value) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: buttonBar(),
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black54,
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => CourseList()))),

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
                  // ListTile(
                  //   leading: Icon(Icons.video_library),
                  //   title: Text("Pick Form gallery"),
                  //   onTap: () {
                  //     _showPicker(context);
                  //   },
                  // ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xff09bdb4),
                        child: _pickedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _pickedImage,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       _showPickerVideo(context);
                  //     },
                  //     child: CircleAvatar(
                  //       radius: 55,
                  //       backgroundColor: Color(0xff09bdb4),
                  //       child: _pickedImage != null
                  //           ? ClipRRect(
                  //               borderRadius: BorderRadius.circular(50),
                  //               child: Image.file(
                  //                 _pickedImage,
                  //                 width: 100,
                  //                 height: 100,
                  //                 fit: BoxFit.fitHeight,
                  //               ),
                  //             )
                  //           : Container(
                  //               decoration: BoxDecoration(
                  //                   color: Colors.grey[200],
                  //                   borderRadius: BorderRadius.circular(50)),
                  //               width: 100,
                  //               height: 100,
                  //               child: Icon(
                  //                 Icons.video_collection,
                  //                 color: Colors.grey[800],
                  //               ),
                  //             ),
                  //     ),
                  //   ),
                  // ),
                  RaisedButton(
                    onPressed: () {
                      _showPickerVideo(context);
                    },
                    child: Text("Pick Video From Gallery"),
                  ),
                  // videoTextField(),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // photoTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  titleTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  descTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  dureeTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  priceTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  prerequisTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  categoryTextField(),
                  SizedBox(
                    height: 10,
                  ),
                  langueTextField(),
                  SizedBox(
                    height: 70,
                  ),

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
                            uploadProfData()();
                            circular = true;
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

  Widget dureeTextField() {
    return TextFormField(
      // validator: (val) => val.isEmpty ? "duree" : null,
      controller: dureeController,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Duration',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter Duration',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      // validator: (val) => val.isEmpty ? "Title" : null,
      controller: titleController,
      decoration: InputDecoration(
          labelText: 'Title',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter Title',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  // Widget videoTextField() {
  //   return TextFormField(
  //     validator: (val) => val.isEmpty ? "Video" : null,
  //     onChanged: (val) {
  //       video = val;
  //     },
  //     maxLines: 2,
  //     decoration: InputDecoration(
  //         labelStyle: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 20,
  //             color: Colors.black,
  //             fontStyle: FontStyle.normal),
  //         floatingLabelBehavior: FloatingLabelBehavior.always,
  //         hintText: 'Video URL',
  //         focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //           color: Colors.blue,
  //           width: 1,
  //         )),
  //         hintStyle: TextStyle(
  //           color: Colors.black.withOpacity(0.8),
  //         )),
  //   );
  // }

  Widget langueTextField() {
    return TextFormField(
      // validator: (val) => val.isEmpty ? "Langue" : null,
      controller: langueController,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Language',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter Language',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget photoTextField() {
    return TextFormField(
      // validator: (val) => val.isEmpty ? "photo" : null,
      controller: dureeController,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Title',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter Title',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
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
      // validator: (val) => val.isEmpty ? "category" : null,
      // initialValue: 'Maths',
      labelText: 'Maths',
      items: _items,
      controller: categoryController,
      onSaved: (val) {
        setState(() {
          categoryController.text = val;
        });
      },
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Category',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Select Category',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget descTextField() {
    return TextFormField(
      // validator: (val) => val.isEmpty ? " description " : null,
      controller: descriptionController,
      maxLines: 4,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Description',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter Description',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget priceTextField() {
    return TextFormField(
      // validator: (val) => val.isEmpty ? "price " : null,
      controller: priceController,
      decoration: InputDecoration(
          isDense: true,

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Price',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter price',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
    );
  }

  Widget prerequisTextField() {
    return TextFormField(
      // validator: (val) => val.isEmpty ? "prerequis " : null,
      controller: prerequisController,
      maxLines: 4,
      decoration: InputDecoration(

          // //contentPadding:: EdgeInsets.only(bottom: 5,left:10),
          // //contentPadding:: EdgeInsets.only(top: 4,bottom: 4,left: 6,right: 6),
          labelText: 'Requirements',
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'Enter Requirements',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xff09bdb4),
            width: 1,
          )),
          hintStyle: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.bold,

            color: Colors.grey,
          )),
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
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showPickerVideo(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.video_library),
                      title: new Text('Video Library'),
                      onTap: () {
                        _pickVideo();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    i.File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _pickedImage = image;
    });
  }

  _imgFromGallery() async {
    i.File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _pickedImage = image;
    });
  }

  i.File _video;
  final picker = ImagePicker();

// This funcion will helps you to pick a Video File
  _pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    _video = i.File(pickedFile.path);
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

