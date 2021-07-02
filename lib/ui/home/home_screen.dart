import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constant.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  // HomeScreen(Future<void> list);

  // HomeScreen(Future<List<Professor>> listProf);
  TextEditingController _searchCourseContrller=new TextEditingController();
  QuerySnapshot querySnapshot;

  @override
  Widget build(BuildContext context) {
     int _selectedIndex = 0;  
       void _onItemTapped(int index) {  
         print(index);
          if(index==1){
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
        }  
  
    return Scaffold(
      appBar: buildAppBar(),
    //  body: Body(products),
         bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.home,size: 25,),  
            title: Text('Home'),  
            backgroundColor: Colors.grey,  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.search,size: 25,),  
            title: Text('Dispo prof'),  
            backgroundColor: Colors.grey  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person,size: 25,),  
            title: Text('Profile'),  
            backgroundColor: Colors.grey,  
          ),  
        ],  
        type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex, 
        selectedItemColor: Colors.black,  
        iconSize: 40,  
        onTap: _onItemTapped, 
        elevation: 5  
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg",width: 20,),
        onPressed: () {},
      ),
      actions: <Widget>[
        
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",width: 20,
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {
            print(true);
            print(_searchCourseContrller.text);
            // queryData(_searchCourseContrller.text);
            

          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",width: 20,
            // By default our  icon color is white
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
      title: TextFormField(
        style: TextStyle(color:Colors.black),
        decoration: InputDecoration(
         contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          hintText: 'Search courses',
          hintStyle: TextStyle(color:Colors.grey[500],fontSize: 15),
        ),
        
        controller: _searchCourseContrller,
      ),
      
    );
    
  }
}