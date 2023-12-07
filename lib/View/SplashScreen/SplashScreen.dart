import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../../resources/colors.dart';
import '../LoginScreen/LoginScreen.dart';
import '../PassengerMainScreen/PassengerMainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigateToMainScreen(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => PassengerMainScreen()
      ),
    );
  }
  void navigateToLoginScreen(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => LoginScreen()
      ),
    );
  }

  void rememberMeLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? rememberMe = prefs.getBool('rememberMe');
    if(rememberMe != null && rememberMe == true){
      navigateToMainScreen();
    }
    else{
      navigateToLoginScreen();
    }
  }

  void removeSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('rememberMe');
  }

  @override
  void initState() {
    // removeSharedPreferences();
    Timer(Duration(seconds: 2), (){
      rememberMeLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/imgs/splash.png',),
          SizedBox(height: 30,),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ],
      )
    );
  }
}
