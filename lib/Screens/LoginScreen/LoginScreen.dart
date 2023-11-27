import 'package:car_sharing_app/Screens/AppMainScreen/AppMainScreen.dart';
import 'package:car_sharing_app/Screens/LoginScreen/LoginController.dart';
import 'package:car_sharing_app/Screens/SignupScreen/SignupScreen.dart';
import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 55),
              child: Expanded(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: "Email",
                              ),
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ),

                          SizedBox(height: 15,),

                          SizedBox(
                            height: 60,
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                labelText: "Password",
                              ),
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: (){},
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
                      ),
                      onPressed: (){
                        if(validateLogin(emailController.text, passwordController.text)){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AppMainScreen()
                            )
                          );
                        }
                      },
                      child: Text('Login',
                        style: TextStyle(
                          fontSize: 17
                        ),
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()
                              )
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
          ),
        ],
      ),
    );
  }
}
