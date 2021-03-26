import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingapp/services/generate_map.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHelper extends ChangeNotifier{
  TimeOfDay deiveryTime=TimeOfDay.now();
  bool showCheckButton=false;
  bool get getShowCheckButton=>showCheckButton;
  Future selectTime(BuildContext context) async{
    final selectedTime=
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if(selectedTime !=null && selectedTime !=deiveryTime){
      deiveryTime=selectedTime;
      print(deiveryTime.format(context));
      notifyListeners();
    }
  }
  showCheckButtonMethod(){
showCheckButton=true;
notifyListeners();
  }
  selectedLocation(BuildContext context){
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context){
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height*0.80,
        decoration: BoxDecoration(
          color: Color(0xFF191531),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150),
              child: Divider(
                thickness: 4,
                color: Colors.white,
              ),),
            Container(
              height: 50,
              child: Text('Location: ${Provider.of<GenerateMaps>(context,listen: true).getMainAddress}',style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*0.65,
            child: Provider.of<GenerateMaps>(context,listen: false).featchMaps(),
          )
          ],
        ),
      );
        });
  }
  handlePaymentSuccess(BuildContext context,PaymentSuccessResponse paymentSuccessResponse){
    return showResponse(context,paymentSuccessResponse.paymentId);
  }
  handlePaymentError(BuildContext context,PaymentFailureResponse paymentFailureResponse){
    return showResponse(context,paymentFailureResponse.message);
  }
  handleExternalWaller(BuildContext context,ExternalWalletResponse externalWalletResponse){
    return showResponse(context,externalWalletResponse.walletName);
  }
  showResponse(BuildContext context,String reponse){
    return showModalBottomSheet(context: context,
        builder: (context){
      return Container(
        height: 100,
        width: 400,
        child: Text('The reponse is $reponse',style: TextStyle(

        ),),
      );
        });
  }
}