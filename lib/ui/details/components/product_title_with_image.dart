import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../constant.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Professor product;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,

      // height: MediaQuery.of(context).size.height+100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.grey[200],
          gradient: LinearGradient(
          //   begin: Alignment.bottomRight,
          //    stops: [
          //   0.3,
          //   0.9
          // ], 
          colors: [
            Color.fromRGBO(9, 189, 180, 0.2),
            Color.fromRGBO(9, 189, 180, 0.3),
            Color.fromRGBO(9, 189, 180, 0.5),
            Color.fromRGBO(9, 189, 180, 1)
            // Colors.grey.withOpacity(.8),
            // Colors.grey.withOpacity(.2),
          ])),
      // padding: EdgeInsets.only(top: 40,left:10),
      // margin: EdgeInsets.only(top:40),
      // child: Padding(
      // padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.course.nom_formation.toUpperCase(),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: kDefaultPaddin),
            Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Proffessor\n",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: "${product.name}",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '\n\nCategory : ' + product.course.category,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),

              
                // Spacer(),

                Padding(
                  
                  padding: const EdgeInsets.only(top: 50,left:30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          showAlertDialog(context);
                        },
                        child: Container(
                          height: 30,
                          width: 128,
                          decoration: BoxDecoration(
                              gradient:LinearGradient(colors: [ Color.fromRGBO(9, 189, 180, 1),Colors.white,]),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.only(left:3.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: Theme.of(context).textTheme.body1.copyWith(
                                    // backgroundColor: Color.fromRGBO(9, 189, 180,1),
                                    ),
                                children: [
                                  TextSpan(
                                      text: 'Apply now ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                  // WidgetSpan(
                                  //   //  child: Padding(
                                  //   //  padding:  EdgeInsets.only(top: 12.0),
                                  //   child: Icon(
                                  //     Icons.chat,
                                  //     color: Colors.black,
                                  //     size: 20,
                                  //   ),
                                  //   // ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(18.0),
                      //   child:
                      //   //CircleAvatar(backgroundImage:

                      //    Image.network(
                      //      product.course.image,
                      //     fit: BoxFit.fitWidth,
                      //     width: 106,

                      //     height: 100,

                      //   ),

                      //  // )
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
      //  ),
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
        launchWhatsApp();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(
          "Message will be sent to the student via whatsapp or another chat integrated to your phone, would you like to continue?"),
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
      text: "Hey Professor ${product.name} ! I'm a student, and i want to apply to your course of :${product.course.nom_formation}",
    );
    await launch('$link');
  }

}

