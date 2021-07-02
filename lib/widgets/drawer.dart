import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:flutter/material.dart';



class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.grey[400], Colors.white])),
            child: Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    'https://as1.ftcdn.net/jpg/01/04/52/38/500_F_104523807_OlWjwOuqfhA3hWQi855FEOVQ7DIIS6dg.jpg'),
                // backgroundImage:AssetImage('images/logo.png')
              ),
            ),
          ),
          ListTile(
            title: Text('Dispo Prof', style: TextStyle(fontSize: 20)),
            leading: Icon(
              Icons.assessment_outlined,
              color: Colors.brown[400],
            ),
            trailing: Icon(
              Icons.play_arrow,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  SearchScreen()));
            }
          ),
          Divider(
            height: 5,
          ),
         
      
          ListTile(
            leading: Icon(Icons.account_box, color: Colors.brown[400]),
            title: Text('Mes announces', style: TextStyle(fontSize: 20)),
            trailing: Icon(
              Icons.play_arrow,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>  AnnounceList()));
              // Navigator.of(context).pop();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => CameraPage()));
            },
          ),
          
         
        ],
      ),
    );
  }
}
