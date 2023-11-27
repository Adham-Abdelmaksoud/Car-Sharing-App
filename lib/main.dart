import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'Screens/SplashScreen/SplashScreen.dart';
import 'Screens/SignupScreen/SignupScreen.dart';
import 'Screens/LoginScreen/LoginScreen.dart';
import 'Screens/AppMainScreen/AppMainScreen.dart';
import 'Screens/PaymentScreen/PaymentScreen.dart';
import 'Screens/TripDetailsScreen/TripDetailsScreen.dart';
import 'Screens/AvailableRoutesScreen/AvailableRoutesScreen.dart';

void main(){
  runApp(
    MaterialApp(
      title: 'CarPool',
      home: AppMainScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: secondaryColor,
        ),
      ),
    )
  );
}