import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodorderingapp/admin/services/delivery_options.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AdmindetailHelper extends ChangeNotifier {
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> makers = <MarkerId, Marker>{};

  initMarker(coll, collId) {
    var varMarkerId = collId;
    final MarkerId markerId = MarkerId(varMarkerId);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(coll['location'].latitude, coll['location'].lonitude),
        infoWindow: InfoWindow(title: 'Order', snippet: coll['address']));
    makers[markerId] = marker;
  }

  showGoogleMaps(BuildContext context, DocumentSnapshot documentSnapshot) {
    return GoogleMap(
      mapType: MapType.hybrid,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      compassEnabled: true,
      initialCameraPosition: CameraPosition(
          target: LatLng(documentSnapshot.data()['location'].latitude,
              documentSnapshot.data()['location'].longitude),
          zoom: 15),
      onMapCreated: (GoogleMapController mapController) {
        googleMapController = mapController;
        notifyListeners();
      },
    );
  }

  Future getMarkerData(String collection) async {
    FirebaseFirestore.instance.collection(collection).get().then((docData) {
      if (docData.docs.isNotEmpty) {
        for (int i = 0; i < docData.docs.length; i++) {
          initMarker(docData.docs[i].data(), docData.docs[i].id);
          print(docData.docs[i].data());
        }
      }
    });
  }

  detailSheet(BuildContext context, DocumentSnapshot documentSnapshot) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.97,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xFF200B4B),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        EvaIcons.person,
                        color: Colors.red,
                      ),
                      Text(
                        documentSnapshot.data()['username'],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 2, bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mapPin,
                        color: Colors.lightBlueAccent,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: Text(
                          documentSnapshot.data()['address'],
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 310,
                  width: double.infinity,
                  child: showGoogleMaps(context, documentSnapshot),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.clock,
                            color: Colors.lightGreenAccent,
                          ),
                          Text(
                            documentSnapshot.data()['time'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.rupeeSign,
                            color: Colors.lightBlueAccent,
                          ),
                          Text(
                            documentSnapshot.data()['price'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(documentSnapshot.data()['image']),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    // maxWidth: 150,
                                    ),
                                child: Text(
                                  'Food :${documentSnapshot.data()['pizza']}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cheese: ${documentSnapshot.data()['cheese']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 4,),
                                  Text(
                                    'Onion: ${documentSnapshot.data()['onion']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 4,),
                                  Text(
                                    'Beacon: ${documentSnapshot.data()['beacon']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(width: 4,),
                                ],
                              )
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text(
                              documentSnapshot.data()['size'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton.icon(
                          color: Colors.redAccent,
                          onPressed: () {
                            Provider.of<DeliveryOptions>(context, listen: false)
                                .manageOrders(context, documentSnapshot,
                                    'cancelledOrders', 'Delivery Skip');
                          },
                          label: Text(
                            'Skip',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          icon: Icon(
                            FontAwesomeIcons.eye,
                            color: Colors.white,
                          ),
                        ),
                        FlatButton.icon(
                          color: Colors.red,
                          onPressed: () {
                            Provider.of<DeliveryOptions>(context, listen: false)
                                .manageOrders(context, documentSnapshot,
                                    'deliveredOrders','Delivery Accept');
                          },
                          label: Text(
                            'Deliver',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          icon: Icon(
                            FontAwesomeIcons.delicious,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton.icon(
                  color: Colors.lightBlueAccent,
                  onPressed: () {},
                  label: Text(
                    'Contact the owner',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.phone,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
