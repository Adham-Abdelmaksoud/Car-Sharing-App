import 'package:car_sharing_app/Model/UserDatabase.dart';
import 'package:car_sharing_app/resources/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'HistoryListItem.dart';


class HistoryFragment extends StatefulWidget {
  final userId;
  const HistoryFragment({Key? key, this.userId}) : super(key: key);

  @override
  State<HistoryFragment> createState() => _HistoryFragmentState();
}

class _HistoryFragmentState extends State<HistoryFragment> {
  UserDatabase userDB = UserDatabase();

  List getHistoryRoutesList(DatabaseEvent streamSnapshotData){
    DataSnapshot databaseSnapshot = streamSnapshotData.snapshot;
    if(!databaseSnapshot.exists){
      return [];
    }
    Map routesMap = streamSnapshotData.snapshot.value as Map;
    List routesList = routesMap.values.toList();
    return routesList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: StreamBuilder(
        stream: userDB.getPassengerHistoryDatabaseReference(widget.userId).onValue,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List historyRoutes = getHistoryRoutesList(snapshot.data!);
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
              return ListView.builder(
                  itemCount: historyRoutes.length,
                  itemBuilder: (context, index){
                    return Card(
                      color: primaryColor,
                      child: HistoryListItem(route: historyRoutes[index],)
                    );
                  }
              );
            }
          }
          else if(snapshot.hasError){
            return Center(
              child: Text('Some Error Occurred!'),
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          }
        }
      ),
    );
  }
}
