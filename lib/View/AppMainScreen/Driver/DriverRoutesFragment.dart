import 'package:car_sharing_app/View/RouteAdderScreen/RouteAdderScreen.dart';
import 'package:car_sharing_app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/UserDatabase.dart';
import 'RoutesListItem.dart';

class DriverRoutesFragment extends StatefulWidget {
  const DriverRoutesFragment({Key? key}) : super(key: key);

  @override
  State<DriverRoutesFragment> createState() => _DriverRoutesFragmentState();
}

class _DriverRoutesFragmentState extends State<DriverRoutesFragment> {
  UserDatabase userDB = UserDatabase();

  Future<List> getRoutesList() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    List routes = await userDB.getDriverRoutes(userId!);
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RoutesAdderScreen()
            ),
          );
        },
        backgroundColor: secondaryColor,
        shape: CircleBorder(),
        child: Icon(Icons.add,
          color: Colors.white,
          size: 33,
        ),
      ),
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: getRoutesList(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return Card(
                        color: primaryColor,
                        child: RoutesListItem(
                          route: snapshot.data![index],
                        )
                    );
                  }
              );
            }
            else if(snapshot.hasError){
              return Center(child: Text('Some Error Occurred!'));
            }
            else{
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              );
            }
          },
        )
      ),
    );
  }
}
