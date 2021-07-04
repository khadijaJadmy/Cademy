
import 'package:crypto_wallet/styleguide/colors.dart';
import 'package:flutter/material.dart';

class OpaqueImage extends StatelessWidget {

  final imageUrl;

  const OpaqueImage({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          imageUrl,
          width: double.maxFinite!=null?double.maxFinite:100,
          height: double.maxFinite!=null?double.maxFinite:100,
          fit: BoxFit.fill,
        ),
        Container(
          color: Color.fromRGBO(9, 189, 180,0.6),
        ),
      ],
    );
  }
}
