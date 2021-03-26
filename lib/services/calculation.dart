import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingapp/services/manag_data.dart';
import 'package:provider/provider.dart';

class Calculation with ChangeNotifier{
int cheeseValue =0,
    beaconValue =0,
    onionValue =0,
    cartData =0;
String size;
String get getsizeValue =>size;
bool isSelected =false,
    smallTapped =false,
    mediumTapped =false,
    largeTapped =false,
    selected =false;
int get getCheeseValue =>cheeseValue;
int get getbeaconValue =>beaconValue;
int get getonionValue =>onionValue;
int get getCartData =>cartData;
bool get getselected =>selected;
addCheese(){
  cheeseValue++;
  notifyListeners();
}

addbeacon(){
  beaconValue++;
  notifyListeners();
}
addonion(){
  onionValue++;
  notifyListeners();
}
minusCheese(){
  cheeseValue--;
  notifyListeners();
}

minusbeacon(){
  beaconValue--;
  notifyListeners();
}
minusonion(){
  onionValue--;
  notifyListeners();
}
selectsmallsize(){
  smallTapped=true;
  largeTapped=false;
  mediumTapped=false;
  size='S';
  notifyListeners();
}
selectmediumsize(){
  mediumTapped=true;
  smallTapped=false;
  largeTapped=false;
  size='M';
  notifyListeners();
}
selectlargesize(){
  smallTapped=false;
  mediumTapped=false;
  largeTapped=true;
  size='L';
  notifyListeners();
}
removeAllData(){
  cheeseValue =0;
  beaconValue =0;
  onionValue =0;
  smallTapped =false;
  mediumTapped =false;
  largeTapped =false;
  notifyListeners();
}
addToCart(BuildContext context ,dynamic data)async{
  if(smallTapped !=false || mediumTapped !=false || largeTapped !=false){
    cartData++;
    await Provider.of<ManagData>(context,listen: false).submitData(context, data);
    notifyListeners();
  }
  else{
    return showModalBottomSheet(context: context, builder: (context){
      return Container(
          height: 50,
          child:Center(
            child:Text('Select Size plaez'),
          )
      );
    });
  }

  }
}
