import 'package:firebase_auth/firebase_auth.dart';

bool authenticateTestCredentials(email, password){
  email = email.trim();
  if(email == 'passenger@eng.asu.edu.eg' && password == 'test1234'){
    return true;
  }
  return false;
}

class UserAuthenticator{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    email = email.toLowerCase().trim();
    try{
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential.user;
    }
    catch(e){
      print('Authentication Error during Login');
    }
    return null;
  }

  Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    email = email.toLowerCase().trim();
    try{
      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential.user;
    }
    catch(e){
    print('Authentication Error during Signup');
    }
    return null;
  }

  Future<void> signOut() async{
    await firebaseAuth.signOut();
  }
}