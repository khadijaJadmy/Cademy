import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/model/Professor.dart';
import 'package:flutter/material.dart';

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
          color: Colors.grey[200],
          gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
            0.3,
            0.9
          ], colors: [
            Colors.grey.withOpacity(.8),
            Colors.grey.withOpacity(.2),
          ])
       ),
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
                      TextSpan(text: "Proffessor\n",style: TextStyle(color: Colors.black)),
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

                // SizedBox(
                //   height: 6,
                // ),
                Spacer(),

                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child:
                      //CircleAvatar(backgroundImage: 
                      
                       Image.network(
                         product.course.image,
                        fit: BoxFit.fitWidth,
                        width: 106,
                      
                        height: 100,
                        
                      ),
                    
                     // )
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
      //  ),
    );
  }
}
