import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/announce.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/home/announce_screen.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:crypto_wallet/ui/home/updateAnnoune.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crypto_wallet/firestore/announceController.dart';

import '../../constant.dart';

class AnnounceList extends StatefulWidget {
  const AnnounceList({Key key}) : super(key: key);

  @override
  _AnnounceListState createState() => _AnnounceListState();
}

class _AnnounceListState extends State<AnnounceList> {
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
  int selectedIndex = 0;
  int _selectedIndex = 1;
  int expandedHeight = 85;
  void _onItemTapped(int index) {
    if (index == 2) {
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              SearchScreen(),
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
              AnnounceList(),
        ),
      );
    }
    if (index == 0) {
      print("index $index");
      Navigator.of(context).pop();
    }
  }

  Announce announce;
  ScrollController scrollController = new ScrollController();
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  List<Announce> products = [];

  Future<void> getSearchResult() async {
    // print(query);
    // if (query != "") {
    // queryData(widget.searchText);
    String uid = FirebaseAuth.instance.currentUser.uid;

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("announce")
        .get();
    featureSnapShot1.docs.forEach(
      (element) {
        announce = Announce(
          description: element.data()["description"],
          category: element.data()['category'],
          id: element.data()['id'],
          title: element.data()['title'],
        );
        setState(() {
          products.add(announce);
        });
        // print(featureData1);
      },
    );
    // List<Announce> list = await getAnnounceList();

    // }
    print("LOOOADED ");
    print(products);
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
        appBar: buildAppBar(),
        bottomNavigationBar: navBarBottomm(),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPaddin, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Find your ",
                      style: TextStyle(color: Colors.black87, fontSize: 20),
                    ),
                  ],
                ),
                // Spacer(),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                    ),
                    Text(
                      "Ads",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                      endIndent: 140,
                      indent: 100,
                    )
                  ],
                )
              ],
            ),
          ),
          products == null
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: products.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20),
                              child: ExpansionTileCard(
                                baseColor: Color.fromRGBO(9, 189, 180,0.2),
                                expandedColor: Colors.grey[100],
                                key: new GlobalKey(),
                                // trailing: Icon(Icons.question_answer),
                                leading: Icon(
                                  Icons.question_answer,
                                  color: Color.fromRGBO(9, 189, 180,1),
                                ),

                                title: Text("Category : "+products[index].category.toUpperCase()+"\n"+
                                  products[index].title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Schyler",
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text("Publish at : 2021-07-08"),


                                // subtitle: Text(products[index].category,style: TextStyle(backgroundColor: Colors.blue,color: Colors.white,fontSize: 15),),
                                children: <Widget>[
                                  Divider(
                                    thickness: 1.0,
                                    height: 1.0,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            products[index].description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(fontSize: 16),
                                          ),
                                        
                                        ],
                                      ),
                                    ),
                                  ),
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
                                                  UpdateAnnounceScreen(
                                                      announce:
                                                          products[index]),
                                            ),
                                          ); // cardA.currentState?.expand();
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons
                                                .settings_applications_rounded),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Text('Update'),
                                          ],
                                        ),
                                      ),
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        onPressed: () {
                                          print('IIIDDD');
                                          print(products[index].id);
                                          Future<bool> result = removeAnnounce(
                                              products[index].id);
                                          //  if(result==true){
                                          //  products.remove(products[index]);
                                          setState(() {
                                            products.remove(products[index]);
                                            //  getSearchResult();
                                          });

                                          // getSearchResult();
                                          //  }
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.delete),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Text('Delete'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                )
          //)
        ]));
  }

  Widget buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/back.svg",
          width: 20,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/plus.svg", width: 20,
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    //MyNavigationBar(),
                    AnnounceScreen(),
                //CreateAnnounce(),
              ),
            );
          },
        ),
      ],
    );
  }

  BottomNavigationBar navBarBottomm() {
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
              Icons.post_add_sharp,
              size: 25,
              color: Color.fromRGBO(9, 189, 180, 1),
              // color: Colors.black,
            ),
            title: Text('Search',
                style: TextStyle(
                  color: Color.fromRGBO(9, 189, 180, 1),
                )),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
              size: 25,
              // color: Colors.black,
              color: Color.fromRGBO(9, 189, 180, 1),
            ),
            title: Text('Professors',
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
