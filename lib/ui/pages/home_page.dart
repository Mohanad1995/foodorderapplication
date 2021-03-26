import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingapp/Helpers/footer.dart';
import 'package:foodorderingapp/Helpers/header.dart';
import 'package:foodorderingapp/Helpers/medil.dart';
import 'package:foodorderingapp/services/generate_map.dart';
import 'package:foodorderingapp/ui/pages/desider.dart';
import 'package:foodorderingapp/ui/pages/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
    void initState() {
      Provider.of<GenerateMaps>(context,listen: false).getCurrentLocation();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF1A1031),
        centerTitle: true,
        title: Text('Home',style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22
        ),),
        actions: [
          IconButton(icon: Icon(EvaIcons.logOutOutline,color: Colors.white,),
              onPressed: ()async{
                SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
                sharedPreferences.remove('uid');
                Navigator.pushReplacement(context,
                    PageTransition(
                      child: Decider(),
                      type: PageTransitionType.leftToRightWithFade,
                    ));
              }
          )
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                Header().headerText(),
                SizedBox(height: 16,),
                Header().headerMenu(BuildContext),
                Divider(),
                Meddile().textFav(),
            Meddile().dataFev(context,'favourite'),
                Meddile().textbusiness(),
                Meddile().dataBusines(context,'business'),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton:Fotter().cutomeFolatingactionbutton(context),
    );
  }
}
