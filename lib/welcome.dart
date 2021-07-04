import 'package:crypto_wallet/ui/auth/authentification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = Duration(seconds: 6);
    // delayed 3 seconds to next page
    Future.delayed(d, () {
      // to next page and close this page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Authentification();
          },
        ),
        (route) => false,
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
           gradient: LinearGradient(colors: [
             Color.fromRGBO(9, 189, 180, 0.3),
              Color.fromRGBO(9, 189, 180, 0.2),
               Color.fromRGBO(9, 189, 180, 0.5),
                Color.fromRGBO(9, 189, 180, 1),

           ])
          // image: DecorationImage(
          //     image: AssetImage('assets/images/bg2.jpg'),
          //     fit: BoxFit.fitHeight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Welcome to Cademy",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400 ),textAlign: TextAlign.center,),
              Align(
                child: Container(
                  width: 150,
                  height:3,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20,),
           //   Image.asset('assets/images/logo.jpeg')
            //  SvgPicture.asset('assets/images/logo.jpeg'),
            ],
          ),
        ),
      ),
    );
  }
}
