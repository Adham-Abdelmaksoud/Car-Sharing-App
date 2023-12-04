import 'package:car_sharing_app/Model/UserDatabase.dart';
import 'package:car_sharing_app/View/LoginScreen/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Model/UserAuthentication.dart';
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
  GlobalKey<FormState> signUpKey = GlobalKey();

  UserAuthenticator auth = UserAuthenticator();
  UserDatabase db = UserDatabase();

  void signUp() async{
    String email = emailController.text;
    String password = passwordController.text;
    User? user = await auth.signUpWithEmailAndPassword(email, password);
    if(user != null){
      db.registerUser(
          user!.uid,
          usernameController.text,
          emailController.text,
          passwordController.text
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginScreen()
        ),
      );
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
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 45),
              child: Expanded(
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
                          SizedBox(
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

                          SizedBox(height: 10,),

                          SizedBox(
                            height: 60,
                            child: TextFormField(
                              cursorHeight: 20,
                              controller: emailController,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Email is required';
                                }
                                else if(!RegExp(r"^[a-zA-Z0-9a-zA-Z0-9]+@eng.asu.edu.eg").hasMatch(emailController.text)){
                                  return 'Invalid Email!';
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
                                else if(passwordController.text.length < 6){
                                  return 'Password length must be above 6 characters';
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
                        child: Text('Signup',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white
                          ),
                        )
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
          ),
        ],
      ),
    );
  }
}
