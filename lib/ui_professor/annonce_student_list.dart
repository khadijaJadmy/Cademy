import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/announce.dart';
import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:crypto_wallet/ui/details/details_screen.dart';
import 'package:crypto_wallet/ui/home/components/item_card.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bottom_bar.dart';
import 'cookie_page.dart';
import 'courses/addCourse.dart';
import 'courses/createProf.dart';
import 'widget/navigation_drawer_widget.dart';

class AnnounceListStudents extends StatefulWidget {
  @override
  _AnnounceListStudentsState createState() => _AnnounceListStudentsState();
}

class _AnnounceListStudentsState extends State<AnnounceListStudents>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

  TabController _tabController;
  int selectedIndex = 0;
  int _selectedIndex = 0;
  int expandedHeight = 85;
  List<dynamic> items = [];
  Announce announce;
  ScrollController scrollController = new ScrollController();
  List<Announce> products = [];
  List<Announce> announceProgramming = [];
  List<Announce> announceMath = [];
  List<Announce> announcePhysics = [];
  Future<void> getSearchResult() async {
    List<Announce> newList1 = [];
    Announce featureData1;

    String uid = FirebaseAuth.instance.currentUser.uid;
    int index = 0;
    final profRef = Firestore.instance.collection("Users");
    profRef.getDocuments().then((QuerySnapshot querySnapshot) {
      querySnapshot.documents.forEach((DocumentSnapshot doc) async {
        profRef.document(doc.id).get().then((DocumentSnapshot document) async {
          print(doc.id);
          QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
              .collection("Users")
              .doc(doc.id)
              .collection("announce")
              .get();
          featureSnapShot1.docs.forEach(
            (element) {
              featureData1 = Announce(
                  description: element.data()["description"],
                  category: element.data()['category'],
                  id: element.data()['id'],
                  title: element.data()['title']);
              print("FEATRE DATA");
              print(featureData1);
            },
          );

          setState(() {
            if (featureData1.category == "Maths") {
              announceMath.add(featureData1);
            } else if (featureData1.category == "physic") {
              announcePhysics.add(featureData1);
            } else if (featureData1.category == "programming") {
              announceProgramming.add(featureData1);
            }
            products.add(featureData1);
            //  index++;
          });
          // print( "LEEEEENGHHHH ${announceMath.length}");
          //  print( "LEEEEENGHHHH ${announceProgramming.length}");
        });
      });
    });
    // print("HEEEEEEEEEEELLLLLLLLLLLO");
    // print(products);
    // print(announceMath);
    // print(announceProgramming);
    // print(announcePhysics);
    // print("hhhhhhhhhhheeere you are");
  }

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    getSearchResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ),
        bottomNavigationBar: buttonBar(),
        body: ListView(padding: EdgeInsets.only(left: 20.0), children: <Widget>[
          SizedBox(height: 15.0),
          Text('Student Ads',
              style: TextStyle(
                  fontFamily: 'Schyle',
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold)),
          Divider(
              thickness: 2, indent: 80, endIndent: 110, color: Colors.black),
          SizedBox(height: 15.0),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Color(0xff09bdb4),
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('All',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      )),
                ),
                Tab(
                  child: Text('Math',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      )),
                ),
                Tab(
                  child: Text('Programming',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      )),
                ),
                Tab(
                  child: Text('Physic',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                      )),
                )
              ]),
          Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: <Widget>[
                CookiePage(products),
                CookiePage(announceMath),
                CookiePage(announceProgramming),
                CookiePage(announcePhysics),
              ]))
        ]));
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
              backgroundColor: Colors.grey),
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
            backgroundColor: Colors.grey,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5);
  }

  Widget _buildCard(String category, String title, String description) {
    return Column(children: <Widget>[
      SizedBox(height: 15.0),
      Container(
          padding: EdgeInsets.only(right: 15.0),
          width: MediaQuery.of(context).size.width - 30.0,
          height: MediaQuery.of(context).size.height - 50.0,
          child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.8,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                    child: InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3.0,
                                      blurRadius: 5.0)
                                ],
                                color: Colors.white),
                            child: Column(children: [
                              Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  )),
                              Text(description),
                              SizedBox(height: 7.0),
                              Text(title,
                                  style: TextStyle(
                                      color: Color(0xFFCC8053),
                                      fontFamily: 'Varela',
                                      fontSize: 14.0)),
                              Text(category,
                                  style: TextStyle(
                                      color: Color(0xFF575E67),
                                      fontFamily: 'Varela',
                                      fontSize: 14.0)),
                              Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Container(
                                      color: Color(0xFFEBEBEB), height: 1.0)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.0, right: 5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // if (!added) ...[
                                        Icon(Icons.shopping_basket,
                                            color: Color(0xFFD17E50),
                                            size: 12.0),
                                        Text('Add to cart',
                                            style: TextStyle(
                                                fontFamily: 'Varela',
                                                color: Color(0xFFD17E50),
                                                fontSize: 12.0))
                                      ]))
                            ]))))
              ]))
    ]);
  }
}
