import 'package:car_sharing_app/View/RouteAdderScreen/FromUniversityFragment.dart';
import 'package:car_sharing_app/View/RouteAdderScreen/ToUniversityFragment.dart';
import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';

class RoutesAdderScreen extends StatefulWidget {
  const RoutesAdderScreen({Key? key}) : super(key: key);

  @override
  State<RoutesAdderScreen> createState() => _RoutesAdderScreenState();
}


class _RoutesAdderScreenState extends State<RoutesAdderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primaryColor,

        appBar: AppBar(
          centerTitle: true,
          backgroundColor: secondaryColor,
          iconTheme: IconThemeData(
            color: Colors.white
          ),
          title: Text('Add a new Route',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_filled,
                  color: Colors.white,
                ),
                child: Text('From University',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
              Tab(
                icon: Icon(Icons.school,
                  color: Colors.white,
                ),
                child: Text('To University',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 35, left: 40, right: 40),
                    child: FromUniversityFragment()
                  ),
                ),
              ],
            ),

            CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 35, left: 40, right: 40),
                      child: ToUniversityFragment()
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
