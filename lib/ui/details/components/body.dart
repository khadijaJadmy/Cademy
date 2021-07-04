import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/ui/annonce/announce_list.dart';
import 'package:crypto_wallet/ui/details/components/description.dart';
import 'package:crypto_wallet/ui/details/components/prerequis.dart';
import 'package:crypto_wallet/ui/details/components/product_title_with_image.dart';
import 'package:crypto_wallet/ui/details/components/video.dart';
import 'package:crypto_wallet/ui/home/search_screen.dart';
import 'package:crypto_wallet/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:crypto_wallet/ui/home/components/body.dart' as Home;


class Body extends StatefulWidget {
  final Professor product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedIndex = 0;
  int _selectedIndex = 0;
  int expandedHeight = 85;
  void _onItemTapped(int index) {
    if (index == 2) {
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              SearchScreen(),
        ),
      );
    }
    if (index == 1) {
      print(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              AnnounceList(),
        ),
      );
    }
    if (index == 0) {
      print(index);
  
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              //MyNavigationBar(),
              Home.Body() 
       ),
      );
    }
  }

  // final Professor product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: NavigationDrawerWidget(),
      bottomNavigationBar: buttonBar(),
      body: SafeArea(
        maintainBottomViewPadding: false,
        bottom: true,
        minimum: EdgeInsets.all(4),
        child: 
        CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: false,
              floating: true,
              delegate: CustomSliverDelegate(
                  expandedHeight: 85, product: widget.product),
              ),
            SliverFillRemaining(
              fillOverscroll: true,
              child:  SingleChildScrollView(
                child: Expanded(
                  child: Column(children: <Widget>[
                   
              SizedBox(height: 15,),
                    Description(product: widget.product),
                    Row(
                      children: [
                        Expanded(
                          child: PreRequis(product: widget.product),
                        )
                      ],
                    ),
                    1 > 0
                        ? Padding(
                          padding: const EdgeInsets.only(left:14.0,top: 14),
                          child: Column(
                            
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reviews: ",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Row(children: [
                                  Container(
                                    width: 60,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://i.pinimg.com/originals/cd/d7/cd/cdd7cd49d5442e4246c4b0409b00eb39.jpg"),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9),
                                      color: Colors.amber[50], 
                                      
                                      // gradient: LinearGradient(colors: [
                                      //      Colors.white,
                                      //      Color.fromRGBO(9, 189, 180,1),
                                      //      Colors.white,
                                      // ]
                                    //  ),
                                    ),
                                    padding: EdgeInsets.all(6),
                                    width: MediaQuery.of(context).size.width - 100,
                                    height: MediaQuery.of(context).size.height / 7,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('Meriem Bari'),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Wrap(children: [
                                          RichText(
                                              text: TextSpan(
                                            style: Theme.of(context).textTheme.body1,
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'This is an amazing course for the beginners who want to understand about everything in machine learning. Thank you to the instructors'),
                                            ],
                                          )),
                                        ]),
                                        SizedBox(
                                          height: 5,
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
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(9, 189, 180,1),
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ])
                              ],
                            ),
                        )
                        :
                
                        // SizedBox(height: 30,),
                        //
                        Container(),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BottomNavigationBar buttonBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 25,
              color:   Color.fromRGBO(9, 189, 180,1),
            ),
            title: Text('Home',style: TextStyle(color:   Color.fromRGBO(9, 189, 180,1),),),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.post_add_sharp,
                size: 25,
                 color:   Color.fromRGBO(9, 189, 180,1),
                // color: Colors.black,
              ),
              title: Text('Search',style: TextStyle(color:   Color.fromRGBO(9, 189, 180,1),)),
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
              size: 25,
              // color: Colors.black,
                  color:   Color.fromRGBO(9, 189, 180,1),
            ),
            title: Text('Professors',style: TextStyle(color:   Color.fromRGBO(9, 189, 180,1),)),
            backgroundColor: Colors.grey,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        iconSize: 40,
        onTap: _onItemTapped,
        elevation: 5);
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final Professor product;

  CustomSliverDelegate(
      {@required this.expandedHeight,
      this.hideTitleWhenExpanded = true,
      @required this.product});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return 
    Container(
      // color: Colors.grey[500],
      // height: 800,
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            // bottom: 20.0,
            top: 0,
            child: SingleChildScrollView(
             
              child: 
            ProductTitleWithImage(product: product),)
            
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight * 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    
    return true;
  }
}
