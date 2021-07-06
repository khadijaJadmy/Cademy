import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:crypto_wallet/ui/home/components/body.dart';
import 'package:crypto_wallet/ui_professor/annonce_student_list.dart';
import 'package:crypto_wallet/ui_professor/courses/courseThem.dart';
import 'package:crypto_wallet/ui_professor/courses/video.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addCourse.dart';
import 'courseUpdate.dart';
import 'createProf.dart';
import 'databse.dart';

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
  TextEditingController searchController = new TextEditingController();
  List<Course> courses = [];
  DatabaseService databaseService;
  static const mDefaultPadding = 20.0;
  final ScrollController _scrollController = ScrollController();

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
  
  Future<void> getSearchResult() async {
    // print(query);
    // if (query != "") {
    // queryData(widget.searchText);
    String uid = FirebaseAuth.instance.currentUser.uid;
    final snackBar = SnackBar(
      content: Text('Delete done successfully!'),
      backgroundColor: Colors.red,
    );
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
    return Theme(
        data: HotelAppTheme.buildLightTheme(),
        child: Container(
            child: Scaffold(
              bottomNavigationBar: buttonBar(),
                body: Stack(children: <Widget>[
          InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(children: <Widget>[
                getAppBarUI(),
                Expanded(
                    child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    getSearchBarUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                            // SliverPersistentHeader(
                            //   pinned: true,
                            //   floating: true,
                            //   // delegate: ContestTabHeader(
                            //   //   getFilterBarUI(),
                            //   // ),
                            // ),
                          ];
                        },
                        // body: Center(
                        //     child: Column(children: [
                        //     Row(children: []),
                        //      courses == null
                        //       ? Container()
                        //       : Expanded(
                        body: Container(
                            color:
                                HotelAppTheme.buildLightTheme().backgroundColor,
                            child: ListView.builder(
                                itemCount: courses.length,
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  final int count =
                                      courses.length > 10 ? 10 : courses.length;

                                  return Column(
                                    children: <Widget>[
                                      // getSearchBarUI(),

                                      Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.all(10.0),
                                          // height: 148,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12.0)),
                                            // boxShadow: <BoxShadow>[
                                            //   BoxShadow(
                                            //     color: Colors.white
                                            //         .withOpacity(0.6),
                                            //     offset: const Offset(4, 4),
                                            //     blurRadius: 16,
                                            //   ),
                                            // ],
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    children: <Widget>[
                                                      AspectRatio(
                                                        aspectRatio: 2,
                                                        child: Image.network(
                                                          courses[index].image,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ))),
                                      // width: double.infinity,
                                      // height: 148,
                                      // margin: const EdgeInsets.symmetric(
                                      //   horizontal: mDefaultPadding * 1.5,
                                      // ),
                                      // padding: const EdgeInsets.only(
                                      //   top: mDefaultPadding,
                                      // ),
                                      // decoration: BoxDecoration(
                                      //   borderRadius:
                                      //       BorderRadius.circular(20),
                                      // ),
                                      // // child: SamplePlayer(
                                      // //   course: courses[index],
                                      // // ),
                                      // child:
                                      //     Image.network(courses[index].image),

                                      ////////////////
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 10),
                                        child: ExpansionTileCard(
                                          baseColor: Colors.white,
                                          expandedColor: Colors.grey[100],
                                          key: new GlobalKey(),
                                          // title: Text(
                                          //   courses[index].nom_formation,
                                          //   style: TextStyle(
                                          //     fontWeight: FontWeight.w600,
                                          //     fontSize: 22,
                                          //   ),
                                          // ),
                                          title: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  courses[index].nom_formation,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 60,
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Text(
                                                      ' ${courses[index].prix}DH',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),

                                          subtitle: Text(
                                            courses[index].category,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.grey),
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
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //     image: DecorationImage(
                                            //       image:
                                            //           NetworkImage(courses[index].image),
                                            //       fit: BoxFit.cover,
                                            //     ),
                                            //   ),
                                            //   child: null /* add child content here */,
                                            // ),
                                            Container(
                                              child: SamplePlayer(
                                                course: courses[index],
                                              ),
                                            ),
                                            ListTile(
                                              // title: Text('Total Duration',
                                              //     style: TextStyle(
                                              //         color: Colors.black
                                              //             .withOpacity(0.8))),
                                              // subtitle: Text(
                                              //   courses[index].duree,
                                              //   style: TextStyle(
                                              //       fontWeight:
                                              //           FontWeight.w700),
                                              // )
                                              title: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .stopwatch,
                                                      size: 14,
                                                      color: HotelAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 9,
                                                    ),
                                                    Text(
                                                      courses[index].duree,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons.globe,
                                                      size: 14,
                                                      color: HotelAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 9,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        courses[index].langue,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                            ),

                                            Container(
                                              height: 28,
                                              margin: EdgeInsets.only(
                                                  top: 23, bottom: 36),
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: DefaultTabController(
                                                length: 1,
                                                child: TabBar(
                                                    labelPadding:
                                                        EdgeInsets.all(0),
                                                    indicatorPadding:
                                                        EdgeInsets.all(0),
                                                    isScrollable: true,
                                                    labelColor: Colors.black,
                                                    unselectedLabelColor:
                                                        Colors.grey,
                                                    labelStyle:
                                                        GoogleFonts.openSans(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                    unselectedLabelStyle:
                                                        GoogleFonts.openSans(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    indicator:
                                                        RoundedRectangleTabIndicator(
                                                            weight: 2,
                                                            width: 30,
                                                            color:
                                                                Colors.black),
                                                    tabs: [
                                                      Tab(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 230),
                                                          child: Text(
                                                              'Description'),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Text(
                                                  courses[index].description,
                                                  style: GoogleFonts.basic(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey,
                                                    letterSpacing: 1.5,
                                                    height: 2,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 28,
                                              margin: EdgeInsets.only(
                                                  top: 23, bottom: 36),
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: DefaultTabController(
                                                length: 1,
                                                child: TabBar(
                                                    labelPadding:
                                                        EdgeInsets.all(0),
                                                    indicatorPadding:
                                                        EdgeInsets.all(0),
                                                    isScrollable: true,
                                                    labelColor: Colors.black,
                                                    unselectedLabelColor:
                                                        Colors.grey,
                                                    labelStyle:
                                                        GoogleFonts.openSans(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                    unselectedLabelStyle:
                                                        GoogleFonts.openSans(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    indicator:
                                                        RoundedRectangleTabIndicator(
                                                            weight: 2,
                                                            width: 30,
                                                            color:
                                                                Colors.black),
                                                    tabs: [
                                                      Tab(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 210),
                                                          child: Text(
                                                              'Requirements'),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Text(
                                                  courses[index].prerequis,
                                                  style: GoogleFonts.basic(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey,
                                                    letterSpacing: 1.5,
                                                    height: 2,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            ButtonBar(
                                              alignment:
                                                  MainAxisAlignment.spaceAround,
                                              buttonHeight: 52.0,
                                              buttonMinWidth: 90.0,
                                              children: <Widget>[
                                                FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0)),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            //MyNavigationBar(),
                                                            UpdateCourse(
                                                                course: courses[
                                                                    index]),
                                                      ),
                                                    ); // cardA.currentState?.expand();
                                                  },
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(Icons.edit),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0)),
                                                  onPressed: () {
                                                    print('IIIDDD');
                                                    print(courses[index].id);
                                                    Future<bool> result =
                                                        removeCours(
                                                            courses[index].id);

                                                    setState(() {
                                                      courses.remove(
                                                          courses[index]);
                                                      //  getSearchResult();
                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                            'Delete done successfully!'),
                                                        backgroundColor:
                                                            Colors.red,
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    });
                                                  },
                                                  child: Column(
                                                    children: <Widget>[
                                                      Icon(Icons.delete),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
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
                                })))),
              ]))
        ]))));
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: searchController,
                    onChanged: (String txt) {
                      // searchController.text = txt;
                      // print("heere");
                      // print(txt);
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Python...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  getSearchCourses();
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: HotelAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getSearchCourses() async {
    if (searchController.text != null) {
      // queryData(widget.searchText);
      print(searchController.text);
      print("insiiiiiideee searchhh");
      List<Course> list = await queryData(searchController.text);
      if (list != null) {
        setState(() {
          courses = list;
          searchController.text = "";
        });
      } else if (searchController.text == "") {
        getSearchResult();
      } else {
        NullThrownError();
      }
    }
    searchController.text = "";
  }

  Future<List<Course>> queryData(String queryData) async {
    print("YOU ARE ERE ");
    Professor featureData;
    List<Professor> newList = [];
    // String queryData = "PYTHON";
    print(queryData.toUpperCase());
    print("RAE WE HER");
    List<Course> newList1 = [];
    List<Professor> newList2 = [];
    Course featureData1;
    Professor featureData2;
    String uid = FirebaseAuth.instance.currentUser.uid;
    int index = 0;
    // final profRef = Firestore.instance.collection("Professors");
    // profRef.getDocuments().then((QuerySnapshot querySnapshot) {
    // querySnapshot.documents.forEach((DocumentSnapshot doc) async {
    // profRef.document(doc.id).get().then((DocumentSnapshot document) async {
    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Professors")
        .doc(uid)
        .collection("formations")
        .where('nom_formation', isEqualTo: queryData.toUpperCase())
        .get();
    featureSnapShot1.docs.forEach((element) {
      featureData1 = Course(
        description: element.data()["description"],
        category: element.data()['category'],
        nom_formation: element.data()["nom_formation"],
        prix: element.data()["prix"],
        langue: element.data()["langue"],
        image: element.data()["image"],
        video: element.data()["video"],
        duree: element.data()["duree"],
        prerequis: element.data()["prerequis"],
      );

      // setState(() {
      newList1.add(featureData1);
      print(featureData1.nom_formation);
      // index++;
      // });
    });
    print("THHHHHEE END OF SEARCH");
    print(newList1);
    return newList1;

    // });
    // });
    // });
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'My Courses',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(32.0),
                  //     ),
                  //     onTap: () {},
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Icon(Icons.favorite_border),
                  //     ),
                  //   ),
                  // ),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(32.0),
                  //     ),
                  //     onTap: () {

                  //     },
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Icon(
                  //         FontAwesomeIcons.plus,
                  //         size: 20,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> removeCours(String id) async {
    print('IDD REMOVE');
    print(id);
    String uid = FirebaseAuth.instance.currentUser.uid;

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Professors")
        .doc(uid)
        .collection("formations")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        print(element.data()['id'] == id);
        if (element.data()['id'] == id) {
          print(element.documentID);

          FirebaseFirestore.instance
              .collection("Professors")
              .doc(uid)
              .collection("formations")
              .doc(element.documentID)
              .delete();
        }
      },
    );
    return true;
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

class RoundedRectangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundedRectangleTabIndicator(
      {@required Color color, @required double weight, @required double width})
      : _painter = _RRectanglePainterColor(color, weight, width);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _RRectanglePainterColor extends BoxPainter {
  final Paint _paint;
  final double weight;
  final double width;

  _RRectanglePainterColor(Color color, this.weight, this.width)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset customOffset = offset + Offset(0, cfg.size.height - weight);

    //Custom Rectangle
    Rect myRect = customOffset & Size(width, weight);

    // Custom Rounded Rectangle
    RRect myRRect = RRect.fromRectXY(myRect, weight, weight);

    canvas.drawRRect(myRRect, _paint);
  }
}
