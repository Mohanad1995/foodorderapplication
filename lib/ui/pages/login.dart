import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodorderingapp/services/authnitication.dart';
import 'package:foodorderingapp/ui/pages/home_page.dart';
import 'package:foodorderingapp/ui/pages/splash_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white70,
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
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
                      Color(0xFF200B4B),
                      Color(0xFF201F22),
                      Color(0xFF1A1031),
                      Color(0xFF19181F),
                    ])),
              ),
              Transform.translate(
                offset: Offset(0,70),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/2.png')),
                  ),
                ),
              ),
              Positioned(
                top: 350,
                  left: 8,
                  child: Container(
                    width: 200,
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Food',style: TextStyle(
                          fontSize: 46,
                          fontWeight:FontWeight.bold,
                          color: Colors.greenAccent,
                        )),
                      Text('Delivery', style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          )),
                      Text('Service', style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.red
                          )),
                      ],
                    ),
                  ),
              ),
              Positioned(
                bottom: 90,
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
                            logInSheet(context);
                          },
                          child: Container(
                            width:100,
                            height:50,
                            decoration: BoxDecoration(
                              border:Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                       // SizedBox(width: 120,),
                        GestureDetector(
                          onTap: () {
                            SignInSheet(context);
                          },
                          child: Container(
                            width:100,
                            height:50,
                            decoration: BoxDecoration(
                              border:Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                'Signin',
                                style: TextStyle(
                                    color: Colors.cyan,
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
                   Text("By continuing you agree Food Delivery's Terms of",style: TextStyle(
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
             )
            ],
          )),
    );
  }

  logInSheet(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
       // isScrollControlled: true,
        builder: (context) {
         // bottom: MediaQuery.of(context).viewInsets.bottom),
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xFF191531),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 30,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blueAccent,
                    onPressed: () {
                      if (emailController.text.isNotEmpty) {
                        Provider.of<CustomAuthintication>(context,
                                listen: false)
                            .logIntoAccount(
                                emailController.text, passwordController.text)
                            .whenComplete(() {
                          if (Provider.of<CustomAuthintication>(context,
                                      listen: false)
                                  .getMessageErorr ==
                              '') {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  child: HomePage(),
                                  type: PageTransitionType.leftToRight,
                                ));
                          } else if (Provider.of<CustomAuthintication>(
                                      context,
                                      listen: false)
                                  .getMessageErorr !=
                              '') {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  child: LoginPage(),
                                  type: PageTransitionType.leftToRight,
                                ));
                          }
                        });
                      } else {
                        Text('fill all text feild');
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.check,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  SignInSheet(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return showModalBottomSheet(
        context: context,
         isScrollControlled: true,
//      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        builder: (context) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xFF191531),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      if (emailController.text.isNotEmpty) {
                        Provider.of<CustomAuthintication>(context,
                                listen: false)
                            .createAccount(
                                emailController.text, passwordController.text)
                            .whenComplete(() {
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: HomePage(),
                                type: PageTransitionType.leftToRight,
                              ));
                        });
                      }
                      //     .whenComplete(() {
                      //   print('complete');
                      //   Provider.of<FirebaseOperation>(context,listen: false).CreateUserCollection(context,{
                      //     'userid':Provider.of<Auth>(context,listen: false).getUserUid,
                      //     'username':usernameController.text,
                      //     'useremail':emailController.text,
                      //
                      //     // 'userimage': Provider.of<LandingUtils>(context,listen: false).userAvatarUrl,
                      //   });
                      // })
                      else {
                        Text('fill all text feild');
                      }

                    },
                    child: Icon(
                      FontAwesomeIcons.check,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
