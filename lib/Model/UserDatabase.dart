import 'package:firebase_database/firebase_database.dart';

class UserDatabase{
  Future<Map> getUserInfo(String id) async{
    final dbRef = FirebaseDatabase.instance.ref().child('Users').child(id);

    DataSnapshot snapshot = await dbRef.get();
    Map user = snapshot.value as Map;
    return user;
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