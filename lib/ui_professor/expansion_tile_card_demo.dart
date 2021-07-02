import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class ExpansionTileCardDemo extends StatefulWidget {
  @override
  _ExpansionTileCardDemoState createState() => _ExpansionTileCardDemoState();
}

class _ExpansionTileCardDemoState extends State<ExpansionTileCardDemo> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  List<Course> formations = [];
  Future<void> getList() async {
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
                // description: element.data()["description"],
                // category: element.data()['category'],
                createur: (element.data() as dynamic)["createur"],
                nom_formation: (element.data() as dynamic)["nom_formation"],
                category: (element.data() as dynamic)["category"],
                prix: (element.data() as dynamic)["prix"],
                date_sortie: (element.data() as dynamic)["date_sortie"],
                description: (element.data() as dynamic)["description"],
                langue: (element.data() as dynamic)["langue"],
                image: (element.data() as dynamic)["image"],
                nombre_participants:
                    (element.data() as dynamic)["nombre_participants"],
              );
            },
          );

          // featureData2 = Professor(
          //   name: document.data()["name"],
          //   formation: document.data()["formation"],
          //   category: document.data()["category"],
          //   image: document.data()["image"],
          //   course: featureData1,
          // );
          // print("feature data $featureData2");
          setState(() {
            formations.add(featureData1);
            index++;
          });
        });
      });
    });
  }

  @override
  void initState() {
    print("listFormation");
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text("List Formations"),
          ),
      body: Container(
        child: ListView.builder(
          itemCount: formations.length,
          itemBuilder: (context, index) {
            return Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20),
                  child: ExpansionTileCard(
                      baseColor: Colors.cyan[50],
                      expandedColor: Colors.blue[50],
                      key: new GlobalKey(),
                      leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                        "${formations[index].image}",
                        // height: 120,
                        // width: 140,
                        // fit: BoxFit.fill,
                        
                      ),
                      radius: 25,
                      
                      ),
                      title: Text("${formations[index].nom_formation}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)),
                      subtitle: Text(
                          "Publie par : Mr. ${formations[index].createur}",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 20)),
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
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.book,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              "  Categorie :  ${formations[index].category}\n\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.date_range,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              "  Date de sortie : ${formations[index].date_sortie}\n\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.language,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              "  Langue : ${formations[index].langue}\n\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.groups_sharp,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              "  Nombre de particpants :  ${formations[index].nombre_participants}\n\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.price_change_outlined,
                                          size: 17,
                                          color: Colors.red,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              "  Prix :  ${formations[index].prix} DH\n\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ]),
                                  ),
                                ]),
                          ),
                        ),
                      ]))
            ]);
          },
        ),
      ),
    );
  }
}
