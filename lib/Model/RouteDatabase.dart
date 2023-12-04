import 'package:firebase_database/firebase_database.dart';

class RouteDatabase{
  Future<List> getAllRoutes() async{
    final dbRef = FirebaseDatabase.instance.ref().child('Routes');

    DataSnapshot snapshot = await dbRef.get();
    List routes = snapshot.value as List;
    return routes;
  }




  void registerUser(String id, String username, String email, String password){
    final dbRef = FirebaseDatabase.instance.ref().child('Users').child(id);

    Map user = {
      'Username': username,
      'Email': email,
      'Password': password
    };
    dbRef.set(user);
  }
}