import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';


// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {


List<Professor> products;
  Future<void> getFormationByCategory(String cat) async{
    print(true);
    print(cat);
    List<Professor> list= await getListProfByCategory(cat) ;
    products=list;
    print(products[0].formation);
    print(true);
   
    return products;
  }
  List<String> categories = ["All", "Physics", "Maths", "Programming"];
  // By default our first item will be selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
     
        getFormationByCategory(categories[index]);
            
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
       
             
              Text(
                categories[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? kTextColor : kTextLightColor,
                ),
              ),
            
            Container(
              margin: EdgeInsets.only(top: kDefaultPaddin / 4), //top padding 5
              height: 2,
              width: 30,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}