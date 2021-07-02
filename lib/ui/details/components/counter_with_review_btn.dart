import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expansion_card/expansion_card.dart';
import 'cart_counter.dart';
import 'cart_review.dart';

class CounterWithReviewBtn extends StatelessWidget {
  const CounterWithReviewBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   // print("heeey");
      //   new Column(
      //     children: _buildExpandableContent(),
      //   );
      // },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // CartCounter(),
          
          Container(
            padding: EdgeInsets.all(8),
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset("assets/icons/rating.svg"),
          ),
          
        ],
        
      )
      ,
    );
  }

}
