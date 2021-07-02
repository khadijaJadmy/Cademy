import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class CartReview extends StatefulWidget {
  @override
  _CartReviewState createState() => _CartReviewState();
}

class _CartReviewState extends State<CartReview> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ExpansionCard(
          
      // background: Image.asset("assets/animations/sleep.gif"),
      title: Container(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Header",
              style: TextStyle(
                fontFamily: 'BalooBhai',
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            // Text(
            //   "Sub",
            //   style: TextStyle(
            //       fontFamily: 'BalooBhai', fontSize: 20, color: Colors.white),
            // ),
          ],
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 7),
          child: Text("Content goes over here !",
              style: TextStyle(
                  fontFamily: 'BalooBhai', fontSize: 20, color: Colors.white)),
        )
      ],
    ));
  }
}
