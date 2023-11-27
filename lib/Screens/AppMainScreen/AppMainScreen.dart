import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'AccountFragment.dart';
import 'HistoryFragment.dart';
import 'CartFragment.dart';
import 'HomeFragment.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({Key? key}) : super(key: key);

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

int currentFragmentIndex = 0;
List ScreenFragments = [
  HomeFragment(),
  CartFragment(),
  HistoryFragment(),
  AccountFragment(),
];

class _AppMainScreenState extends State<AppMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text('CarPool',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
      ),

      body: ScreenFragments[currentFragmentIndex],

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
}
