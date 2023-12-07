import 'package:car_sharing_app/Model/UserDatabase.dart';
import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AccountFragment.dart';
import 'HistoryFragment.dart';
import 'CartFragment.dart';
import 'HomeFragment.dart';

class PassengerMainScreen extends StatefulWidget {
  const PassengerMainScreen({Key? key}) : super(key: key);

  @override
  State<PassengerMainScreen> createState() => _PassengerMainScreenState();
}

class _PassengerMainScreenState extends State<PassengerMainScreen> {
  int currentFragmentIndex = 0;
  Map? currentUser;
  List? screenFragments;

  UserDatabase db = UserDatabase();

  Future<List> getCurrentUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    currentUser = await db.getUserInfo(userId!);
    setState(() {
      screenFragments = [
        HomeFragment(),
        CartFragment(),
        HistoryFragment(),
        AccountFragment(currentUser: currentUser!,),
      ];
    });
    return screenFragments!;
  }

  void removeSharedPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('rememberMe');
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrentUser(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: secondaryColor,
              title: Text('CarPool',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
            ),

            body: screenFragments![currentFragmentIndex],

            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: secondaryColor,
              ),
              child: BottomNavigationBar(
                unselectedItemColor: Colors.white54,
                fixedColor: Colors.white,
                showUnselectedLabels: true,
                currentIndex: currentFragmentIndex,
                onTap: (index){
                  setState(() {
                    currentFragmentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.card_travel),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: 'History',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Account',
                  ),
                ],
              ),
            ),
          );
        }
        else if(snapshot.hasError){
          removeSharedPreferences();
          return Center(child: Text('Some Error Occurred'));
        }
        else{
          return Scaffold(
            backgroundColor: primaryColor,
            body: Center(
              child: SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
                ),
              )
            )
          );
        }
      },
    );
  }
}
