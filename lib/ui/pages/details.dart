import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodorderingapp/services/calculation.dart';
import 'package:foodorderingapp/ui/pages/home_page.dart';
import 'package:foodorderingapp/ui/pages/my_cart_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  DetailsPage({this.queryDocumentSnapshot});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int cheesValue=0;
  int beaconValue=0;
  int onionValue=0;
  int totalItems=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat,
      body: Container(
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
        child: Column(
          children: [
            customAppBar(),
            PizzaImage(),
            textData(),
            customContainer(),
          ],
        ),
      ),
    );
  }

  Widget customAppBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 12,right: 12, top: 32,bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(PageTransition(
                    child: HomePage(),
                    type: PageTransitionType.rightToLeftWithFade));
              }),
          IconButton(
              icon: Icon(FontAwesomeIcons.trash),
              color: Colors.red,
              onPressed: () {
               Provider.of<Calculation>(context,listen:false).removeAllData();

              }),
        ],
      ),
    );
  }

  Widget PizzaImage() {
    return Center(
      child:
      CircleAvatar(
        backgroundImage: NetworkImage(widget.queryDocumentSnapshot['image']),
        radius: 100,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget textData() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow.shade700,
              ),
              Text(
                widget.queryDocumentSnapshot['ratings'],
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.queryDocumentSnapshot['name'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.rubleSign,
                    color: Colors.cyan,
                  ),
                  Text(
                    widget.queryDocumentSnapshot['price'].toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.cyan),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget customContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, top: 12, bottom: 12, right: 6),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white.withOpacity(0.70),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlueAccent,
                    blurRadius: 2,
                    spreadRadius: 3,
                  )
                ]),
            height: 300,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:16),
                    child: Text(
                      'Add more stuff',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Cheese',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(icon:Icon(EvaIcons.minus),
                              onPressed:(){
                            Provider.of<Calculation>(context,listen:false).minusCheese();
                              }),
                          Text(
                            Provider.of<Calculation>(context,listen:false).getCheeseValue.toString(),
                            style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 20,
                          ),),
                          IconButton(icon:Icon(EvaIcons.plus),
                              onPressed:(){
                                Provider.of<Calculation>(context,listen:false).addCheese();
                              }),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Onion',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(icon:Icon(EvaIcons.minus),
                              onPressed:(){
                                Provider.of<Calculation>(context,listen:false).minusonion();
                              }),
                          Text(Provider.of<Calculation>(context,listen:true).getonionValue.toString()
                           ,style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 20,
                          ),),
                          IconButton(icon:Icon(EvaIcons.plus),
                              onPressed:(){
                                Provider.of<Calculation>(context,listen:false).addonion();
                              }),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Beacon',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(icon:Icon(EvaIcons.minus),
                              onPressed:(){
                               Provider.of<Calculation>(context,listen:false).minusbeacon();
                              }),
                          Text(
                           Provider.of<Calculation>(context,listen:false).getbeaconValue.toString(),
                            style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 20,
                          ),),
                          IconButton(icon:Icon(EvaIcons.plus),
                              onPressed:(){
                              Provider.of<Calculation>(context,listen:false).addbeacon();
                              }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             GestureDetector(
               onTap:(){
                 Provider.of<Calculation>(context,listen:false).selectsmallsize();
               },
               child: Container(
                   width: 25,
                   height: 30,
                   decoration: BoxDecoration(
                         color:Provider.of<Calculation>(context,listen:true).smallTapped? Colors.lightBlue:Colors.white,
                     border:Border.all(color: Colors.lightBlue),
                     borderRadius: BorderRadius.circular(5),
                   ),
                   child:Center(
                     child: Text('S',style: TextStyle(
                       color: Colors.black,
                     ),),
                   )
               ),
             ),
             GestureDetector(
               onTap: (){
                 Provider.of<Calculation>(context,listen:false).selectmediumsize();
               },
               child: Container(
                 width: 25,
                   height: 30,
                   decoration: BoxDecoration(
                     color:Provider.of<Calculation>(context,listen:false).mediumTapped? Colors.lightBlue:Colors.white,
                     border:Border.all(color: Colors.lightBlue),
                     borderRadius: BorderRadius.circular(5),
                   ),
                   child:Center(
                     child: Text('M',style: TextStyle(
                       color: Colors.black,
                     ),),
                   )
               ),
             ),
             GestureDetector(
               onTap: (){
                 Provider.of<Calculation>(context,listen:false).selectlargesize();
               },
               child: Container(
                   width: 25,
                   height: 30,
                   decoration: BoxDecoration(
                    color:Provider.of<Calculation>(context,listen:true).largeTapped? Colors.lightBlue:Colors.white,

                     border:Border.all(color: Colors.lightBlue),
                     borderRadius: BorderRadius.circular(5),
                   ),
                   child:Center(
                     child: Text('L',style: TextStyle(
                       color: Colors.black,
                     ),),
                   )
               ),
             ),
           ],
         )
        ],
      ),
    );
  }
  Widget floatingActionButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      GestureDetector(
        onTap: (){
          Provider.of<Calculation>(context,listen:false).addToCart(context,{
            'image':widget.queryDocumentSnapshot['image'],
            'name':widget.queryDocumentSnapshot['name'],
            'price':widget.queryDocumentSnapshot['price'],
            'onion':Provider.of<Calculation>(context,listen:false).getonionValue,
            'beacon':Provider.of<Calculation>(context,listen:false).getbeaconValue,
            'cheese':Provider.of<Calculation>(context,listen:false).getCheeseValue,
            'size':Provider.of<Calculation>(context,listen:false).getsizeValue,
          });
        },
        child: Container(

          height: 50,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(50)
          ),
          child:Center(
            child: Text('Add to Cart',style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,

            ),),
          ),
        ),
      ),
        Stack(
          children: [

            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  PageTransition(child: MyCartPage(), type: PageTransitionType.bottomToTop)
                );
              },
              child: Container(

                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(50)
                ),
                child:Center(
                  child: Icon(Icons.shopping_cart,color: Colors.black,),
                ),
              ),
            ),
            Positioned(
                left: 30,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10,
                  child: Text('${Provider.of<Calculation>(context,listen: true).getCartData.toString()}'),
                )),
          ],
        )
      ],
    );
  }
}
