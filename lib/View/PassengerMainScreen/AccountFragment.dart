import 'package:car_sharing_app/Model/UserDatabase.dart';
import 'package:car_sharing_app/View/LoginScreen/LoginScreen.dart';
import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/UserAuthentication.dart';

class AccountFragment extends StatefulWidget {
  final Map currentUser;
  const AccountFragment({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  UserAuthenticator auth = UserAuthenticator();
  UserDatabase db = UserDatabase();

  void logout() async{
    auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('rememberMe');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => LoginScreen()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/imgs/user.png',),
                              backgroundColor: Colors.white,
                              minRadius: 70,
                              maxRadius: 70,
                            ),
                          ),

                          SizedBox(height: 15,),

                          Center(
                            child: Text(widget.currentUser['Username'],
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 5,),

                  Expanded(
                    child: Card(
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Account Details:',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                  SizedBox(height: 30,),

                                  Wrap(
                                    children: [
                                      Text('Email: ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(widget.currentUser!['Email'],
                                        style: TextStyle(
                                          fontSize: 20
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20,),

                                  Row(
                                    children: [
                                      Text('Role: ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(widget.currentUser!['Role'],
                                        style: TextStyle(
                                          fontSize: 20
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20,),

                                  Row(
                                    children: [
                                      Text('Phone Number: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text(widget.currentUser!['Phonenumber'],
                                        style: TextStyle(
                                            fontSize: 20
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20,),

                                  Row(
                                    children: [
                                      Text('City: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text('Cairo',
                                        style: TextStyle(
                                            fontSize: 20
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 35,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: (){
                                    logout();
                                  },
                                  child: Text('Logout',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(1000))),
                                    fixedSize: Size(130, 45),
                                    backgroundColor: secondaryColor
                                  )
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
            ),
          ),
        ),
      ],
    );
  }
}
