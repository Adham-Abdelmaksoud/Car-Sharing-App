import 'package:car_sharing_app/View/AppMainScreen/Driver/OrdersListItem.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../Model/Remote/UserDatabase.dart';
import '../../../resources/colors.dart';
import '../../../resources/TimeHelper.dart';

class PendingOrdersFragment extends StatefulWidget {
  final driverId;
  const PendingOrdersFragment({Key? key, this.driverId}) : super(key: key);

  @override
  State<PendingOrdersFragment> createState() => _PendingOrdersFragmentState();
}

class _PendingOrdersFragmentState extends State<PendingOrdersFragment> {
  UserDatabase userDB = UserDatabase();

  bool dataExists = true;

  List getOrdersList(DatabaseEvent streamSnapshotData){
    DataSnapshot databaseSnapshot = streamSnapshotData.snapshot;
    if(!databaseSnapshot.exists){
      return [];
    }
    Map ordersMap = databaseSnapshot.value as Map;
    List ordersList = ordersMap.values.toList();
    return ordersList;
  }

  void checkIfDataExists() async{
    DataSnapshot snapshot = await userDB.getDriverOrdersDatabaseReference(widget.driverId).get();
    dataExists = snapshot.exists;
  }

  bool checkIfExpired(Map route){
    String referenceDate = getRideConfirmationReferenceDate(route['Date'], route['Time']);
    String referenceTime = getRideConfirmationReferenceTime(route['Time']);
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
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: StreamBuilder(
            stream: userDB.getDriverOrdersDatabaseReference(widget.driverId).onValue,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                List ordersList = getOrdersList(snapshot.data!);
                ordersList.sort((a, b) => b['OrderDateTime'].compareTo(a['OrderDateTime']));
                for(int i=0 ; i<ordersList.length ; i++){
                  if(ordersList[i]['Status'] == 'Pending'){
                    if(checkIfExpired(ordersList[i])){
                      userDB.updateRouteStatus('Expired',
                          ordersList[i]['DriverId'],
                          ordersList[i]['PassengerId'],
                          ordersList[i]['Key']
                      );
                    }
                  }
                }
                if(ordersList.isEmpty){
                  return Center(
                    child: Text('No Pending Orders!',
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
                    itemCount: ordersList.length,
                    itemBuilder: (context, index){
                      return Card(
                        color: primaryColor,
                        child: OrdersListItem(
                          route: ordersList[index],
                        )
                      );
                    }
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
                    child: Text('No Pending Orders!',
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
