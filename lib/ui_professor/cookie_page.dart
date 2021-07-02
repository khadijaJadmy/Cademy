import 'package:crypto_wallet/model/announce.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import 'cookie_detail.dart';

class CookiePage extends StatelessWidget {
  final List<Announce> products;
  
  CookiePage( this.products, {Announce product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {

        return Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                
                      for (var anounce in products)
                      _buildCard(anounce.category,anounce.title,anounce.description,
                      false, false, context),
                    
                  
                  
               
                ],
              )),
          SizedBox(height: 15.0)
        ]);
      
      }
      ),
    );
  }

  Widget _buildCard(String category, String title, String description, bool added,
      bool isFavorite, context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CookieDetail(
                    // assetPath: "imgPath",
                    description:description,
                    title: title,
                    category:category
                  ))
              );
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Wrap(
                       //   mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text:TextSpan(text: title,
                      style: TextStyle(
                          color: Color(0xFFCC8053),
                          fontFamily: 'Varela',
                          fontSize: 15.0,fontWeight: FontWeight.bold)
                          
                          ),textAlign: TextAlign.center,),
                           SizedBox(height: 10.0),
                          //   isFavorite
                          //       ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                          //       : Icon(Icons.favorite_border,
                          //           color: Color(0xFFEF7532))
                            ]
                          )),
                    Divider(thickness: 1,indent: 50,endIndent: 50,color: Color(0xFFCC8053),),
                    // SizedBox(height: 10.0),
                
                        Container(
                          height: 75.0,
                          width: 75.0,
                      
                          child: Text(description+"...",maxLines: 3,),
                          ),
                  SizedBox(height: 7.0),
                
                  Text("user name",
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontFamily: 'Varela',
                          fontSize: 14.0)),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
                  Padding(
                      padding: EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // if (!added) ...[
                              Icon(Icons.question_answer,
                                  color: Color.fromRGBO(155, 178, 161 ,1), size: 20.0),
                              GestureDetector(
                                onTap: (){
                                  showAlertDialog(context);
                                },
                                child: Container(
                                  width: 90,
                                  height: 27,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color.fromRGBO(155, 178, 161 ,1)),
                                  child: Text('Response',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.white,
                                          // fontWeight: FontWeight.bold,
                              
                                          fontSize: 15.0),textAlign: TextAlign.center,),
                                ),
                              )
                       
                          ]))
                ]))));
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
