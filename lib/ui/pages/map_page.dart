import 'package:flutter/material.dart';
import 'package:foodorderingapp/services/generate_map.dart';
import 'package:foodorderingapp/ui/pages/my_cart_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Provider.of<GenerateMaps>(context,listen:false).featchMaps(),
          Positioned(
            top:50,
              child: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: (){
              Navigator.pushReplacement(context, PageTransition(
                child: MyCartPage(),
                type: PageTransitionType.fade,
              ));
            },
          )),
          Positioned(
            bottom: 5,
            left: 30,
            child: Container(
              height: 30,
              width: 250,
              color: Colors.white,
              child: Text(Provider.of<GenerateMaps>(context,listen: false).getMainAddress,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),),
        ],
      ),
    );
  }
}
