import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/user.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/auth/inscription.dart';
import 'package:crypto_wallet/ui/home/components/body.dart';
import 'package:crypto_wallet/ui/home/home_screen.dart';
import 'package:crypto_wallet/ui/pages/professors.page.dart';
import 'package:crypto_wallet/ui_professor/annonce_student_list.dart';
import 'package:crypto_wallet/widgets/animation.dart';
import 'package:flutter/material.dart';

import '../../widgets/navBar.dart';
import '../home/home_view.dart';

class Authentification extends StatefulWidget {
  Authentification({Key key}) : super(key: key);

  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
 

  Future<void> verifyStatutOfUser(String uid) async {
    print("VALUEEE FALSE");
    print(uid);
    User featureData;
    QuerySnapshot featureSnapShot =
        await FirebaseFirestore.instance.collection("Users").get();
    featureSnapShot.docs.forEach(
      (element) {
        if (element.id == uid) {
          featureData = User(
            name: element.data()["name"],
            statut: element.data()["statut"],
            email: element.data()["email"],
          );
        }
      },
    );
    if (featureData.statut == "student") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              // ProfessorsPage()
              //MyNavigationBar(),
              Body(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              // ProfessorsPage()
              //MyNavigationBar(),
             // Inscription(),
              AnnounceListStudents(),
        ),
      );
    }
  }

  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
    final snackBar = SnackBar(
    content: Text('Email or password incorrect, retry please !'),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   body: Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     decoration: BoxDecoration(
        //       color: Colors.grey[400],
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           width: MediaQuery.of(context).size.width / 1.3,
        //           child: TextFormField(
        //             style: TextStyle(color: Colors.white),
        //             controller: _emailField,
        //             decoration: InputDecoration(
        //               hintText: "something@email.com",
        //               hintStyle: TextStyle(
        //                 color: Colors.white,
        //               ),
        //               labelText: "Email",
        //               labelStyle: TextStyle(
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: MediaQuery.of(context).size.height / 35),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 1.3,
        //           child: TextFormField(
        //             style: TextStyle(color: Colors.white),
        //             controller: _passwordField,
        //             obscureText: true,
        //             decoration: InputDecoration(
        //               hintText: "password",
        //               hintStyle: TextStyle(
        //                 color: Colors.white,
        //               ),
        //               labelText: "Password",
        //               labelStyle: TextStyle(
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: MediaQuery.of(context).size.height / 35),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 1.4,
        //           height: 45,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(15.0),
        //             color: Colors.white,
        //           ),
        //           child: MaterialButton(
        //             onPressed: () async {
        //               bool shouldNavigate =
        //                   await Register(_emailField.text, _passwordField.text);
        //               if (shouldNavigate) {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => Body(),
        //                   ),
        //                 );
        //               }
        //             },
        //             child: Text("Register"),
        //           ),
        //         ),
        //         SizedBox(height: MediaQuery.of(context).size.height / 35),
        //         Container(
        //           width: MediaQuery.of(context).size.width / 1.4,
        //           height: 45,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(15.0),
        //             color: Colors.white,
        //           ),
        //           child: MaterialButton(
        //               onPressed: () async {
        //                 bool shouldNavigate =
        //                     await SignIn(_emailField.text, _passwordField.text);

        //                 if (shouldNavigate) {

        //                   Navigator.push(
        //                     context,
        //                     MaterialPageRoute(
        //                       builder: (context) =>
        //                       // ProfessorsPage()
        //                       //MyNavigationBar(),
        //                      Body(),
        //                     ),
        //                   );
        //                 }
        //               },
        //               child: Text("Login")),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 459,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/blog.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                      
                    
                    
                          Container(
                            margin: EdgeInsets.only(top: 390),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Cademy",
                                    style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w500),
                                  ),
                                  Divider(thickness: 2, indent: 140,endIndent: 130,color: Colors.black,)
                                ],
                              ),

                            ),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(height: 6,),
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        children: <Widget>[
                          //   FadeAnimation(1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(177, 177, 198, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    controller: _emailField,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordField,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //),
                          SizedBox(
                            height: 30,
                          ),
                          //   FadeAnimation(2,
                          GestureDetector(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    // Color.fromRGBO(155, 178, 161, 1),

                                    Color.fromRGBO(9, 189, 180, 1),
                                    Color.fromRGBO(9, 189, 180, 0.4),
                                    // Color.fromRGBO(155, 178, 161, .6),
                                  ])),
                              child: Center(
                                  child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            onTap: () async {
                              String shouldNavigate = await SignIn(
                                  _emailField.text, _passwordField.text);
                              if(shouldNavigate=="false"){
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              }
                              verifyStatutOfUser(shouldNavigate);
                            },
                          ),

                          //),
                          SizedBox(
                            height: 70,
                          ),

                          //FadeAnimation(1.5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  //  color: Color.fromRGBO(143, 148, 251, 1)
                                    ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                child: Text(
                                  "Create acount,",
                                  style: TextStyle(
                                   //   color: Color.fromRGBO(143, 148, 251, 1)
                                   ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          // ProfessorsPage()
                                          //MyNavigationBar(),
                                          Inscription(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          //),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
