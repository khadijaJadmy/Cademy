import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/user.dart' as Users;
import 'package:crypto_wallet/student_interfaces/profile.dart';
import 'package:crypto_wallet/ui/auth/authentification.dart';
import 'package:crypto_wallet/ui/pages/user_page.dart';

import 'package:crypto_wallet/ui_professor/annonce_student_list.dart';
import 'package:crypto_wallet/ui_professor/courses/addCourse.dart';
import 'package:crypto_wallet/ui_professor/courses/createProf.dart';
import 'package:crypto_wallet/ui_professor/courses/myCourses.dart';
import 'package:crypto_wallet/ui_professor/page/ajoute_formation.dart';
import 'package:crypto_wallet/ui_professor/page/formation_list.dart';
import 'package:crypto_wallet/ui_professor/page/mes_formations.dart';
import 'package:crypto_wallet/ui_professor/page/offre_page.dart';
import 'package:firebase_auth/firebase_auth.dart' ;

import 'package:flutter/material.dart';

import '../expansion_tile_card_demo.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

     String name = "name";
    String  email = FirebaseAuth.instance.currentUser.email;
    final urlImage =
        'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png';

    Future<void> getUserInfo() async {
      Users.User user;
      QuerySnapshot featureSnapShot1 =
          await FirebaseFirestore.instance.collection("Users").get();
      featureSnapShot1.docs.forEach((element) {
        if (element.documentID == FirebaseAuth.instance.currentUser.uid) {
          user = new Users.User(
            name: element.data()['name'],
            email: element.data()['email'],
          );
          setState(() {
            name = user.name!=null?user.name:name;
            email = user.email!=null?user.email:email;
          });
        }
      });
    
    }
  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
  }
  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: Material(
        color: Color.fromRGBO(155, 178, 161, 1),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: 'Sarah Abs',
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  // const SizedBox(height: 6),
                  // buildSearchField(),
                  const SizedBox(height: 20),
                  buildMenuItem(
                      text: 'List of courses',
                      icon: Icons.book,
                      onClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExpansionTileCardDemo(),
                            ));
                      }),
                  const SizedBox(height: 6),
                  buildMenuItem(
                    text: 'List of announces',
                    icon: Icons.local_offer,
                    onClicked: () =>
                        //   Navigator.of(context).push(MaterialPageRoute(
                        // builder: (context) => AnnounceListStudents(),
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnnounceListStudents(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  buildMenuItem(
                    text: 'Add course',
                    icon: Icons.add,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AddCourse(FirebaseAuth.instance.currentUser.uid),
                    )),
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 20),
                  buildMenuItem(
                    text: 'My courses',
                    icon: Icons.book,
                    onClicked: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CourseList(),
                    )),
                  ),
                  buildMenuItem(
                      text: 'Profil',
                      icon: Icons.account_circle_outlined,
                      onClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateProf()));
                      }),

                  buildMenuItem(
                      text: 'Log Out',
                      icon: Icons.logout,
                      onClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Authentification()));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    @required String urlImage,
    @required String name,
    @required String email,
    @required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
              // Spacer(),
              // CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.black),
              // )
            ],
          ),
        ),
      );

  Widget buildSearchField() {
    final color = Colors.black;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => formationpage(),
        ));
        break;
    }
  }
}
