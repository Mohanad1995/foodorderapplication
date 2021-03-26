import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingapp/ui/pages/my_cart_page.dart';
import 'package:page_transition/page_transition.dart';

class Fotter extends ChangeNotifier{
Widget cutomeFolatingactionbutton(BuildContext context){
  return FloatingActionButton(
    backgroundColor: Colors.lightGreenAccent,
      onPressed:(){
        Navigator.of(context).pushReplacement(PageTransition(
            child: MyCartPage(),
            type: PageTransitionType.rightToLeftWithFade));
      },
      child: Icon(EvaIcons.shoppingBag,color: Colors.black87,),
  );
}
}