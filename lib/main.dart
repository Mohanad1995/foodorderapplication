import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingapp/Helpers/footer.dart';
import 'package:foodorderingapp/Helpers/medil.dart';
import 'package:foodorderingapp/admin/services/admin_detail_helper.dart';
import 'package:foodorderingapp/admin/services/delivery_options.dart';
import 'package:foodorderingapp/services/generate_map.dart';
import 'package:foodorderingapp/services/authnitication.dart';
import 'package:foodorderingapp/services/calculation.dart';
import 'package:foodorderingapp/services/manag_data.dart';
import 'package:foodorderingapp/services/payment.dart';
import 'package:foodorderingapp/ui/pages/splash_page.dart';
import 'package:provider/provider.dart';

import 'Helpers/header.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value:Header(),
    ),
        ChangeNotifierProvider.value(
          value:Meddile(),
        ),
        ChangeNotifierProvider.value(
          value:ManagData(),
        ),
        ChangeNotifierProvider.value(
          value:Fotter(),
        ),
        ChangeNotifierProvider.value(
          value:GenerateMaps(),
        ),
        ChangeNotifierProvider.value(
          value:CustomAuthintication(),
        ),
        ChangeNotifierProvider.value(
          value:DeliveryOptions(),
        ),

        ChangeNotifierProvider.value(
          value:Calculation(),
        ),
        ChangeNotifierProvider.value(
          value:PaymentHelper(),
        ),
        ChangeNotifierProvider.value(
          value:AdmindetailHelper(),
        ),

      ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
            theme: ThemeData(
              canvasColor: Colors.transparent,
             primaryColor: Colors.redAccent,
             primarySwatch: Colors.red,
             visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
        home: SplashPage(),
      ),
    );
  }
}
