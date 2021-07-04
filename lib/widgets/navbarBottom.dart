import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:flutter/material.dart';

class NavBarBottom extends StatefulWidget {
   
NavBarBottom({ Key key }) : super(key: key);

  @override
  _NavBarBottomState createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
int selectedIndex = 0;

  int _selectedIndex = 0;

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
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      
    );
  }

  BottomNavigationBar buttonBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 25,
                color: Colors.black,
              ),
              title: Text('Search'),
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 25,
              color: Colors.black,
            ),
            title: Text('Profile'),
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}