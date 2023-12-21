import 'package:firebase_database/firebase_database.dart';

class UserDatabase{
  DatabaseReference getUserDatabaseReference(String userId){
    return FirebaseDatabase.instance.ref().child('Users').child(userId);
  }
  DatabaseReference getPassengerCartDatabaseReference(String passengerId){
    return getUserDatabaseReference(passengerId).child('Cart');
  }
  DatabaseReference getPassengerHistoryDatabaseReference(String passengerId){
    return getUserDatabaseReference(passengerId).child('History');
  }
  DatabaseReference getDriverRoutesDatabaseReference(String driverId){
    return getUserDatabaseReference(driverId).child('Routes');
  }
  DatabaseReference getDriverOrdersDatabaseReference(String driverId){
    return getUserDatabaseReference(driverId).child('Orders');
  }




  Future<Map> getUserInfo(String userId) async{
    DataSnapshot snapshot = await getUserDatabaseReference(userId).get();
    Map user = snapshot.value as Map;
    return user;
  }
  void registerUser(String userId, String username, String email, String phoneNumber, String role){
    Map user = {
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'Role': role,
    };
    getUserDatabaseReference(userId).set(user);
  }



  Future<List> getPassengerCartRoutes(String userId) async{
    DataSnapshot snapshot = await getPassengerCartDatabaseReference(userId).get();
    Map routesMap = snapshot.value as Map;
    List routesList = routesMap.values.toList();

    return routesList;
  }
  Future<List> getDriverRoutes(String userId) async{
    DataSnapshot snapshot = await getDriverRoutesDatabaseReference(userId).get();
    Map routesMap = snapshot.value as Map;
    List routesList = routesMap.values.toList();

    return routesList;
  }




  Future<bool> addRouteToPassengerCart(String userId, Map route) async{
    final dbRef = FirebaseDatabase.instance.ref().child('Users').child(userId).child('Cart').child(route['Key']);
    DataSnapshot snapshot = await dbRef.get();
    if(snapshot.exists){
      return false;
    }
    else{
      dbRef.set(route);
      return true;
    }
  }
  void submitOrder(Map route) async{
    DatabaseReference orderRef = getPassengerHistoryDatabaseReference(route['PassengerId']).push();
    String orderKey = await orderRef.key!;
    String routeKey = route['Key'];
    route['Key'] = orderKey;
    orderRef.set(route);

    getDriverOrdersDatabaseReference(route['DriverId']).child(orderKey).set(route);

    DatabaseReference passengerOrderRef = getDriverRoutesDatabaseReference(route['DriverId']).child(routeKey)
        .child('Passengers')
        .child(route['PassengerId'])
        .child('Orders')
        .push();
    passengerOrderRef.set(orderKey);
  }

  Future<Map> getAllOrderingPassengers(String driverId, String routeId) async{
    DatabaseReference passengersRef = getDriverRoutesDatabaseReference(driverId).child(routeId).child('Passengers');

    DataSnapshot snapshot = await passengersRef.get();
    Map orderingPassengersMap = snapshot.value as Map;

    return orderingPassengersMap;
  }




  void removeRouteFromPassengerCart(String userId, String routeId){
    getPassengerCartDatabaseReference(userId).child(routeId).remove();
  }
  void removeRouteFromDriverRoutes(String userId, String routeId){
    getDriverRoutesDatabaseReference(userId).child(routeId).remove();
  }

  void updateRouteStatus(String newStatus, String driverId, String passengerId, String routeId){
    getDriverOrdersDatabaseReference(driverId).child(routeId).update({'Status': newStatus});
    getPassengerHistoryDatabaseReference(passengerId).child(routeId).update({'Status': newStatus});
  }





  void updateTripState(String newState, String driverId, String routeId) async{
    getDriverRoutesDatabaseReference(driverId).child(routeId).update({'State': newState});

    Map passengers = await getAllOrderingPassengers(driverId, routeId);
    for(var passengerId in passengers.keys){
      List passengerOrdersIds = passengers[passengerId]['Orders'].values.toList();
      for(var orderId in passengerOrdersIds){
        DatabaseReference historyOrderRef = getPassengerHistoryDatabaseReference(passengerId).child(orderId);
        DatabaseReference pendingOrderRef = getDriverOrdersDatabaseReference(driverId).child(orderId);

        DataSnapshot snapshot = await historyOrderRef.get();
        Map passengerOrderData = snapshot.value as Map;
        if(passengerOrderData['Status'] == 'Confirmed' || passengerOrderData['Status'] == 'Started'){
          historyOrderRef.update({'Status': newState});
          pendingOrderRef.update({'Status': newState});
        }
      }
    }
  }
}