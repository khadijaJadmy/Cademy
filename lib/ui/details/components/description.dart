import 'package:crypto_wallet/model/Professor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
// import 'package:flutter_launch/flutter_launch.dart';
import '../../../constant.dart';

class Description extends StatelessWidget {
  Description({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Professor product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Description: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
//               GestureDetector(
//                 onTap:() async{
// showAlertDialog(context);
//                 },
//                 child: Container(
//                   height: 34,
//                   width: 130,
//                   decoration: BoxDecoration(color: Color.fromRGBO(9, 189, 180,1),
//                   borderRadius: BorderRadius.circular(15)
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: RichText(
//                       textAlign: TextAlign.center,
//                       text: TextSpan(
//                         style: Theme.of(context).textTheme.body1.copyWith(
//                           // backgroundColor: Color.fromRGBO(9, 189, 180,1),
//                         ),
//                         children: [
//                              TextSpan(text: 'Apply now ',style: TextStyle(color: Colors.black,fontSize: 18)),
//                               WidgetSpan(
//                             //  child: Padding(
//                               //  padding:  EdgeInsets.only(top: 12.0),
//                               child: Icon(Icons.chat,color: Colors.black,size: 25,),
//                            // ),
//                           ),
                       
                      
                         
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
              // Container(
              //   padding: EdgeInsets.only(right: 40),
              //   child: RaisedButton(
              //       child: Text(

              //         "Apply now",
              //         style: TextStyle(color: Colors.white),

              //       ),
              //       color: Colors.green[300],
              //       onPressed: () async {
              //         showAlertDialog(context);
              //        }),
              // ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8),
              child: Wrap(children: [
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.body1,
                    children: [
                      TextSpan(
                        text: product.course.description,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ]),
        ],
      ),
    );
  }

  final snackbar = SnackBar(
    content: Text("Enter valid mobile number"),
    backgroundColor: Colors.red,
  );
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+212700233608',
      text: "Hey! I'm inquiring about the apartment listing",
    );
    await launch('$link');
  }

  void sendMessage(context) {
    var txt = "700233608";
    if (txt.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      _launchURL(txt);
    }
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

  var _url = "https://api.whatsapp.com/send?phone=212";
  void _launchURL(txt) async => await canLaunch(_url + txt + "?text=Hello")
      ? await launch(_url + txt + "?text=Hello")
      : throw 'Could not launch $_url';
}
