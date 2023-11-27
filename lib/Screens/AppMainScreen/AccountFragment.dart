import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: Text('Adham Abdelmaksoud',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Account Details:',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(height: 30,),

                      Row(
                        children: [
                          Text('Email: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('1234@eng.asu.edu.eg',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                      Row(
                        children: [
                          Text('Password: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('abcd1234',
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
                          Text('01012345678',
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

                      SizedBox(height: 20,),

                      Row(
                        children: [
                          Text('Language: ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('English',
                            style: TextStyle(
                                fontSize: 20
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
      ),
    );
  }
}
