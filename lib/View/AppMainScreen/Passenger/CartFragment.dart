import 'package:car_sharing_app/resources/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../Model/Remote/UserDatabase.dart';
import '../../../resources/TimeHelper.dart';
import 'CartListItem.dart';

class CartFragment extends StatefulWidget {
  final String passengerId;
  const CartFragment({Key? key, required this.passengerId}) : super(key: key);

  @override
  State<CartFragment> createState() => _CartFragmentState();
}

class _CartFragmentState extends State<CartFragment> {
  UserDatabase userDB = UserDatabase();

  bool dataExists = true;

  List getCartRoutesList(DatabaseEvent streamSnapshotData){
    DataSnapshot databaseSnapshot = streamSnapshotData.snapshot;
    if(!databaseSnapshot.exists){
      return [];
    }
    Map routesMap = streamSnapshotData.snapshot.value as Map;
    List routesList = routesMap.values.toList();
    return routesList;
  }

  void checkIfDataExists() async{
    DataSnapshot snapshot = await userDB.getPassengerCartDatabaseReference(widget.passengerId).get();
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
    checkIfDataExists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: StreamBuilder(
          stream: userDB.getPassengerCartDatabaseReference(widget.passengerId).onValue,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List cartRoutes = getCartRoutesList(snapshot.data!);
              for(int i=0 ; i<cartRoutes.length ; i++){
                if(checkIfStarted(cartRoutes[i])){
                  userDB.removeRouteFromPassengerCart(widget.passengerId, cartRoutes[i]['Key']);
                }
              }
              cartRoutes.sort((a, b) => a['Time'].compareTo(b['Time']));
              cartRoutes.sort((a, b) => a['Date'].compareTo(b['Date']));
              if(cartRoutes.isEmpty){
                return Center(
                  child: Text('Cart is Empty!',
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
                    itemCount: cartRoutes.length,
                    itemBuilder: (context, index){
                      return Card(
                        color: primaryColor,
                        child: CartListItem(passengerId: widget.passengerId, route: cartRoutes[index],)
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
                  child: Text('Cart is Empty!',
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
