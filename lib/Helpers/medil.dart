import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:eva_icons_flutter/icon_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodorderingapp/services/manag_data.dart';
import 'package:foodorderingapp/ui/pages/details.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Meddile extends ChangeNotifier{
Widget textFav(){
  return Padding(
    padding: const EdgeInsets.only(top:8.0,bottom: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Favourite', style: TextStyle(
           shadows: [
             BoxShadow(
               color: Colors.black,
               blurRadius: 1
             )
           ],
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),),
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text(' dishes?', style: TextStyle(
              shadows: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 0
                )
              ],
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),),
        )
      ],
    ),
  );
}
Widget dataFev(BuildContext context,String collocetion){
  return Container(
    height: 300,
    child: FutureBuilder(
      future: Provider.of<ManagData>(context,listen: false).fetchData(collocetion),
      builder:(BuildContext contxet,AsyncSnapshot snapshot){
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
            //Lottie.asset('');
        }
        return ListView.builder(
          //physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
           itemCount:snapshot.data.length,
            itemBuilder:(BuildContext context,int index){
             return GestureDetector(
               onTap: (){
                 Navigator.of(context).push(PageTransition(child:
                 DetailsPage(
                   queryDocumentSnapshot: snapshot.data[index],
                 ), type:PageTransitionType.topToBottom));
               },
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   height: 250,
                   width: 200,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(40),
                     color: Colors.white.withOpacity(0.7),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.lightBlueAccent,
                         blurRadius: 2,
                         spreadRadius: 2,
                       )
                     ]
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [

                       Stack(
                         children: [
                           Center(
                             child: Padding(
                               padding: const EdgeInsets.only(top:14.0),
                               child: CircleAvatar(
                                 backgroundImage: NetworkImage(snapshot.data[index].data()['image']),
                                 radius: 75,
                                 backgroundColor: Colors.transparent,
                               ),
                             ),
                           ),
                           Positioned(
                             left: 145,
                               child: IconButton(
                                 icon: Icon(EvaIcons.heart,color: Colors.redAccent,),
                                 onPressed: (){},
                               )
                           ),
                         ],
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top:8.0,left: 8),
                         child: Text(snapshot.data[index].data()['name'],
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 22,
                           color: Colors.black
                         ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top:4.0,left: 8),
                         child: Text(snapshot.data[index].data()['category'],
                           style: TextStyle(
                               fontWeight: FontWeight.w800,
                               fontSize: 16,
                               color: Colors.cyan
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top:8.0,left: 12,right: 14),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: [
                                 Icon(Icons.star,color: Colors.yellow.shade700,),
                                 Text(snapshot.data[index].data()['ratings'],
                                   style: TextStyle(
                                       fontWeight: FontWeight.w700,
                                       fontSize: 16,
                                       color: Colors.grey
                                   ),
                                 ),
                               ],
                             ),
                             Row(
                               children: [
                                 Icon(FontAwesomeIcons.rubleSign),
                                 Text(snapshot.data[index].data()['price'].toString(),
                                   style: TextStyle(
                                       fontWeight: FontWeight.w700,
                                       fontSize: 16,
                                       color: Colors.black
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         )
                       )
                     ],
                   ),
                 ),
               ) ,
             );
            }
        );
      } ,
    ),
  );
}
Widget textbusiness(){
  return Padding(
    padding: const EdgeInsets.only(top:14.0,bottom: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Business', style: TextStyle(
            shadows: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 1
              )
            ],
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),),
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Text(' lunch', style: TextStyle(
              shadows: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 0
                )
              ],
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),),
        )
      ],
    ),
  );
}
Widget dataBusines(BuildContext context,String collection){
  return Padding(
    padding: const EdgeInsets.only(left:8.0,top: 12,bottom: 12),
    child: Container(
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
      height: 160,
      child:FutureBuilder(
        future: Provider.of<ManagData>(context,listen: false).fetchData(collection),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
            //Lottie.asset('');
          }
          else{
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
                itemBuilder:(context,int index){
                return GestureDetector(
                  onTap: (){},
                  child: Container(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:14,top: 36),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(snapshot.data[index].data()['name'],style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Text(snapshot.data[index].data()['category'],style: TextStyle(
                                  color: Colors.cyan,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Text(snapshot.data[index].data()['notPrice'].toString(),style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.cyan,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Row(
                                  children: [
                                    Icon(FontAwesomeIcons.rubleSign),
                                    Text(snapshot.data[index].data()['price'].toString(),style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.black
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 25,),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top:18),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data[index].data()['image']),
                              radius: 65,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                );
                }
            );
          }
        },

      ),
    ),
  );
}
}