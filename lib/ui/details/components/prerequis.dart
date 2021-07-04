import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/ui/details/components/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';
import '../../../constant.dart';

class PreRequis extends StatelessWidget {
  const PreRequis({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Professor product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "What you'll learn: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Wrap(children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  // TextSpan(text: 'Created with '),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.check,
                        size: 20,
                      ),
                    ),
                  ),
                  TextSpan(
                      text:
                          'Handle advanced techniques like Dimensionality Reduction'),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  // TextSpan(text: 'Created with '),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.check,
                        size: 20,
                      ),
                    ),
                  ),
                  TextSpan(
                      text:
                          'Discover the keys to positive and effective communication'),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  // TextSpan(text: 'Created with '),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.check,
                        size: 20,
                      ),
                    ),
                  ),
                  TextSpan(
                      text:
                          'Use professional tools and techniques to progress and guide others'),
                ],
              ),
            )
          ]),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 60),
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: VideoPlayerScreen(product.course.video),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Requirements: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
              // children: [
              // Wrap(
              // spacing: 20,
              // runAlignment: WrapAlignment.start,
              children: [
                // DecoratedBox(decoration: BoxDecoration(shape: BoxShape.rectangle,color: Colors.black)),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.body1,
                    children: [
                      // TextSpan(text: 'Created with '),

                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 12),
                          child: Icon(
                            Icons.panorama_fisheye,
                            size: 15,
                            color: Colors.blue,
                          ),
                        ),
                      ),

                      TextSpan(
                        text: product.course.prerequis==null?'Aucune formation préalable requise':product.course.prerequis,
                      ),
                    ],
                  ),
                )
              ]
              //),
              //],
              ),
          SizedBox(
            height: 10,
          ),
          //  Container(margin: EdgeInsets.only(left:50),child: VideoPlayerScreen()),

          // GestureDetector(
          //     onTap: () {},
          //     child: Text(
          //       "See Professor profile",
          //       style: TextStyle(
          //           color: Colors.blue,
          //           fontSize: 12,
          //           fontWeight: FontWeight.bold),
          //     )
          //   ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Text(
          //       "Reviews: ",
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 7,
          // ),
          // Row(children: [
          //   Container(
          //     width: 65,
          //     height: 65,
          //     decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         image: DecorationImage(
          //             image: NetworkImage(
          //                 "https://i.pinimg.com/originals/cd/d7/cd/cdd7cd49d5442e4246c4b0409b00eb39.jpg"),
          //             fit: BoxFit.cover)),
          //   ),
          //   SizedBox(
          //     width: 12,
          //   ),
          //   Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(9),
          //       color: Colors.amber[50],
          //     ),
          //     padding: EdgeInsets.all(6),
          //     width: MediaQuery.of(context).size.width - 100,
          //     height: MediaQuery.of(context).size.height / 7,
          //     child: Column(
          //       children: [
          //         Row(
          //           children: [
          //             Text('Meriem Bari'),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 4,
          //         ),
          //         Wrap(children: [
          //           RichText(
          //               text: TextSpan(
          //             style: Theme.of(context).textTheme.body1,
          //             children: [
          //               TextSpan(
          //                   text:
          //                       'This is an amazing course for the beginners who want to understand about everything in machine learning. Thank you to the instructors'),
          //             ],
          //           )),
          //         ]),
          //         SizedBox(
          //           height: 5,
          //         ),
          //         Row(
          //           children: [
          //             RatingBar.builder(
          //               initialRating: 3,
          //               minRating: 1,
          //               direction: Axis.horizontal,
          //               allowHalfRating: true,
          //               itemCount: 5,
          //               itemSize: 19,
          //               itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          //               itemBuilder: (context, _) => Icon(
          //                 Icons.star,
          //                 color: Colors.amber,
          //               ),
          //               onRatingUpdate: (rating) {
          //                 print(rating);
          //               },
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ]
          //     //),
          //     //],
          //     )
        ],
      ),
    );
  }
}
