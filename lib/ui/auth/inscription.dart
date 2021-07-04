import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:crypto_wallet/ui/auth/authentification.dart';
import 'package:crypto_wallet/ui/home/components/body.dart';
import 'package:crypto_wallet/ui/home/home_screen.dart';
import 'package:crypto_wallet/ui/pages/professors.page.dart';
import 'package:crypto_wallet/widgets/animation.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/navBar.dart';
import '../home/home_view.dart';

class Inscription extends StatefulWidget {
  Inscription({Key key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  Future<void> getList() async {
    List<Professor> products = [];
    List<Professor> list = await getListProf();
    products = list;
    print(products);
    print(true);
    return products;
  }

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'student',
      'label': 'Student',
      'icon': Icon(Icons.people),
    },
    {
      'value': 'professor',
      'label': 'Professor',
      'icon': Icon(Icons.school),
      'textStyle': TextStyle(color: Colors.red),
    },
  ];
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _nameField = TextEditingController();
  TextEditingController _statutField = TextEditingController();
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
                      height: 380,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/blog.png'),
                              fit: BoxFit.fill)),
                      child: Stack(
                        children: <Widget>[
                 
                
                       
                          Positioned(
                              child:
                                  // FadeAnimation(1.6,
                                  Container(
                            margin: EdgeInsets.only(top: 330),
                            child: Center(
                              child: Text(
                                "SignIn",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                              //),
                              )
                        ],
                      ),
                    ),
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
                                //          Container(
                                //   padding: EdgeInsets.all(8.0),
                                //   decoration: BoxDecoration(
                                //       border: Border(
                                //           bottom: BorderSide(
                                //               color: Colors.grey[100]))),
                                //   child: TextField(
                                //     controller: _nameField,
                                //     decoration: InputDecoration(
                                //         border: InputBorder.none,
                                //         hintText: "Name",
                                //         hintStyle:
                                //             TextStyle(color: Colors.grey[400])),
                                //   ),
                                // ),
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

                                SelectFormField(
                                  // controller: _statutField,
                                  initialValue: 'student',
                                  icon: Icon(Icons.stacked_bar_chart_outlined),
                                  labelText: 'Statut',
                                  items: _items,
                                  onChanged: (val) { print(val);
                                  setState(() {
                                    _statutField.text=val;
                                  });
                                  },
                                  onSaved: (val) { 
                                     setState(() {
                                    _statutField.text=val;
                                  });
                                  }
                                  
                                  // controller: _statutField,
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
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: _passwordField,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Confirm password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          ),

                          //),
                          SizedBox(
                            height: 20,
                          ),
                          //   FadeAnimation(2,
                          GestureDetector(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    // Color.fromRGBO(155, 178, 161, 1),
                                    // Color.fromRGBO(155, 178, 161, .6),
                                      Color.fromRGBO(9, 189, 180, 1),
                                    Color.fromRGBO(9, 189, 180, 0.4),
                                  ])),
                              child: Center(
                                  child: Text(
                                "Sing In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            onTap: () async {
                              bool shouldNavigate = await Register(
                                  _emailField.text,
                                  _passwordField.text,
                                  _statutField.text);

                              if (shouldNavigate) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        // ProfessorsPage()
                                        //MyNavigationBar(),
                                        Body(),
                                  ),
                                );
                              }
                            },
                          ),

                          //),
                          SizedBox(
                            height: 30,
                          ),

                          //FadeAnimation(1.5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              GestureDetector(
                                child: Text(
                                  "Already have acount,",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          // ProfessorsPage()
                                          //MyNavigationBar(),
                                          Authentification(),
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
