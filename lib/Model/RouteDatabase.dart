import 'package:firebase_database/firebase_database.dart';

class RouteDatabase{
  Future<List> getAllRoutes() async{
    final dbRef = FirebaseDatabase.instance.ref().child('Routes');

    DataSnapshot snapshot = await dbRef.get();
    List routes = snapshot.value as List;
    return routes;
  }
}