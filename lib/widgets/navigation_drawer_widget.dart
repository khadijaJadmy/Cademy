import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/student_interfaces/profile.dart';
import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:crypto_wallet/ui/auth/authentification.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:crypto_wallet/ui/pages/favourites_page.dart';
import 'package:crypto_wallet/ui/pages/people_page.dart';
import 'package:crypto_wallet/ui/pages/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  String name = "User";
  String image =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";
  getNameImageUser() async {
    await FirebaseFirestore.instance
        .collection('Students')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        name = value.data()['name'];
        image:
        value.data()['image'];
      });
    });
  }

  @override
  void initState() {
    getNameImageUser();
  }

  @override
  Widget build(BuildContext context) {
    // final name =  FirebaseAuth.instance.currentUser.displayName.toString();
    final email = FirebaseAuth.instance.currentUser.email;
    final urlImage = image;

    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name:
                      FirebaseAuth.instance.currentUser.displayName.toString(),
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  //const SizedBox(height: 12),
                  //buildSearchField(),
                  Divider(color: Colors.black54),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Online Professors',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),

                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'My ads',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'My profil',
                    icon: Icons.person,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 32),
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
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.black;
    final hoverColor = Colors.black87;

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
          builder: (context) => SearchScreen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AnnounceList(),
        ));
        // Navigator.push(
        //           context, MaterialPageRoute(builder: (context) =>  AnnounceList()));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Profile(),
        ));
        break;
    }
  }
}
