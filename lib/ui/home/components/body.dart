import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:crypto_wallet/ui/annonce/create_announe.dart';
import 'package:crypto_wallet/ui/details/components/video.dart';
import 'package:crypto_wallet/ui/details/details_screen.dart';
import 'package:crypto_wallet/widgets/drawer.dart';
import 'package:crypto_wallet/widgets/navigation_drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constant.dart';
import '../announce_screen.dart';
import '../search_screen.dart';
import 'categories.dart';
import 'item_card.dart';

// class Body extends StatefulWidget  {
//   // List<Professor> products=[new Professor(name: "name", formation: "formation", category: "Maths",image: 'assets/images/bag_2.png'),new Professor(name: "name", formation: "formation", category: "Physics",image: 'assets/images/bag_2.png'),new Professor(name: "name", formation: "formation", category: "Science",image: 'assets/images/bag_3.png'),new Professor(name: "name", formation: "formation", category: "Programming",image: 'assets/images/bag_4.png')];
// //  Future dynamic<List<Professor>> products=getListProf();
//   @override
//   _BodyState createState() => _BodyState();
// }

class Body extends StatefulWidget {
  // Body(this.listProf);
// final List<Professor> listProf;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Professor> products = [];
  List<Course> courses;
  int selectedIndex = 0;
  int _selectedIndex = 0;
  List<String> categories = ["All", "Physics", "Maths", "Programming"];
  TextEditingController _searchCourseContrller = new TextEditingController();

  // _BodyState(List<Professor> listProf);

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
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              Body(),
        ),
      );
    }
  }

  // Future<void> getList() async {
  //   print("getList Functions");
  //   List<Professor> list = await getListCourses();
  //   // products=list;
  //   if (list != null) {
  //     setState(() {
  //       products = list;
  //     });
  //   } else {
  //     NullThrownError();
  //   }
  //   print(products);
  //   print(true);
  // }

  Future<void> getSearchResult() async {
    if (_searchCourseContrller.text != null) {
      // queryData(widget.searchText);
      // print("WE ARE INSIDE GETSEARCHRESULT");
      // print("CONTROLLER VALUE IS ${_searchCourseContrller.text}");
      // List<Professor> list = await queryData(_searchCourseContrller.text);
      // if (list != null) {
      //   print(list);
      //   print("heeere is the results");
      //   setState(() {
      //     products = list;
      //   });
      // }  else {
      //   NullThrownError();
      // }
      List<Course> newList1 = [];
      List<Professor> newList2 = [];
      Course featureData1;
      Professor featureData2;
      String uid = FirebaseAuth.instance.currentUser.uid;
      int index = 0;
      final profRef = Firestore.instance.collection("Professors");
      profRef.getDocuments().then((QuerySnapshot querySnapshot) {
        querySnapshot.documents.forEach((DocumentSnapshot doc) async {
          profRef
              .document(doc.id)
              .get()
              .then((DocumentSnapshot document) async {
            QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
                .collection("Professors")
                .doc(doc.id)
                .collection("formations")
                .where('nom_formation',
                    isEqualTo: _searchCourseContrller.text.toUpperCase())
                .get();
            featureSnapShot1.docs.forEach((element) {
              featureData1 = Course(
                description: element.data()["description"],
                category: element.data()['category'],
                createur: element.data()["createur"],
                nom_formation: element.data()["nom_formation"],
                prix: element.data()["prix"],
                date_sortie: element.data()["date_sortie"],
                langue: element.data()["langue"],
                image: element.data()["image"],
                nombre_participants: element.data()["nombre_participants"],
              );

              featureData2 = Professor(
                name: document.data()["name"],
                formation: document.data()["formation"],
                category: document.data()["category"],
                image: document.data()["image"],
                course: featureData1,
              );
              print("feature data $featureData2");
              // setState(() {
              newList2.add(featureData2);
              print(featureData2.course.category);
              // index++;
              // });
            });
            print("THHHHHEE END OF SEARCH");
            print(newList2);
            print(_searchCourseContrller.text);
            print(products);
            print(newList2.length == 0);
            if (newList2.length != 0) {
              setState(() {
                products = newList2;
              });
            } else {
              setState(() {
                products=[];
              });
              getListCourse();
            }

            // return newList2;
          });
        });
      });
    }
    //  _searchCourseContrller.text = "";
  }

  void getListCoursesbyCategory(String category) async {
    List<Course> newList1 = [];
    List<Professor> newList2 = [];
    Course featureData1;
    Professor featureData2;
    String uid = FirebaseAuth.instance.currentUser.uid;
    int index = 0;

    if (category == 'All') {
      //getListCourse();
      setState(() {
        products = [];
      });
      callFunctionFetch();
    } else {
      setState(() {
        products = [];
      });
      final profRef = Firestore.instance.collection("Professors");
      profRef.getDocuments().then((QuerySnapshot querySnapshot) {
        querySnapshot.documents.forEach((DocumentSnapshot doc) async {
          profRef
              .document(doc.id)
              .get()
              .then((DocumentSnapshot document) async {
            QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
                .collection("Professors")
                .doc(doc.id)
                .collection("formations")
                .where('category', isEqualTo: category)
                .get();
            featureSnapShot1.docs.forEach((element) {
              featureData1 = Course(
                description: element.data()["description"],
                category: element.data()['category'],
                createur: element.data()["createur"],
                nom_formation: element.data()["nom_formation"],
                prix: element.data()["prix"],
                date_sortie: element.data()["date_sortie"],
                langue: element.data()["langue"],
                image: element.data()["image"],
                nombre_participants: element.data()["nombre_participants"],
              );

              featureData2 = Professor(
                name: document.data()["name"],
                formation: document.data()["formation"],
                category: document.data()["category"],
                image: document.data()["image"],
                course: featureData1,
              );
              print("feature data $featureData2");
              setState(() {
                products.add(featureData2);
                print(featureData2.course.category);
                index++;
              });
            });
          });
        });
      });
    }
  }

  // Future<void> getFormationByCategory(String cat) async {
  //   print(true);
  //   print("categroy $cat");

  //   if (cat != null) {
  //     List<Professor> list = await getListCoursesByCategory(cat);
  //     if (list != null) {
  //       setState(() {
  //         products = list;
  //       });
  //     } else {
  //       NullThrownError();
  //     }
  //   } else {
  //     List<Professor> list = await getListCourses();
  //     if (list != null) {
  //       setState(() {
  //         products = list;
  //       });
  //     } else {
  //       NullThrownError();
  //     }
  //   }
  // }

  void getListCourse() async {
    List<Course> newList1 = [];
    List<Professor> newList2 = [];
    Course featureData1;
    Professor featureData2;
    String uid = FirebaseAuth.instance.currentUser.uid;
    int index = 0;
    final profRef = Firestore.instance.collection("Professors");
    profRef.getDocuments().then((QuerySnapshot querySnapshot) {
      querySnapshot.documents.forEach((DocumentSnapshot doc) async {
        profRef.document(doc.id).get().then((DocumentSnapshot document) async {
          QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
              .collection("Professors")
              .doc(doc.id)
              .collection("formations")
              .get();
          featureSnapShot1.docs.forEach(
            (element) {
              featureData1 = Course(
                description: element.data()["description"],
                category: element.data()['category'],
                createur: element.data()["createur"],
                nom_formation: element.data()["nom_formation"],
                prix: element.data()["prix"],
                date_sortie: element.data()["date_sortie"],
                langue: element.data()["langue"],
                image: element.data()["image"],
                nombre_participants: element.data()["nombre_participants"],
                video: element.data()["video"],
              );
              print("inside course");
              print(featureData1);
              featureData2 = Professor(
                name: document.data()["name"],
                formation: document.data()["formation"],
                category: document.data()["category"],
                image: document.data()["image"],
                course: featureData1,
              );
              print("feature data $featureData2");
              // print(featureData2);
              setState(() {
                products.add(featureData2);
                index++;
              });
            },
          );
        });
      });
    });
  }

  void callFunctionFetch() async {
    await getListCourse();
    print("Loaded");
    print(products.length);
  }

  @override
  void initState() {
    super.initState();
    callFunctionFetch();
  }

  @override
  Widget build(BuildContext context) {
    // getFormationByCategory(null);

    return Scaffold(
      appBar: buildAppBar(),
      drawer: NavigationDrawerWidget(),
      bottomNavigationBar: buttonBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                  Row(
                    children: [
                      Text(
                        "Professor",
                        style: TextStyle(color: Colors.black, fontSize: 35),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: GestureDetector(
                            child: Icon(Icons.search, color: Colors.black87),
                            onTap: () {
                              // print(true);
                              // print(_searchCourseContrller.text);
                              // getSearchResult();
                            }),
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                      onSubmitted: (val) {
                        print("THERE IS THE VALUE OF THE VAL");
                        print(val);
                        getSearchResult();
                      },
                      controller: _searchCourseContrller,
                    ),
                  )
                ],
              ),
            ),
            // Categories(),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
                child: SizedBox(
                  height: 25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories != null ? categories.length : 1,
                    itemBuilder: (context, index) => buildCategory(index),
                  ),
                )),

            products == null
                ? Column(
                    children: [
                      Center(
                          //  child:CircularProgressIndicator( )
                          ),
                    ],
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPaddin),
                      child: GridView.builder(
                          // scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: kDefaultPaddin,
                            crossAxisSpacing: kDefaultPaddin,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (context, index) => ItemCard(
                              product: products[index].course,
                              name: products[index].name,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        product: products[index],
                                      ),
                                    ));
                              })),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: Text('List dispo professor'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    //MyNavigationBar(),
                    SearchScreen(),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        getListCoursesbyCategory(categories[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index
                  ? Color.fromRGBO(9, 189, 180, 1)
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/menu.svg",
          width: 20,
        ),
        onPressed: () {
          onPressed:
          () => Scaffold.of(context).openDrawer();
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/notifications.svg", width: 20,
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            print(true);
            print(_searchCourseContrller.text);
            getSearchResult();
            // queryData(_searchCourseContrller.text);
          },
        ),
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
        SizedBox(width: kDefaultPaddin / 2)
      ],
      // title: TextFormField(
      //   style: TextStyle(color: Colors.black),
      //   decoration: InputDecoration(
      //     contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      //     hintText: 'Search courses',
      //     hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
      //   ),
      //   onChanged: (val) {
      //     getSearchResult();
      //   },
      //   controller: _searchCourseContrller,
      // ),
    );
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
                Icons.post_add_sharp,
                size: 25,
                color: Color.fromRGBO(9, 189, 180, 1),
                // color: Colors.black,
              ),
              title: Text('Search',
                  style: TextStyle(
                    color: Color.fromRGBO(9, 189, 180, 1),
                  )),
              backgroundColor: Colors.grey),
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
}
