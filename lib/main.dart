import 'package:car_sharing_app/resources/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'View/SplashScreen/SplashScreen.dart';
import 'View/SignupScreen/SignupScreen.dart';
import 'View/LoginScreen/LoginScreen.dart';
import 'View/AppMainScreen/AppMainScreen.dart';
import 'View/PaymentScreen/PaymentScreen.dart';
import 'View/TripDetailsScreen/TripDetailsScreen.dart';
import 'View/AvailableRoutesScreen/AvailableRoutesScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: 'CarPool',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: secondaryColor,
        ),
      ),
    )
  );
}