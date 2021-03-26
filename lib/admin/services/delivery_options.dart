import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodorderingapp/admin/services/admin_detail_helper.dart';
import 'package:provider/provider.dart';

class DeliveryOptions extends ChangeNotifier{
   showOrder(BuildContext context,String collection){
    return showModalBottomSheet(
        context: context,
        builder: (context){
      return Padding(
        padding: const EdgeInsets.only(left:8.0,top: 12,bottom: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF200B4B),
            borderRadius: BorderRadius.circular(25),
          ),
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.60,
          child:StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(collection).snapshots(),
            builder: (BuildContext context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
                //Lottie.asset('');
              }
              else{
                return ListView(
                    scrollDirection: Axis.vertical,
                    children:snapshot.data.docs.map((DocumentSnapshot documentSnapshot){
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF200B4B),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ListTile(
                          trailing: IconButton(
                            onPressed:(){
                              showMap(context,documentSnapshot,collection);
                            },
                            icon: Icon(FontAwesomeIcons.mapPin,color: Colors.green,),
                          ),
                          subtitle: Text(documentSnapshot.data()['name'],style: TextStyle(
                            color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                          title: Text(documentSnapshot.data()['address'],style: TextStyle(
                              color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(documentSnapshot.data()['image']),
                          ),
                        ),
                      );
                    }).toList(),
                );
              }
            },

          ),
        ),
      );
        }
    );
  }
   showMessage (BuildContext context,String message){
     return showModalBottomSheet(context: context,
         builder:(context){
       return Container(
         decoration: BoxDecoration(
           color: Color(0xFF200B4B),
           borderRadius: BorderRadius.circular(25),
         ),
         height: 50,
         width: 400,
         child: Center(
           child: Text(message,style: TextStyle(
             color: Colors.white,
             fontSize: 16,
             fontWeight: FontWeight.bold
           ),),
         ),
       );
         });
}
  Future manageOrders(BuildContext context,DocumentSnapshot documentSnapshot,String collection,String message) async{
  await FirebaseFirestore.instance.collection(collection).add({
    'image':documentSnapshot.data()['image'],
    'pizza':documentSnapshot.data()['pizza'],
    'name':documentSnapshot.data()['username'],
    'address':documentSnapshot.data()['address'],
    'location':documentSnapshot.data()['location'],
  }).whenComplete((){
    return showMessage(context,message);
  });
  }
   showMap(BuildContext context,DocumentSnapshot documentSnapshot,String collection){
      Provider.of<AdmindetailHelper>(context,listen: false).getMarkerData(collection).whenComplete((){
        return showModalBottomSheet(
            context: context,
            builder: (context){
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white.withOpacity(.70),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent,
                        blurRadius: 2,
                        spreadRadius: 3,
                      )
                    ]
                ),
                height: MediaQuery.of(context).size.height*0.50,
                child: Column(
                  children: [
                    SizedBox(
                      height:MediaQuery.of(context).size.height*0.50,
                      child: Provider.of<AdmindetailHelper>(context,listen: false).showGoogleMaps(context, documentSnapshot),
                    )
                  ],
                ),
              );
            }
        );
      });
   }
}