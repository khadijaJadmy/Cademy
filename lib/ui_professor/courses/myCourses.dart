import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/firestore/announceController.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:crypto_wallet/ui_professor/annonce_student_list.dart';
import 'package:crypto_wallet/ui_professor/courses/video.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'courseUpdate.dart';
import 'databse.dart' as Cours;

class CourseList extends StatefulWidget {
  const CourseList({Key key}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  String query;
  bool notVisible = false;
  bool notObscure = false;
  TextEditingController queryTextEditingController =
      new TextEditingController();
  dynamic data;
  int currentPage = 0;
  int totalPages = 0;
  int pageSize = 20;
  List<dynamic> items = [];
  Course course;
  bool searchState = false;
  ScrollController scrollController = new ScrollController();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  List<Course> courses = [];
  // DatabaseService databaseService;
   Cours.DatabaseService databaseService;
  static const mDefaultPadding = 20.0;

  Future<void> getSearchResult() async {
    // print(query);
    // if (query != "") {
    // queryData(widget.searchText);
    String uid = FirebaseAuth.instance.currentUser.uid;

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Professors")
        .doc(uid)
        .collection("formations")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        course = Course(
            description: element.data()["description"],
            nom_formation: element.data()['nom_formation'],
            prix: element.data()['prix'],
            duree: element.data()['duree'],
            category: element.data()['category'],
            langue: element.data()['langue'],
            prerequis: element.data()['prerequis'],
            image: element.data()['image'],
            id: element.data()['id'],
            video: element.data()['video']);
        setState(() {
          courses.add(course);
        });
      },
    );

    print(courses);
  }

  @override
  Future<void> initState() {
    super.initState();
    // getListProf();
    getSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: !searchState
                ? Text('Mes Cours', style: TextStyle(color: Colors.black))
                : TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    // onChanged: (text) {
                    //   searchMethod(text);
                    // },
                  ),
            leading: BackButton(
                color: Colors.black54,
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnnounceListStudents()))),
            backgroundColor: Colors.white,
            actions: <Widget>[
              !searchState
                  ? IconButton(
                      icon: Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          searchState = !searchState;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.cancel, color: Colors.black),
                      onPressed: () {
                        setState(() {
                          searchState = !searchState;
                        });
                      },
                    ),
            ]),
        body: Center(
            child: Column(children: [
          Row(children: []),
          courses == null
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: courses.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 148,
                              margin: const EdgeInsets.symmetric(
                                horizontal: mDefaultPadding * 1.5,
                              ),
                              padding: const EdgeInsets.only(
                                top: mDefaultPadding,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SamplePlayer(
                                course: courses[index],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20),
                              child: ExpansionTileCard(
                                baseColor: Colors.white,
                                expandedColor: Colors.grey[100],
                                key: new GlobalKey(),
                                // leading: CircleAvatar(
                                //     //child:
                                //     // Image.asset("assets/images/devs.jpg")
                                //     ),

                                title: Text(
                                  courses[index].nom_formation,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),

                                children: <Widget>[
                                  Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  // Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceBetween,
                                  //     children: <Widget>[
                                  //       Text(
                                  //         'Course Details',
                                  //         style: TextStyle(
                                  //           fontWeight: FontWeight.w700,
                                  //         ),
                                  //       ),
                                  //       Text('3H:30min')
                                  //     ]),
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(courses[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: null /* add child content here */,
                                  ),

                                  ListTile(
                                    title: Text('Course Detail ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700)),
                                  ),

                                  ListTile(
                                      title: Text('Total Duration',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(
                                        courses[index].duree,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                  ListTile(
                                      title: Text('Langue',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(
                                        courses[index].langue,
                                        style: TextStyle(
                                          color: Color(0xFF878787),
                                          fontSize: 16,
                                        ),
                                      )),
                                  ListTile(
                                      title: Text('Category',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(
                                        courses[index].category,
                                        style: TextStyle(
                                          color: Color(0xFF878787),
                                          fontSize: 16,
                                        ),
                                      )),
                                  ListTile(
                                      title: Text('Description',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(
                                        courses[index].description,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                  ListTile(
                                      title: Text('Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(
                                        courses[index].prix,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                  ListTile(
                                      title: Text('Prerequis',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      subtitle: Text(
                                        courses[index].prerequis,
                                        style: TextStyle(
                                          color: Color(0xFF878787),
                                          fontSize: 16,
                                        ),
                                      )),
                                  // Divider(
                                  //   thickness: 1.0,
                                  //   height: 1.0,
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //       horizontal: 16.0,
                                  //       vertical: 8.0,
                                  //     ),
                                  //     child: Text(
                                  //       courses[index].description,
                                  //       style: Theme.of(context)
                                  //           .textTheme
                                  //           .bodyText2
                                  //           .copyWith(fontSize: 16),
                                  //     ),
                                  //   ),
                                  // ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceAround,
                                    buttonHeight: 52.0,
                                    buttonMinWidth: 90.0,
                                    children: <Widget>[
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  //MyNavigationBar(),
                                                  UpdateCourse(
                                                      course: courses[index]),
                                            ),
                                          ); // cardA.currentState?.expand();
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.edit),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        onPressed: () {
                                          print('IIIDDD');
                                          print(courses[index].id);
                                          databaseService
                                              .removeCourse(courses[index].id);
                                          //  if(result==true){
                                          //  products.remove(products[index]);
                                          setState(() {
                                            courses.remove(courses[index]);
                                            //  getSearchResult();
                                          });
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.delete),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }))
        ])));
  }
}
