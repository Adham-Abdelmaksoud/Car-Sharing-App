import 'package:firebase_database/firebase_database.dart';

class RouteDatabase{
  DatabaseReference getRoutesDatabaseReference(){
    return FirebaseDatabase.instance.ref().child('Routes');
  }

  Future<List> getAllRoutes() async{
    DataSnapshot snapshot = await getRoutesDatabaseReference().get();
    Map routesMap = snapshot.value as Map;
    List routesList = routesMap.values.toList();

    return routesList;
  }

  void addNewRoute(String driverId, String pickup, String destination, String date, String time, String cost){
    final newRef = getRoutesDatabaseReference().push();
    final key = newRef.key;
    Map route = {
      'Key': key,
      'DriverId': driverId,
      'Pickup': pickup,
      'Destination': destination,
      'Date': date,
      'Time': time,
      'Cost': cost
    };
    newRef.set(route);

    final usersDBRef = FirebaseDatabase.instance.ref().child('Users').child(driverId).child('Routes').child(key!);
    usersDBRef.set(route);
  }

  void removeRoute(String routeId){
    getRoutesDatabaseReference().child(routeId).remove();
  }
}