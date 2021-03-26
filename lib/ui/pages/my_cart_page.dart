import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodorderingapp/services/authnitication.dart';
import 'package:foodorderingapp/services/calculation.dart';
import 'package:foodorderingapp/services/generate_map.dart';
import 'package:foodorderingapp/services/generate_map.dart';
import 'package:foodorderingapp/services/manag_data.dart';
import 'package:foodorderingapp/services/payment.dart';
import 'package:foodorderingapp/ui/pages/home_page.dart';
import 'package:foodorderingapp/ui/pages/map_page.dart';
import 'package:foodorderingapp/ui/pages/splash_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  int price=400;
  int total=420;
  Razorpay razorpay;
  @override
  void initState() {
    razorpay=Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,Provider.of<PaymentHelper>(context,listen: false).handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,Provider.of<PaymentHelper>(context,listen: false).handlePaymentError);

    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,Provider.of<PaymentHelper>(context,listen: false).handleExternalWaller);

    // TODO: implement initState
    super.initState();
  }
  Future checkMeout() async{
    var options={
      'key':'rzp_test_sPKoA4SCTcUT7C',
      'amount':total,
      'name':Provider.of<CustomAuthintication>(context,listen: false).getUserEmail,
     'description':'Payment',
      'prdfill':{
        'contact':'88888888888',
        'email':Provider.of<CustomAuthintication>(context,listen: false).getUserEmail,
      },
      'external':{
        'wallet':['paytm']
      },
    };
    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }
  @override
  void dispose() {
    razorpay.clear();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: floatingActionButton(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBar(),
            headerText(),
            SizedBox(height: 12,),
            cartData(),
            //SizedBox(height: 60,),
            // ShippingDetaials(context),
            // billingData(),

          ],
        ),
      ),
    );
  }

  Widget customAppBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 28,bottom: 12,left: 12,right: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacement(PageTransition(
                    child: HomePage(),
                    type: PageTransitionType.rightToLeftWithFade));
              }),
          IconButton(
              icon: Icon(FontAwesomeIcons.trash),
              color: Colors.red,
              onPressed: () async{
                Provider.of<ManagData>(context,listen: false).deleteData(context);
                Provider.of<Calculation>(context,listen: false).cartData = 0;
              }),
        ],
      ),
    );
  }

  Widget cartData() {
    return SizedBox(
      height: 240,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('myOrder').snapshots(),
        builder: (context,snapShot){
          if(snapShot.connectionState==ConnectionState.waiting){
            return Center(child:CircularProgressIndicator(),);
          }
          return ListView(
            children:snapShot.data.docs.map((DocumentSnapshot documentSnapshot){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onLongPress: (){
                    onPlaceholder(context,documentSnapshot);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.lightBlueAccent, blurRadius: 2, spreadRadius: 3),
                      ],
                      color: Colors.white.withOpacity(0.70),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    height: 180,
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(documentSnapshot.data()['image']),
                          radius: 85,
                          backgroundColor: Colors.transparent,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:12.0,right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(documentSnapshot.data()['name'],style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Onion : ',style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),),
                                  Text(documentSnapshot.data()['onion'].toString(),style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),),

                                ],
                              ),
                              Row(
                                children: [
                                  Text('Beacon : ',style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),),
                                  Text(documentSnapshot.data()['beacon'].toString(),style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),),

                                ],
                              ),
                              Row(
                                children: [
                                  Text('Cheese : ',style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),),
                                  Text(documentSnapshot.data()['cheese'].toString(),style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Price : ',style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),),
                                  Text(documentSnapshot.data()['price'].toString(),style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),),
                                ],
                              ),
                             Padding(
                               padding: const EdgeInsets.only(left: 32),
                               child: CircleAvatar(
                                 child: Text('${documentSnapshot.data()['size']}'),
                               ),
                             )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget headerText() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        children: [
          Text(
            'YOUR',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            'CART',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }

  Widget ShippingDetaials(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 4, top: 8),
      child: Container(
        height: 100,
        width: 400,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500, blurRadius: 2, spreadRadius: 3),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(FontAwesomeIcons.locationArrow),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 200,
                      ),
                      child: Text(Provider.of<GenerateMaps>(context,listen: false).getMainAddress,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(icon: Icon(Icons.edit), onPressed: () {
                      Navigator.of(context).pushReplacement(PageTransition(child: MapPage(),type: PageTransitionType.bottomToTop,));
                    })
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(EvaIcons.clock),
                    Container(
                      child: Text(
                        '6PM - 8PM',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(icon: Icon(Icons.edit), onPressed: () {})
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget billingData() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500, blurRadius: 2, spreadRadius: 3),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.rupeeSign,
                      color: Colors.grey,
                      size: 16,
                    ),
                    Text(
                      '300.00',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Delivery Charges',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.rupeeSign,
                      color: Colors.grey,
                      size: 16,
                    ),
                    Text(
                      '30.00',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.rupeeSign,
                      color: Colors.black,
                      size: 18,
                    ),
                    Text(
                      '330.00',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onPlaceholder(BuildContext context,DocumentSnapshot documentSnapshot) {
  return showModalBottomSheet(
      context: context,
      // isScrollControlled: true,
      builder: (context) {
        return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.40,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
           color: Color(0xFF191531),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 150),
                     child: Divider(
                     thickness: 4,
                 color: Colors.white,
                        ),),
                Padding(
                  padding: const EdgeInsets.only(left: 12,top: 16),
                  child: Container(
                    height: 30,
                    child: Text('Time : ${Provider.of<PaymentHelper>(context,listen: true).deiveryTime.format(context)}',
                    style:TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Container(
                    height: 80,
                    child: Text('Location : ${Provider.of<GenerateMaps>(context,listen: true).getMainAddress} ',
                      style:TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.redAccent,
        onPressed:(){
            Provider.of<PaymentHelper>(context,listen: false).selectTime(context);
        },
        child :Icon(FontAwesomeIcons.clock,color: Colors.white,),

        ),
                    FloatingActionButton(
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed:(){
                        Provider.of<PaymentHelper>(context,listen: false).selectedLocation(context);

                      },
                      child :Icon(FontAwesomeIcons.mapPin,color: Colors.white,),

                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.lightGreenAccent,
                      onPressed:() async{
                        await checkMeout().whenComplete((){
                          Provider.of<PaymentHelper>(context,listen: false).showCheckButtonMethod();

                        });
                      },
                      child :Icon(FontAwesomeIcons.paypal,color: Colors.white,),

                    ),

                  ],
                ),
        Provider.of<PaymentHelper>(context,listen: false).showCheckButton?
        Padding(
          padding: const EdgeInsets.only(top:22.0),
          child: Center(
            child: MaterialButton(
                   onPressed: () async{
                   await FirebaseFirestore.instance.collection('adminCollection').add({
                     'location':Provider.of<GenerateMaps>(context,listen: false).geoPoint,
                     'username':Provider.of<CustomAuthintication>(context,listen: false).getUserEmail == null?emailUser:Provider.of<CustomAuthintication>(context,listen: false).getUserEmail,
                     'image':documentSnapshot.data()['image'],
                     'pizza':documentSnapshot.data()['name'],
                     'price':documentSnapshot.data()['price'],
                     'time':Provider.of<PaymentHelper>(context,listen: false).deiveryTime.format(context),
                     'address':Provider.of<GenerateMaps>(context,listen: false).getMainAddress,
                     'size':documentSnapshot.data()['size'],
                     'onion':documentSnapshot.data()['onion'],
                     'cheese':documentSnapshot.data()['cheese'],
                     'beacon':documentSnapshot.data()['beacon'],
                   });
                   Navigator.pushReplacement(context,
                       PageTransition(
                         child: HomePage(),
                         type: PageTransitionType.leftToRightWithFade,
                       )
                   );
                     },
  child: Center(
    child: Text(
          'PLACE ORDER',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    ),
  ),
),
          ),
        ):Container(),
        ]
        ),
        );
      }
  );
  }
}
