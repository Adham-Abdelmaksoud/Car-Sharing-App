import 'package:firebase_database/firebase_database.dart';

class RouteDatabase{
  Future<List> getAllRoutes() async{
    final dbRef = FirebaseDatabase.instance.ref().child('Routes');

    DataSnapshot snapshot = await dbRef.get();
    Map routesMap = snapshot.value as Map;
    List routesList = routesMap.values.toList();

    return routesList;
  }


  Future<List> getUserRoutes(String userId) async{
    final dbRef = FirebaseDatabase.instance.ref().child('Users').child(userId).child('Routes');

    DataSnapshot snapshot = await dbRef.get();
    Map routesMap = snapshot.value as Map;
    List routesList = routesMap.values.toList();

    return routesList;
  }


  void addNewRoute(String userId, String pickup, String destination, String time, String cost){
    final routesDBRef = FirebaseDatabase.instance.ref().child('Routes');

    final newRef = routesDBRef.push();
    final key = newRef.key;
    Map route = {
      'key': key,
      'Pickup': pickup,
      'Destination': destination,
      'Time': time,
      'Cost': cost
    };
    newRef.set(route);

    final usersDBRef = FirebaseDatabase.instance.ref().child('Users').child(userId).child('Routes').child(key!);
    usersDBRef.set(route);
  }
}