import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingapp/services/authnitication.dart';
import 'package:foodorderingapp/ui/pages/splash_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ManagData extends ChangeNotifier {

  FirebaseFirestore firebaseFirestore =
      FirebaseFirestore.instance;
      Future fetchData(String collocetion) async{
    QuerySnapshot querySnapshot =
    await firebaseFirestore.collection(collocetion).get();
    return querySnapshot.docs;
  }
  Future submitData(BuildContext context,dynamic data) async{
    return FirebaseFirestore.instance.collection('myOrder')
        .doc(Provider.of<CustomAuthintication>(context,listen: false).getUserUid).set(data);
  }
  Future deleteData(BuildContext context){
    return FirebaseFirestore.instance.collection('myOrder').doc(
        Provider.of<CustomAuthintication>(context,listen: false).getUserUid == null
            ? uid:
        Provider.of<CustomAuthintication>(context,listen: false).getUserUid).delete();

  }
}