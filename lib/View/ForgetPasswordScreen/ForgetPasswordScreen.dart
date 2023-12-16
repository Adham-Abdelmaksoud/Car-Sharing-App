import 'package:car_sharing_app/Model/Remote/UserAuthentication.dart';
import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  UserAuthenticator userAuth = UserAuthenticator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 50, left: 40, right: 40),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),

                    Text('Forget Password',
                        style: TextStyle(
                            fontSize: 31,
                            fontWeight: FontWeight.bold
                        )
                    ),

                    SizedBox(height: 26,),

                    TextFormField(
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

                    SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async{
                            if(formKey.currentState!.validate()){
                              userAuth.forgetPassword(emailController.text);
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text('Send reset password email',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                              ),
                            ),
                          )
                        ),
                      ],
                    )
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
