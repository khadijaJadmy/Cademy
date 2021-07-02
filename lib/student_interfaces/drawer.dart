import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_960_720.png',
                          ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text("REGURAGUI Abdelghani", style: TextStyle(fontSize: 22, color: Colors.white),),
                  Text("Abdelghani@gmail.com", style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile", style:TextStyle(fontSize: 18)),
            onTap: (){
              Navigator.of(context).pushNamed("");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Parameters", style:TextStyle(fontSize: 18)),
            onTap: (){
              Navigator.of(context).pushNamed("");
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Logout", style:TextStyle(fontSize: 18)),
            onTap: null,
          )
        ],
      ),
    );
  }
}
