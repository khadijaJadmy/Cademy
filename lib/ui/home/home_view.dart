import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/home/add_view.dart';
import 'package:crypto_wallet/ui/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  Future<List> listProffesors=getListProf();
  @override
  initState() {
    updateValues();
  }

  updateValues() async {
    bitcoin = await getPrice("bitcoin");
    ethereum = await getPrice("ethereum");
    tether = await getPrice("tether");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return (bitcoin * amount).toStringAsFixed(2);
      } else if (id == "ethereum") {
        return (ethereum * amount).toStringAsFixed(2);
      } else {
        return (tether * amount).toStringAsFixed(2);
      }
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  // .collection('Users')
                  // .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Professors')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data.docs.map((document) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 15, right: 15),
                      child: Container(
                          // width: MediaQuery.of(context).size.width/1.3,
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[400],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 5.0,),
                              Text(
                                "Formation: ${document.data()['name']}",
                                style: TextStyle(
                                  fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Category: ${document.data()['name']}",
                                style: TextStyle(color: Colors.black, fontSize: 15,),
                              ),
                              IconButton(
                                  icon: Icon(Icons.close), onPressed: () async{

                                    await removeCoin(document.id);
                                  }),
                            ],
                          )),
                    );
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddView(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
