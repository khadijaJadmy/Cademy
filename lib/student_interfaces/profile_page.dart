// import 'package:dating_app/commons/my_info.dart';
// import 'package:dating_app/commons/opaque_image.dart';
// import 'package:dating_app/commons/profile_info_big_card.dart';
// import 'package:dating_app/commons/profile_info_card.dart';
// import 'package:dating_app/pages/super_likes_me_page.dart';
// import 'package:dating_app/styleguide/colors.dart';
// import 'package:dating_app/styleguide/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/commons/my_info.dart';
import 'package:crypto_wallet/commons/opaque_image.dart';
import 'package:crypto_wallet/commons/profile_info_big_card.dart';
import 'package:crypto_wallet/commons/profile_info_card.dart';
import 'package:crypto_wallet/commons/radial_progress.dart';
import 'package:crypto_wallet/commons/rounded_image.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/styleguide/colors.dart';
import 'package:crypto_wallet/styleguide/text_style.dart';
import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:crypto_wallet/ui/details/details_screen.dart';
import 'package:crypto_wallet/ui/home/components/body.dart';
import 'package:crypto_wallet/ui/home/components/item_card.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:crypto_wallet/widgets/navbarBottom.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../constant.dart';

class ProfilePage extends StatefulWidget {
  final Professor professor;

  // ProfilePage(Professor product);

  const ProfilePage({Key key, this.professor}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  // List<String> checked = [
  //   "BAD EXPLANATION",
  //   "BAD EXPLANATION",
  //   "BAD EXPLANATION",
  //   "BAD EXPLANATION",
  //   "BAD EXPLANATION"
  // ];
  bool _isChecked = false;
  List<Course> newList1 = [];
  String _currText = '';
  Future getListCourse() async {
    print("INSIDE LIST COOOOURSE");
    print(widget.professor.id);
    Course featureData1;

    QuerySnapshot featureSnapShot1 = await FirebaseFirestore.instance
        .collection("Professors")
        .doc(widget.professor.id)
        .collection("formations")
        .get();
    await featureSnapShot1.docs.forEach(
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
        );
        print(featureData1);
        setState(() {
          newList1.add(featureData1);
        });
      },
    );
    print("listCourses");
  }

  @override
  void initState() {
    print("CALLING");
    getListCourse();
  }

  List<String> text = ["InduceSmile.com", "Flutter.io", "google.com"];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      //: Color.fromRGBO(9, 189, 180,1),
      bottomNavigationBar: navBarBottomm(),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // OpaqueImage(
                    //   imageUrl: widget.professor.image,
                    // ),
                    OpaqueImage(
                      imageUrl: widget.professor.image,
                    ),

                    Container(
                      // decoration: BoxDecoration(image: DecorationImage(image:AssetImage("assets/images/anne.jpeg"),)),
                      // color: Colors.red,
                      // height: MediaQuery.of(context).size.height,
                      // height: 700,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 13,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.professor.name,
                                textAlign: TextAlign.left,
                                style: headingTextStyle,
                              ),
                            ),
                            // Expanded(
                            //   child:
                            Stack(children: [
                              Container(
                                // height: MediaQuery.of(context).size.height/4,
                                //  decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/anne.jpeg"))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    RadialProgress(
                                        width: 4,
                                        goalCompleted: 0.9,
                                        // child: RoundedImage(
                                        //   imagePath: widget.professor.image,
                                        //   size: Size.fromWidth(120.0),
                                        // ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            widget.professor.image,
                                            width: 100,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: <Widget>[
                                    //     // Image.asset(
                                    //     //   "assets/icons/location_pin.png",
                                    //     //   width: 20.0,
                                    //     //   color: Colors.white,
                                    //     // ),
                                    //     Text(
                                    //       "  34 ",
                                    //       style: whiteSubHeadingTextStyle,
                                    //     )
                                    //   ],
                                    // ),
                                  ],
                                ),
                              ),
                            ]),
                            //  ),
                            // MyInfo(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 8),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        ProfileInfoCard(
                            firstText: "4", secondText: "Number of courses"),
                        SizedBox(
                          width: 10,
                        ),
                        ProfileInfoCard(
                          hasImage: true,
                          imagePath: "assets/icons/pulse.png",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ProfileInfoCard(
                            firstText: "15", secondText: "Joined students"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    Text(
                      "About me",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 130,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showConfirmationDialog(context);
                          },
                          child: Text("Signal",
                              style: TextStyle(color: Colors.red[200])),
                        ),
                        Tooltip(
                          message: "Signal this profesor",
                          child: Icon(
                            Icons.block,
                            color: Colors.red,
                          ),
                          height: 20,
                          padding: const EdgeInsets.all(8.0),
                          preferBelow: false,
                          textStyle: const TextStyle(
                            fontSize: 15,
                          ),
                          showDuration: const Duration(seconds: 2),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final link = WhatsAppUnilink(
                              phoneNumber: '+212700233608',
                              // text:
                              //     "Hey Professor ${product.name} ! I'm a student, and i want to apply to your course of :${product.course.nom_formation}",
                            );
                            await launch('$link');
                          },
                          child: Text("Chat",
                              style: TextStyle(
                                  color: Color.fromRGBO(9, 189, 180, 1),
                                  fontSize: 15)),
                        ),
                        Icon(Icons.chat, color: Color.fromRGBO(9, 189, 180, 1)),
                      ],
                    ),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Wrap(children: [
                        RichText(
                            text: TextSpan(
                                text:
                                    "Jose Marcial Portilla has a BS and MS in Mechanical Engineering from Santa Clara University and years of experience as a professional instructor and trainer for Data Science and programming. He has publications and patents in various fields such as microfluidics, materials science, and data science technologies.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    height: 1.4)))
                      ]),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(children: [
                    Text(
                      "My courses",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
                ]),
              )),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: GridView.builder(
                  itemCount: newList1.length,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: kDefaultPaddin,
                    crossAxisSpacing: kDefaultPaddin,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) => ItemCard(
                      product: newList1[index],
                      name: widget.professor.name,
                      press: () {
                        setState(() {
                          widget.professor.course = newList1[index];
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                product: widget.professor,
                              ),
                            ));
                      })),
            ),
          ),
          // Expanded(child:

          //  )
          // Column(
          //   children: [
          //     Text("if you want to signal the professor"),
          //   ],
          // ),
        ],
      ),
      // ],
      //),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        //  launchWhatsApp();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Fill this request"),
      content: Row(
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = !_isChecked;
              });
            },
          ),
          Text('I am true now'),
        ],
      ),
      //  Column(
      //   children: text
      //       .map((t) => CheckboxListTile(
      //             title: Text(t),
      //             value: _isChecked,
      //             onChanged: (val) {
      //               setState(() {
      //                 _isChecked = true;
      //                 if (val == true) {
      //                   _currText = t;
      //                 }
      //               });
      //             },
      //           ))
      //       .toList(),
      // ),

      //Text("Message will be sent to the student via whatsapp or another chat integrated to your phone, would you like to continue?"),

      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showConfirmationDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog();
      },
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

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  List<bool> _isChecked = [false, false, false, false];
  final snackBar = SnackBar(
    content: Text('Your report has been sent successfully'),
    backgroundColor: Colors.green,
  );
  bool canUpload = false;
  List<String> _texts = [
    "Bad explanation",
    "Professor is not ponctual",
    "Disrespectful behavior",
    "Course is not mastered by the professor"
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Fill this request'),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose reasons why you want to signal this professor"),
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _texts.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(_texts[index]),
                          value: _isChecked[index],
                          onChanged: (val) {
                            setState(() {
                              _isChecked[index] = val;
                              canUpload = true;
                              // for (var item in _isChecked) {
                              //   if (item == false) {
                              //     canUpload = false;
                              //   }
                              // }
                            });
                          },
                        );
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        SizedBox(
            width: 100,
            child: RaisedButton(
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                'Signal',
                style: TextStyle(color: Colors.black),
              ),
            )),
        SizedBox(
            width: 100,
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ))
      ],
    );
  }
}
