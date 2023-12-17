import 'package:car_sharing_app/resources/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../Model/Remote/UserDatabase.dart';
import '../../../resources/util.dart';
import 'HistoryListItem.dart';


class HistoryFragment extends StatefulWidget {
  final passengerId;
  const HistoryFragment({Key? key, this.passengerId}) : super(key: key);

  @override
  State<HistoryFragment> createState() => _HistoryFragmentState();
}

class _HistoryFragmentState extends State<HistoryFragment> {
  UserDatabase userDB = UserDatabase();

  bool dataExists = true;

  List getHistoryRoutesList(DatabaseEvent streamSnapshotData){
    DataSnapshot databaseSnapshot = streamSnapshotData.snapshot;
    if(!databaseSnapshot.exists){
      return [];
    }
    Map routesMap = streamSnapshotData.snapshot.value as Map;
    List routesList = routesMap.values.toList();
    return routesList;
  }

  void checkIfDataExists() async{
    DataSnapshot snapshot = await userDB.getPassengerHistoryDatabaseReference(widget.passengerId).get();
    dataExists = snapshot.exists;
  }

  bool checkIfExpired(Map route){
    List<String> tripDate = route['Date'].split('-');
    String tripTime = route['Time'];
    String referenceDate = '';
    String referenceTime = '';
    if(tripTime == '7:30 AM'){
      referenceTime = '11:30 PM';
      referenceDate = DateTime(
          int.parse(tripDate[0]),
          int.parse(tripDate[1]),
          int.parse(tripDate[2])-1
      ).toString().split(' ')[0];
    }
    else if(tripTime == '5:30 PM'){
      referenceTime = '04:30 PM';
      referenceDate = tripDate.join('-');
    }
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
    checkIfDataExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: StreamBuilder(
        stream: userDB.getPassengerHistoryDatabaseReference(widget.passengerId).onValue,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List historyRoutes = getHistoryRoutesList(snapshot.data!);
            for(int i=0 ; i<historyRoutes.length ; i++){
              if(historyRoutes[i]['Status'] == 'Pending'){
                if(checkIfExpired(historyRoutes[i])){
                  userDB.updateRouteStatus('Expired',
                      historyRoutes[i]['DriverId'],
                      historyRoutes[i]['PassengerId'],
                      historyRoutes[i]['Key']
                  );
                }
              }
            }
            if(historyRoutes.isEmpty){
              return Center(
                child: Text('Order History is Empty!',
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
                  itemCount: historyRoutes.length,
                  itemBuilder: (context, index){
                    return Card(
                      color: primaryColor,
                      child: HistoryListItem(route: historyRoutes[index],)
                    );
                  }
                ),
              );
            }
          }
          else if(snapshot.hasError){
            return Center(
              child: Text('Some Error Occurred!'),
            );
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
                child: Text('Order History is Empty!',
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
        }
      ),
    );
  }
}
