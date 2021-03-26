
import 'package:flutter/material.dart';
import 'package:foodorderingapp/admin/views/login_page_admin.dart';
import 'package:foodorderingapp/ui/pages/login.dart';
import 'package:page_transition/page_transition.dart';

class Decider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.2,
                      0.45,
                      0.6,
                      0.9
                    ],
                    colors: [
                      Color(0xFFFF6600),
                      Color(0xFFFCF82F),
                      Color(0xFFD3CF00),
                      Color(0xFFFF6600),
                    ])),
          ),
          Transform.translate(
            offset: Offset(0,MediaQuery.of(context).size.height/2-275),
            child: Center(
              child: Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/1.png')),
                ),
              ),
            ),
          ),
          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       //  image: DecorationImage(image: AssetImage('assets/images/1.png')),
          //
          //     image: AssetImage('assets/images/1.png'),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Text('Choose Your Account Type',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),),
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(PageTransition(child:LoginPage(),
                            type: PageTransitionType.rightToLeft));                      },
                      child: Container(
                        width:120,
                        height:45,
                        decoration: BoxDecoration(
                         // border:Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red
                        ),
                        child: Center(
                          child: Text(
                            'Customer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 120,),
                    GestureDetector(
                      onTap: () {
                        // SignInSheet(context);
                        Navigator.of(context).pushReplacement(PageTransition(child:AdminLogin(),
                            type: PageTransitionType.rightToLeft));
                      },
                      child: Container(
                        width:120,
                        height:45,
                        decoration: BoxDecoration(
                         // border:Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red
                        ),
                        child: Center(
                          child: Text(
                            'Employee',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("By continuing you agree Pizzato's Terms of",style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),),
                SizedBox(height: 4,),
                Text("Services & Privacy Policy",style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,

                ),),
                SizedBox(height: 12,),
              ],
            ),
          ),
        ],
      )

    );
  }
}

