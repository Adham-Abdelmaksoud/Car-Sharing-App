import 'package:car_sharing_app/Screens/LoginScreen/LoginScreen.dart';
import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 55),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Username",
                              ),
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ),

                          SizedBox(height: 10,),

                          SizedBox(
                            height: 60,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email",
                              ),
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ),

                          SizedBox(height: 10,),

                          SizedBox(
                            height: 60,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Password",
                              ),
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ),

                          SizedBox(height: 10,),

                          SizedBox(
                            height: 60,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Confirm Password",
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

                    SizedBox(height: 15,),

                    ElevatedButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(1000))),
                          fixedSize: Size(1000, 42),
                        ),
                        onPressed: (){},
                        child: Text('Signup',
                          style: TextStyle(
                              fontSize: 17
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
