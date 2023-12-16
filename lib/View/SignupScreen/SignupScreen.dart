import 'dart:io';

import 'package:car_sharing_app/Model/Local/UserCacheDatabase.dart';
import 'package:car_sharing_app/View/LoginScreen/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Model/Remote/UserAuthentication.dart';
import '../../Model/Remote/UserDatabase.dart';
import '../../resources/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey();

  UserAuthenticator userAuth = UserAuthenticator();
  UserDatabase userDB = UserDatabase();
  UserCacheDatabase userCache = UserCacheDatabase();

  List userRoles = [
    'Passenger',
    'Driver'
  ];
  String roleValue = 'Passenger';
  bool loading = false;
  bool failedSignUp = false;
  String signUpErrorMessage = '';

  void signUp() async{
    String email = emailController.text;
    String password = passwordController.text;
    setState(() {
      loading = true;
    });
    User? user = await userAuth.signUpWithEmailAndPassword(email, password);
    if(user != null){
      userDB.registerUser(
          user!.uid,
          usernameController.text,
          emailController.text,
          phoneNumberController.text,
          roleValue
      );
      userCache.addUser(
          user!.uid,
          usernameController.text,
          emailController.text,
          phoneNumberController.text,
          roleValue
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen()
        ),
      );
    }
    else{
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() {
            loading = false;
            failedSignUp = true;
            signUpErrorMessage = 'This Email is already used by another account!';
          });
        }
      } on SocketException catch (_) {
        setState(() {
          loading = false;
          failedSignUp = true;
          signUpErrorMessage = 'Unable to connect to internet';
        });
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
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    minRadius: 70,
                    maxRadius: 70,
                    backgroundImage: AssetImage('assets/imgs/user.png',),
                    backgroundColor: bluishWhite,
                  ),
                  Text('Signup',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 10,),

                  Form(
                    key: signUpKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 60,
                                child: TextFormField(
                                  cursorHeight: 20,
                                  controller: usernameController,
                                  validator: (value){
                                    if(value == null || value.isEmpty){
                                      return 'Username is required';
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.normal
                                    )
                                  ),
                                  style: TextStyle(
                                    fontSize: 18,
                                    height: 1
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 10,),

                            DropdownButton(
                              dropdownColor: primaryColor,
                              value: roleValue,
                              items: userRoles.map((value){
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value,
                                    style: TextStyle(
                                      fontSize: 15
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value){
                                setState(() {
                                  roleValue = value.toString();
                                });
                              },
                            )
                          ],
                        ),

                        SizedBox(height: 10,),

                        SizedBox(
                          height: 60,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorHeight: 20,
                            controller: phoneNumberController,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Phone Number is required!';
                              }
                              else if(phoneNumberController.text.length != 11){
                                return 'Invalid Phone Number!';
                              }
                              else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Phone Number",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.normal
                                )
                            ),
                            style: TextStyle(
                                fontSize: 18,
                                height: 1
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        SizedBox(
                          height: 60,
                          child: TextFormField(
                            cursorHeight: 20,
                            controller: emailController,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Email is required!';
                              }
                              else if(!RegExp(r"^[a-zA-Z0-9a-zA-Z0-9]+@eng.asu.edu.eg").hasMatch(emailController.text)){
                                return 'Email should have the domain eng.asu.edu.eg!';
                              }
                              else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal
                              )
                            ),
                            style: TextStyle(
                              fontSize: 18,
                              height: 1
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        SizedBox(
                          height: 60,
                          child: TextFormField(
                            cursorHeight: 20,
                            controller: passwordController,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Password is required!';
                              }
                              else if(passwordController.text.length < 5){
                                return 'Password length must be above 5 characters';
                              }
                              else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal
                              )
                            ),
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        SizedBox(
                          height: 60,
                          child: TextFormField(
                            cursorHeight: 20,
                            controller: confirmPasswordController,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'Confirm Password is required!';
                              }
                              else if(confirmPasswordController.text != passwordController.text){
                                return 'Passwords are not matching!';
                              }
                              else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal
                              )
                            ),
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 18,
                              height: 1
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15,),

                  ElevatedButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(1000))),
                        fixedSize: Size(1000, 42),
                        backgroundColor: secondaryColor
                      ),
                      onPressed: () async{
                        if(signUpKey.currentState!.validate()){
                          signUp();
                        }
                      },
                      child: loading? SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ) : Text('Signup',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white
                        ),
                      )
                  ),

                  SizedBox(height: 10,),

                  Text(signUpErrorMessage,
                    style: TextStyle(
                        color: errorColor,
                        fontSize: failedSignUp? 14: 0
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                        style: TextStyle(
                            fontSize: 16
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen()
                            )
                          );
                        },
                        child: Text('Login',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      )
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
