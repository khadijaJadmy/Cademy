import 'package:crypto_wallet/model/Professor.dart';
import 'package:crypto_wallet/ui/details/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant.dart';

class DetailsScreen extends StatelessWidget {
 
  final Professor product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.grey[500],
      appBar: buildAppBar(context),
      body: 
      Body(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        // icon: SvgPicture.asset('assets/icons/back.svg', color: Colors.white,),
         icon: SvgPicture.asset("assets/icons/menu.svg",width: 25,color: Colors.black,),
        onPressed: () => Navigator.pop(context),
      ),

    );
  }
}
