import 'package:crypto_wallet/model/Professor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../constant.dart';

class ItemCard extends StatelessWidget {
  final Professor product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              // padding: EdgeInsets.all(kDefaultPaddin),
          //  height: 50,
              decoration: BoxDecoration(
                // color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                image: AssetImage( "assets/images/" + product.image,),
              
                )
              ),
              child: Container(
                decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(begin: Alignment.bottomRight,
                stops: [0.3,0.9],colors: [
                  Colors.grey.withOpacity(.8),
                  Colors.grey.withOpacity(.2),

                ])),

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
              //     height: 100,
              //   ),
              ),
              
              
            ),
          ),
          SizedBox(
            height: 15,
          ),
           Column(
            children: [
              
              // Padding(padding: const EdgeInsets.only(left: 0)),
              
              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                   Text(
                // products is out demo list
                product.name,
                style: TextStyle(color: Colors.black),
              ),
                   
             
             
                ],
              ),
            Row(
              children: [
                Wrap(children: [
                  RichText(
                    text: TextSpan(
                      // style: Theme.of(context).textTheme.body1,
                      children: [
                        TextSpan(
                          text: product.formation.toUpperCase(),style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)
                        ),
                      ],
                    ),
                  ),
                ]
                ),
              ],
            ),
                 Row(
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
                          color: Colors.amber,
                        ),
                        
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
              Row(children: [
                  Text(
                "free",
                style: TextStyle(fontWeight: FontWeight.bold,backgroundColor: Colors.orange[200]),
              ),
              SizedBox(
                height: 20,
              )
              ],

              ),
                            

             
            
             
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
