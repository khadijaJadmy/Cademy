import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'bottom_bar.dart';

class CookieDetail extends StatelessWidget {
  final description, category, title;

  CookieDetail({this.description, this.category, this.title});
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
        
      ),

      body: ListView(
        children: [
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Annonce detail',
              style: TextStyle(
                      fontFamily: 'Schyler',
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                     
                      
                      )
            ),
          ),
             SizedBox(height: 50.0),
            Center(
              child: Text(title,
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 24.0)),
            ),
      
            SizedBox(height: 20.0),
              Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: Row(
                children: [
                  Text("Category",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(width: 50,),
                  Text(category.toString().toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(131, 160, 138,1)
                      )
                    ),
                ],
              ),
            ),
            // Center(
            //   child: Text(category,
            //       style: TextStyle(
            //           fontFamily: 'Varela',
            //           fontSize: 22.0,
            //           fontWeight: FontWeight.bold,
            //           color: Color.fromRGBO(131, 160, 138,1)
            //           )
            //         ),
            // ),
         
            // SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Description",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            
           Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(description,
                
                textAlign: TextAlign.center,
                style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 16.0,
                      color: Color(0xFFB4B8B9))
                ),
              ),
           // ),
            SizedBox(height: 60.0),
            GestureDetector(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color.fromRGBO( 155, 178, 161,1)
                  ),
                  child: Center(
                    child: Text('Response',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                  ),
                    ),
                    
                  ),
                       
                )
              ),
              onTap: (){
                showAlertDialog(context);
              },
            ),
            
        ]
      ),

    );
  }
  showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
    onPressed:  () {
        Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
    onPressed:  () {
launchWhatsApp();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirmation"),
    content: Text("Message will be sent to the student via whatsapp or another chat integrated to your phone, would you like to continue?"),
      
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
