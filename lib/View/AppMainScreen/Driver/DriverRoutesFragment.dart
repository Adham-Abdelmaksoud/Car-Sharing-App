import 'package:car_sharing_app/View/RouteAdderScreen/RouteAdderScreen.dart';
import 'package:car_sharing_app/resources/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../Model/Remote/UserDatabase.dart';
import '../../../resources/TimeHelper.dart';
import 'RoutesListItem.dart';

class DriverRoutesFragment extends StatefulWidget {
  final driverId;
  const DriverRoutesFragment({Key? key, this.driverId}) : super(key: key);

  @override
  State<DriverRoutesFragment> createState() => _DriverRoutesFragmentState();
}

class _DriverRoutesFragmentState extends State<DriverRoutesFragment> {
  UserDatabase userDB = UserDatabase();

  bool dataExists = true;

  void copyRoutesToPassenger() async{
    List routes = await userDB.getDriverRoutes(widget.driverId);
    for(int i=0 ; i<routes.length ; i++){
      FirebaseDatabase.instance.ref().child('Routes').child(routes[i]['Key']).set(routes[i]);
    }
  }

  List getRoutesList(DatabaseEvent streamSnapshotData){
    DataSnapshot databaseSnapshot = streamSnapshotData.snapshot;
    if(!databaseSnapshot.exists){
      return [];
    }
    Map routesMap = streamSnapshotData.snapshot.value as Map;
    List routesList = routesMap.values.toList();
    return routesList;
  }

  void checkIfDataExists() async{
    DataSnapshot snapshot = await userDB.getDriverRoutesDatabaseReference(widget.driverId).get();
    dataExists = snapshot.exists;
  }

  bool checkIfStarted(Map route){
    String referenceDate = route['Date'];
    String referenceTime = route['Time'];
    if(compareWithCurrentDate(referenceDate) > 0){
      return false;
    }
    else if(compareWithCurrentDate(referenceDate) == 0){
      if(compareWithCurrentTime(referenceTime)){
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    // copyRoutesToPassenger();
    checkIfDataExists();
    super.initState();
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
        child: StreamBuilder(
          stream: userDB.getDriverRoutesDatabaseReference(widget.driverId).onValue,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List routes = getRoutesList(snapshot.data!);
              for(int i=0 ; i<routes.length ; i++){
                if(checkIfStarted(routes[i])){
                  userDB.removeRouteFromDriverRoutes(widget.driverId, routes[i]['Key']);
                }
              }
              routes.sort((a, b) => a['Time'].compareTo(b['Time']));
              routes.sort((a, b) => a['Date'].compareTo(b['Date']));
              if(routes.isEmpty){
                return Center(
                    child: Text('Routes List is Empty!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      )
                    )
                );
              }
              else{
                return Padding(
                  padding: const EdgeInsets.all(7),
                  child: ListView.builder(
                    itemCount: routes.length,
                    itemBuilder: (context, index){
                      return Card(
                        color: primaryColor,
                        child: RoutesListItem(route: routes[index], driverId: widget.driverId,)
                      );
                    }
                  ),
                );
              }
            }
            else if(snapshot.hasError){
              return Center(child: Text('Some Error Occurred!'));
            }
            else{
              if(dataExists){
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                );
              }
              else{
                return Center(
                  child: Text('Routes List is Empty!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    )
                  )
                );
              }
            }
          },
        )
      ),
    );
  }
}
