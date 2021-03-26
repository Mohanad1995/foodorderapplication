import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodorderingapp/admin/services/admin_detail_helper.dart';
import 'package:foodorderingapp/admin/services/delivery_options.dart';
import 'package:foodorderingapp/admin/views/login_page_admin.dart';
import 'package:foodorderingapp/ui/pages/desider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(context),
      drawer: Drawer(),
      body: RefreshIndicator(
        onRefresh: () async{
          print('Working');
        },
        child: Stack(
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
                        Color(0xFF200B4B),
                        Color(0xFF201F22),
                        Color(0xFF1A1031),
                        Color(0xFF19181F),
                      ])),

            ),
            customAppBar(context),
            dataChips(context),
            cartData(context),
          ],
        ),
      ),
    );
  }
  Widget customAppBar(BuildContext context){
    return  AppBar(
      backgroundColor:Color(0xFF1A1031),
      centerTitle: true,
      title: Text('Odrers',style: TextStyle(
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
    );
  }
  Widget dataChips(BuildContext context){
    return Transform.translate(
      offset: Offset(0,120),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionChip(
              backgroundColor: Colors.purple,
              label: Text('Today',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),),
              onPressed: (){},
            ),
            ActionChip(
              backgroundColor: Colors.purple,
              label: Text('This Week',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),),
              onPressed: (){},
            ),
            ActionChip(
              backgroundColor: Colors.purple,
              label: Text('This Month',style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
  Widget cartData(BuildContext context) {
    return Positioned(
      top: 150,
      child: SizedBox(
        height: 600,
        width: 400,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('adminCollection').snapshots(),
          builder: (context,snapShot){
            if(snapShot.connectionState==ConnectionState.waiting){
              return Center(child:CircularProgressIndicator(),);
            }
            return ListView(
              children:snapShot.data.docs.map((DocumentSnapshot documentSnapshot){
                return Padding(
                  padding: const EdgeInsets.only(top:12.0,left: 6,right: 28),
                  child: Container(
                    color: Colors.deepPurple,
                    child: ListTile(
                      onTap: (){
                        Provider.of<AdmindetailHelper>(context,listen: false).detailSheet(context, documentSnapshot);
                      },
                      trailing: IconButton(
                        icon: Icon(FontAwesomeIcons.magnet,color: Colors.white,),
                        onPressed: (){},
                      ),
                      subtitle:Text(documentSnapshot.data()['address'],style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),),
                      title: Text(documentSnapshot.data()['pizza'],style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      leading:CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(documentSnapshot.data()['image']),
                      ) ,
                    ),
                  ),
                );
                //   Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: GestureDetector(
                //     onLongPress: (){
                //       //onPlaceholder(context,documentSnapshot);
                //     },
                //     child: Container(
                //       decoration: BoxDecoration(
                //         boxShadow: [
                //           BoxShadow(
                //               color: Colors.lightBlueAccent, blurRadius: 2, spreadRadius: 3),
                //         ],
                //         color: Colors.white.withOpacity(0.70),
                //         borderRadius: BorderRadius.circular(40),
                //       ),
                //       height: 180,
                //       width: 400,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //         children: [
                //           SizedBox(
                //             height: 45,
                //             width: 45,
                //             child: Image.network(documentSnapshot.data()['image']),
                //           ),
                //           Column(
                //             children: [
                //
                //               Text(documentSnapshot.data()['name'],style: TextStyle(
                //                 color: Colors.black87,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 18,
                //               ),),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Text('Onion : ',style: TextStyle(
                //                     color: Colors.black87,
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 18,
                //                   ),),
                //                   Text(documentSnapshot.data()['onion'].toString(),style: TextStyle(
                //                     color: Colors.black87,
                //                     fontWeight: FontWeight.w600,
                //                     fontSize: 18,
                //                   ),),
                //
                //                 ],
                //               ),
                //               Row(
                //                 children: [
                //                   Text('Beacon',style: TextStyle(
                //                     color: Colors.black87,
                //                     fontWeight: FontWeight.bold,
                //                     fontSize: 18,
                //                   ),),
                //                   Text(documentSnapshot.data()['beacon'].toString(),style: TextStyle(
                //                     color: Colors.black87,
                //                     fontWeight: FontWeight.w600,
                //                     fontSize: 18,
                //                   ),),
                //
                //                 ],
                //               ),
                //               Text(documentSnapshot.data()['cheese'].toString(),style: TextStyle(
                //                 color: Colors.black87,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 24,
                //               ),),
                //               Text(documentSnapshot.data()['price'].toString(),style: TextStyle(
                //                 color: Colors.black87,
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 24,
                //               ),),
                //               CircleAvatar(
                //                 child: Text('${documentSnapshot.data()['size']}'),
                //               )
                //             ],
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
  Widget floatingActionButton(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
    FloatingActionButton(
    child: Icon(Icons.cancel_outlined,color: Colors.white,),
    onPressed: (){
      Provider.of<DeliveryOptions>(context,listen: false).showOrder(context, 'cancelledOrders');
    },
    backgroundColor: Colors.redAccent,
    ),
    FloatingActionButton(
    child: Icon(FontAwesomeIcons.check,color: Colors.white,),
    onPressed: (){
      Provider.of<DeliveryOptions>(context,listen: false).showOrder(context, 'deliveredOrders');

    },
    backgroundColor: Colors.greenAccent,
    ),
      ],
    );
  }
}
