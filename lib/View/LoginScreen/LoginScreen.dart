import 'dart:io';

import 'package:car_sharing_app/Model/Remote/UserDatabase.dart';
import 'package:car_sharing_app/View/ForgetPasswordScreen/ForgetPasswordScreen.dart';
import 'package:car_sharing_app/View/SignupScreen/SignupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/Remote/UserAuthentication.dart';
import '../../resources/colors.dart';
import '../../resources/widgets.dart';
import '../AppMainScreen/Common/AppMainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey();

  List userRoles = [
    'Passenger',
    'Driver'
  ];
  String roleValue = 'Passenger';
  bool rememberMe = false;
  bool loading = false;
  bool failedLogin = false;
  String loginErrorMessage = '';

  UserAuthenticator userAuth = UserAuthenticator();
  UserDatabase userDB = UserDatabase();

  void navigateToMainScreen(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AppMainScreen()),
    );
  }

  Future<String> checkRole(String userId) async{
    Map userInfo = await userDB.getUserInfo(userId);
    return userInfo['Role'];
  }

  void signIn(SharedPreferences prefs, String userId){
    navigateToMainScreen();
    prefs.setString('userId', userId);
    if(rememberMe){
      prefs.setBool('rememberMe', true);
    }
  }

  void handleSignIn() async{
    String email = emailController.text;
    String password = passwordController.text;
    setState(() {
      loading = true;
    });
    User? user = await userAuth.signInWithEmailAndPassword(email, password);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(user != null){
      String userRole = await checkRole(user!.uid);
      if(userRole == roleValue){
        signIn(prefs, user!.uid);
      }
      else{
        setState(() {
          failedLogin = true;
          loading = false;
          loginErrorMessage = 'This account is registered as $userRole not $roleValue';
        });
      }
    }
    else{
      int roleCode = authenticateTestCredentials(email, password);
      if(roleCode == 1){
        String userRole = await checkRole('TestPassenger');
        if(userRole == roleValue){
          signIn(prefs, 'TestPassenger');
        }
        else{
          setState(() {
            failedLogin = true;
            loading = false;
            loginErrorMessage = 'This account is registered as $userRole not $roleValue';
          });
        }
      }
      else if(roleCode == -1){
        String userRole = await checkRole('TestDriver');
        if(userRole == roleValue){
          signIn(prefs, 'TestDriver');
        }
        else{
          setState(() {
            failedLogin = true;
            loading = false;
            loginErrorMessage = 'This account is registered as $userRole not $roleValue';
          });
        }
      }
      else{
        try {
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            setState(() {
              failedLogin = true;
              loading = false;
              loginErrorMessage = 'Incorrect Email or Password';
            });
          }
        } on SocketException catch (_) {
          setState(() {
            failedLogin = true;
            loading = false;
            loginErrorMessage = 'Unable to connect to internet';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    minRadius: 75,
                    maxRadius: 75,
                    backgroundImage: AssetImage('assets/imgs/user.png',),
                    backgroundColor: bluishWhite,
                  ),
                  Text('Login',
                    style: TextStyle(
                      fontSize: 39,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 10,),

                  Form(
                    key: loginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text('Login as:',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            SizedBox(width: 14,),

                            Expanded(
                              child: DropdownButtonFormField(
                                dropdownColor: primaryColor,
                                value: roleValue,
                                items: userRoles.map((value){
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value,
                                      style: TextStyle(
                                        fontSize: 17
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value){
                                  setState(() {
                                    roleValue = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 28,),

                        LoginSignupTextField(
                          hintText: "Email",
                          controller: emailController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Email is required!';
                            }
                            else{
                              return null;
                            }
                          },
                        ),

                        SizedBox(height: 15,),

                        LoginSignupTextField(
                          hintText: "Password",
                          obscureText: true,
                          controller: passwordController,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Password is required!';
                            }
                            else{
                              return null;
                            }
                          },
                        )
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: SizedBox(
                              height: 22,
                              width: 22,
                              child: Checkbox(
                                value: rememberMe,
                                activeColor: secondaryColor,
                                onChanged: (value){
                                  setState(() {
                                    rememberMe = !rememberMe;
                                  });
                                },
                              ),
                            ),
                          ),
                          Text('Remember me',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54
                            )
                          ),
                        ],
                      ),

                      TextButton(
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ForgetPasswordScreen())
                            );
                          },
                          child: Text('Forget Password?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ],
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(1000))),
                      fixedSize: Size(1000, 42),
                      backgroundColor: secondaryColor
                    ),
                    onPressed: (){
                      if(loginKey.currentState!.validate()){
                        handleSignIn();
                      }
                    },
                    child: loading? SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ) : Text('Login',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white
                      ),
                    ),
                  ),

                  SizedBox(height: 5,),

                  Text(loginErrorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: errorColor,
                      fontSize: failedLogin? 14: 0
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account yet?",
                        style: TextStyle(
                            fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignupScreen())
                          );
                        },
                        child: Text('Signup',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
