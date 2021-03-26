import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodorderingapp/ui/pages/desider.dart';
import 'package:foodorderingapp/ui/pages/home_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
String uid;
String emailUser;
class _SplashPageState extends State<SplashPage> {
  Future getId() async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    uid=sharedPreferences.getString('userId');
    emailUser=sharedPreferences.getString('userEmail');

  }
  @override
  void initState() {
    getId().whenComplete(() {
      Timer(Duration(seconds: 10),()=>Navigator.pushReplacement(context,
          PageTransition(
            child:  uid == null ?Decider():HomePage(),
            type: PageTransitionType.leftToRightWithFade,
          )
      ));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/4.png')),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RichText(text: TextSpan(
                text: 'Food',style: TextStyle(
                fontSize: 22,
                fontWeight:FontWeight.bold,
                color: Colors.cyan,
              ),
                children: <TextSpan>[
                   TextSpan(
                      text:'Delivery',
                      style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  )),
                ]
              )
              ),
            ),

          ],
        ),
      ),
    );
  }
}
