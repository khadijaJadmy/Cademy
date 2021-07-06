// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crypto_wallet/model/Professor.dart';
// import 'package:crypto_wallet/model/course.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';

// class ExpansionTileCardDemo extends StatefulWidget {
//   @override
//   _ExpansionTileCardDemoState createState() => _ExpansionTileCardDemoState();
// }

// class _ExpansionTileCardDemoState extends State<ExpansionTileCardDemo> {
//   final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
//   List<Course> formations = [];
//   Future<void> getList() async {
//     List<Course> newList1 = [];
//     List<Professor> newList2 = [];
//     Course featureData1;
//     Professor featureData2;

//     String uid = FirebaseAuth.instance.currentUser.uid;
//     int index = 0;
//     final profRef = Firestore.instance.collection("Professors");
//     profRef.getDocuments().then((QuerySnapshot querySnapshot) {
//       querySnapshot.documents.forEach((DocumentSnapshot doc) async {
//         profRef.document(doc.id).get().then((DocumentSnapshot document) async {
//           QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
//               .collection("Professors")
//               .doc(doc.id)
//               .collection("formations")
//               .get();
//           featureSnapShot1.docs.forEach(
//             (element) {
//               featureData1 = Course(
//                 // description: element.data()["description"],
//                 // category: element.data()['category'],
//                 createur: (element.data() as dynamic)["createur"],
//                 nom_formation: (element.data() as dynamic)["nom_formation"],
//                 category: (element.data() as dynamic)["category"],
//                 prix: (element.data() as dynamic)["prix"],
//                 date_sortie: (element.data() as dynamic)["date_sortie"],
//                 description: (element.data() as dynamic)["description"],
//                 langue: (element.data() as dynamic)["langue"],
//                 image: (element.data() as dynamic)["image"],
//                 nombre_participants:
//                     (element.data() as dynamic)["nombre_participants"],
//               );
//             },
//           );

//           // featureData2 = Professor(
//           //   name: document.data()["name"],
//           //   formation: document.data()["formation"],
//           //   category: document.data()["category"],
//           //   image: document.data()["image"],
//           //   course: featureData1,
//           // );
//           // print("feature data $featureData2");
//           setState(() {
//             formations.add(featureData1);
//             index++;
//           });
//         });
//       });
//     });
//   }

//   @override
//   void initState() {
//     print("listFormation");
//     getList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0.0,
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           title: Text("List Formations"),
//           ),
//       body: Container(
//         child: ListView.builder(
//           itemCount: formations.length,
//           itemBuilder: (context, index) {
//             return Column(children: <Widget>[
//               Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 15.0, vertical: 20),
//                   child: ExpansionTileCard(
//                       baseColor: Colors.cyan[50],
//                       expandedColor: Colors.blue[50],
//                       key: new GlobalKey(),
//                       leading: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                         "${formations[index].image}",
//                         // height: 120,
//                         // width: 140,
//                         // fit: BoxFit.fill,

//                       ),
//                       radius: 25,

//                       ),
//                       title: Text("${formations[index].nom_formation}",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, fontSize: 20)),
//                       subtitle: Text(
//                           "Publie par : Mr. ${formations[index].createur}",
//                           style: TextStyle(
//                               fontStyle: FontStyle.italic, fontSize: 20)),
//                       children: <Widget>[
//                         Divider(
//                           thickness: 1.0,
//                           height: 1.0,
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16.0,
//                               vertical: 8.0,
//                             ),
//                             child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   RichText(
//                                     text: TextSpan(children: [
//                                       WidgetSpan(
//                                         child: Icon(
//                                           Icons.book,
//                                           size: 20,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                           text:
//                                               "  Categorie :  ${formations[index].category}\n\n",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.normal,
//                                           )),
//                                       WidgetSpan(
//                                         child: Icon(
//                                           Icons.date_range,
//                                           size: 20,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                           text:
//                                               "  Date de sortie : ${formations[index].date_sortie}\n\n",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.normal,
//                                           )),
//                                       WidgetSpan(
//                                         child: Icon(
//                                           Icons.language,
//                                           size: 20,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                           text:
//                                               "  Langue : ${formations[index].langue}\n\n",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.normal,
//                                           )),
//                                       WidgetSpan(
//                                         child: Icon(
//                                           Icons.groups_sharp,
//                                           size: 20,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                           text:
//                                               "  Nombre de particpants :  ${formations[index].nombre_participants}\n\n",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.normal,
//                                           )),
//                                       WidgetSpan(
//                                         child: Icon(
//                                           Icons.price_change_outlined,
//                                           size: 17,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                       TextSpan(
//                                           text:
//                                               "  Prix :  ${formations[index].prix} DH\n\n",
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.normal,
//                                           )),
//                                     ]),
//                                   ),
//                                 ]),
//                           ),
//                         ),
//                       ]))
//             ]);
//           },
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:crypto_wallet/ui_professor/courses/courseListData.dart';
import 'package:crypto_wallet/ui_professor/courses/courseListView.dart';
import 'package:crypto_wallet/ui_professor/courses/courseThem.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HotelHomeScreen extends StatefulWidget {
  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
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
                                    // getTimeDateUI(),
                                  ],
                                );
                              }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                getFilterBarUI(),
                              ),
                            ),
                          ];
                        },
                        body: Container(
                          color:
                              HotelAppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: hotelList.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count =
                                  hotelList.length > 10 ? 10 : hotelList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: animationController,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                              animationController?.forward();
                              return HotelListView(
                                callback: () {},
                                hotelData: hotelList[index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          hotelList.length > 10 ? 10 : hotelList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return HotelListView(
                        callback: () {},
                        hotelData: hotelList[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < hotelList.length; i++) {
      final int count = hotelList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        HotelListView(
          callback: () {},
          hotelData: hotelList[i],
          animation: animation,
          animationController: animationController,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: hotelListViews,
    );
  }

  // Widget getTimeDateUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 18, bottom: 16),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Row(
  //             children: <Widget>[
  //               Material(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   focusColor: Colors.transparent,
  //                   highlightColor: Colors.transparent,
  //                   hoverColor: Colors.transparent,
  //                   splashColor: Colors.grey.withOpacity(0.2),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(4.0),
  //                   ),
  //                   onTap: () {
  //                     FocusScope.of(context).requestFocus(FocusNode());
  //                     // setState(() {
  //                     //   isDatePopupOpen = true;
  //                     // });
  //                     showDemoDialog(context: context);
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(
  //                         left: 8, right: 8, top: 4, bottom: 4),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Text(
  //                           'Choose date',
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.w100,
  //                               fontSize: 16,
  //                               color: Colors.grey.withOpacity(0.8)),
  //                         ),
  //                         const SizedBox(
  //                           height: 8,
  //                         ),
  //                         Text(
  //                           '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w100,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(right: 8),
  //           child: Container(
  //             width: 1,
  //             height: 42,
  //             color: Colors.grey.withOpacity(0.8),
  //           ),
  //         ),
  //         Expanded(
  //           child: Row(
  //             children: <Widget>[
  //               Material(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   focusColor: Colors.transparent,
  //                   highlightColor: Colors.transparent,
  //                   hoverColor: Colors.transparent,
  //                   splashColor: Colors.grey.withOpacity(0.2),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(4.0),
  //                   ),
  //                   onTap: () {
  //                     FocusScope.of(context).requestFocus(FocusNode());
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(
  //                         left: 8, right: 8, top: 4, bottom: 4),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Text(
  //                           'Number of Rooms',
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.w100,
  //                               fontSize: 16,
  //                               color: Colors.grey.withOpacity(0.8)),
  //                         ),
  //                         const SizedBox(
  //                           height: 8,
  //                         ),
  //                         Text(
  //                           '1 Room - 2 Adults',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w100,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
                    onChanged: (String txt) {},
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

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HotelAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '5 Courses Found',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                // Material(
                //   color: Colors.transparent,
                //   child: InkWell(
                //     focusColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     hoverColor: Colors.transparent,
                //     splashColor: Colors.grey.withOpacity(0.2),
                //     borderRadius: const BorderRadius.all(
                //       Radius.circular(4.0),
                //     ),
                //     // onTap: () {
                //     //   FocusScope.of(context).requestFocus(FocusNode());
                //     //   Navigator.push<dynamic>(
                //     //     context,
                //     //     MaterialPageRoute<dynamic>(
                //     //         builder: (BuildContext context) => FiltersScreen(),
                //     //         fullscreenDialog: true),
                //     //   );
                //     // },
                //     // child: Padding(
                //     //   padding: const EdgeInsets.only(left: 8),
                //     //   child: Row(
                //     //     children: <Widget>[
                //     //       Text(
                //     //         'Filter',
                //     //         style: TextStyle(
                //     //           fontWeight: FontWeight.w100,
                //     //           fontSize: 16,
                //     //         ),
                //     //       ),
                //     //       Padding(
                //     //         padding: const EdgeInsets.all(8.0),
                //     //         child: Icon(Icons.sort,
                //     //             color: HotelAppTheme.buildLightTheme()
                //     //                 .primaryColor),
                //     //       ),
                //     //     ],
                //     //   ),
                //     // ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  // void showDemoDialog({BuildContext? context}) {
  //   showDialog<dynamic>(
  //     context: context!,
  //     builder: (BuildContext context) => CalendarPopupView(
  //       barrierDismissible: true,
  //       minimumDate: DateTime.now(),
  //       //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
  //       initialEndDate: endDate,
  //       initialStartDate: startDate,
  //       onApplyClick: (DateTime startData, DateTime endData) {
  //         setState(() {
  //           startDate = startData;
  //           endDate = endData;
  //         });
  //       },
  //       onCancelClick: () {},
  //     ),
  //   );
  // }

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
                  'Courses',
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
                  //     onTap: () {},
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Icon(FontAwesomeIcons.mapMarkerAlt),
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
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
