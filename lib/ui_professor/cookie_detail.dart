import 'package:crypto_wallet/ui_professor/formationList.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'bottom_bar.dart';

class CookieDetail extends StatelessWidget {
  final description, category, title;

  CookieDetail({this.description, this.category, this.title});
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
        //                   await Register(_emailField.text,
//_passwordField.text);
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
        //                     await SignIn(_emailField.text,
//_passwordField.text);

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
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black54,
                onPressed: () => Navigator.of(context).pop(),
                //Navigator.pushReplacement(
                //   context, MaterialPageRoute(builder: (context) =>
//HomePage()))
              ),
              brightness: Brightness.light,
              elevation: 0.0,
              // backgroundColor: Color(0xa4b6c6)
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: new ColorFilter.mode(
                                  Colors.grey.withOpacity(0.4),
                                  BlendMode.dstATop),
                              image: AssetImage('assets/images/vector.jpg'),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: <Widget>[
                          // Padding(
                          //     padding: EdgeInsets.all(8.0),
                          //     child: FlatButton(
                          //         child: new Icon(Icons.arrow_back),
                          //         onPressed: () {
                          //           Navigator.pushReplacement(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) =>
                          //                       HotelHomeScreen()));
                          //         })),
                          Positioned(
                              child:
                                  // FadeAnimation(1.6,
                                  Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(10.0),
                            // height: 148,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                              // boxShadow: <BoxShadow>[
                              //   BoxShadow(
                              //     color: Colors.white
                              //         .withOpacity(0.6),
                              //     offset: const Offset(4, 4),
                              //     blurRadius: 16,
                              //   ),
                              // ],
                            ),
                            child: Center(
                              child: Text(
                                "Annoncement Detail",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                              //),
                              )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Container(
                        width: double.infinity,
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
                                        color:
                                            Color.fromRGBO(177, 177, 198, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      width: double.infinity,
                                      // height: 200,
                                      margin: const EdgeInsets.all(0),

                                      // height: 148,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(80.0)),
                                        // boxShadow: <BoxShadow>[
                                        //   BoxShadow(
                                        //     color: Colors.white
                                        //         .withOpacity(0.6),
                                        //     offset: const Offset(4, 4),
                                        //     blurRadius: 16,
                                        //   ),
                                        // ],
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      // decoration: BoxDecoration(),
                                      child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'Title',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                                fontFamily: 'Varela')),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('Category',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      )),
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.only(right: (170)),
                                    child: Container(
                                      width: 160,
                                      height: 34,
                                      decoration: BoxDecoration(
                                        // color: Color(0xff09bdb4),
                                        border: Border.all(
                                            color: Color(0xff09bdb4), width: 2),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Align(
                                  //   alignment: Alignment.bottomLeft,
                                  //   child: Padding(
                                  //     padding: EdgeInsets.only(left: 10),
                                  //     child: Container(
                                  //       child: Container(
                                  //         width: 120,
                                  //         height: 30,
                                  //         decoration: BoxDecoration(
                                  //           color: Color(0xff09bdb4),
                                  //           borderRadius:
                                  //               BorderRadius.circular(10),
                                  //         ),
                                  //         child: Align(
                                  //           alignment:
//Alignment.bottomCenter,
                                  //           child: Text(
                                  //             category,
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //             // textAlign: TextAlign.center,
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(height: 20),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('Description',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      )),
                                  SizedBox(height: 10),
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(description,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                                fontFamily: 'Varela')),
                                      )),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                    child: Center(
                                        child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          50.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          color: Color(0xff09bdb4)),
                                      child: Center(
                                        child: Text(
                                          'Response',
                                          style: TextStyle(
                                              fontFamily: 'Varela',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )),
                                    onTap: () {
                                      showAlertDialog(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         centerTitle: true,
//         title: Text('Annoncement Details'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//       body: ListView(children: [
//         SizedBox(height: 15.0),
//         // Padding(
//         //   padding: EdgeInsets.only(left: 20.0),
//         //   child: Text('Annonce detail',
//         //       style: TextStyle(
//         //         fontFamily: 'Schyler',
//         //         fontSize: 32.0,
//         //         fontWeight: FontWeight.bold,
//         //       )),
//         // ),
//         SizedBox(height: 50.0),
//         Center(
//           child: Text(title,
//               style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Varela',
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.w600)),
//         ),

//         SizedBox(height: 20.0),
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0),
//           child: Row(
//             children: [
//               Text(
//                 "Category:",
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 width: 50,
//               ),
//               Text(category.toString().toUpperCase(),
//                   style: TextStyle(
//                       fontFamily: 'Varela',
//                       fontSize: 17.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black)),
//             ],
//           ),
//         ),
//         // Center(
//         //   child: Text(category,
//         //       style: TextStyle(
//         //           fontFamily: 'Varela',
//         //           fontSize: 22.0,
//         //           fontWeight: FontWeight.bold,
//         //           color: Color.fromRGBO(131, 160, 138,1)
//         //           )
//         //         ),
//         // ),

//         // SizedBox(height: 20.0),
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Text(
//             "Description:",
//             style: TextStyle(fontWeight: FontWeight.w500),
//           ),
//         ),

//         Container(
//           width: MediaQuery.of(context).size.width - 50.0,
//           child: Text(description,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontFamily: 'Varela',
//                   fontSize: 16.0,
//                   color: Color(0xFFB4B8B9))),
//         ),
//         // ),
//         SizedBox(height: 60.0),
//         GestureDetector(
//           child: Center(
//               child: Container(
//             width: MediaQuery.of(context).size.width - 50.0,
//             height: 50.0,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25.0),
//                 color: Color.fromRGBO(155, 178, 161, 1)),
//             child: Center(
//               child: Text(
//                 'Response',
//                 style: TextStyle(
//                     fontFamily: 'Varela',
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ),
//           )),
//           onTap: () {
//             showAlertDialog(context);
//           },
//         ),
//       ]),
//     );
//   }

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
        launchWhatsApp();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(
          "Message will be sent to the student via whatsapp or anotherchat integrated to your phone, would you like to continue?"),
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

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+212700233608',
      text: "Hey! I'm professor and I am availble to help you",
    );
    await launch('$link');
  }
}


