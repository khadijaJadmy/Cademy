import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/model/course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../constant.dart';

class ItemCard extends StatelessWidget {
  final Course product;
  final String name;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.name,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(product.course.nom_formation);
    return GestureDetector(
      onTap: press,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Expanded(
          //   // flex: 2,
          //   child:
          Container(
            // padding: EdgeInsets.all(kDefaultPaddin),
            height: 100,
            width: 150,
            decoration: BoxDecoration(
                // color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(product.image),
                )),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, stops: [
                    0.3,
                    0.9
                  ], colors: [
                    Colors.grey.withOpacity(.5),
                    Colors.grey.withOpacity(.2),
                  ])),
            ),
            // child: Hero(),

            // child: Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.all(15),
            //     child: Text( "${product.formation.toUpperCase()}",style:
            //      TextStyle(fontWeight: FontWeight.w700,color: Colors.white,backgroundColor: Colors.grey[500]),)
            //   ),
            // ),

            // child: Hero(
            //   tag: "${product.formation}",
            //   child: Image.asset(
            //     "assets/images/" + product.image,
            //     width: 100,
            //     height: 50,
            //     fit: BoxFit.cover,
            //   )
            //   ),
            //  ),
            // ),
          ),
          SizedBox(
            height: 15,
          ),
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "${product.nom_formation.toUpperCase()}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),

                ),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // products is out demo list
                name,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 19,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color.fromRGBO(9, 189, 180,1),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.prix == null
                    ? "free"
                    : product.prix + "DH",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                   // backgroundColor: Color.fromRGBO(9, 189, 180,1),
                    ),
              ),
        
              SizedBox(
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}

// Expanded(
//     child: Column(
//   children: [
//     Text(
//       // products is out demo list
//       product.name,
//       style: TextStyle(color: kTextLightColor),
//     ),
//     Divider(
//       height: 7,
//     ),
//     Text(
//       "${product.formation}",
//       style: TextStyle(fontWeight: FontWeight.bold),
//     ),
//   ],
// )
// ),
