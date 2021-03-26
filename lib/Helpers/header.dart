import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodorderingapp/services/generate_map.dart';
import 'package:foodorderingapp/services/authnitication.dart';
import 'package:foodorderingapp/ui/pages/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Header extends ChangeNotifier{

  Widget headerText(){
    return Container(
      constraints:BoxConstraints(maxWidth: 260.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('What would yoy like', style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Colors.white
          ),),
           SizedBox(height: 0,),
           Text('to eat?', style: TextStyle(
                  fontSize: 49,
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan
                     ),)
                 ],
      )
                 );
  }
  Widget headerMenu(BuildContext){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent,
                   blurRadius: 4.0
                ),
              ],
              borderRadius: BorderRadius.circular(50),
               color: Colors.grey.shade100,
            ),
            height: 40,
            width: 100,
            child: Center(
              child: Text('All Food',style:TextStyle(
                color:Colors.black,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.lightBlueAccent,
                    blurRadius: 4.0
                ),
              ],
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade100,
            ),
            height: 40,
            width: 100,
            child: Center(
              child: Text('Pizza',style:TextStyle(
                  color:Colors.black,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.greenAccent,
                    blurRadius: 4.0
                ),
              ],
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.shade100,
            ),
            height: 40,
            width: 100,
            child: Center(
              child: Text('Pasta',style:TextStyle(
                  color:Colors.black,
                  fontWeight: FontWeight.bold
              ),),
            ),
          ),
        ),
      ],
    );
  }
}