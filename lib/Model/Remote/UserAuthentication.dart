import 'package:firebase_auth/firebase_auth.dart';

int authenticateTestCredentials(String email, String password){
  email = email.trim().toLowerCase();
  if(email == 'passenger@eng.asu.edu.eg' && password == 'test1234'){
    return 1;
  }
  if(email == 'driver@eng.asu.edu.eg' && password == 'test5678'){
    return -1;
  }
  return 0;
}

class UserAuthenticator{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  Future<User?> signInWithEmailAndPassword(String email, String password) async{
    email = email.trim().toLowerCase();
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
    email = email.trim().toLowerCase();
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

  void forgetPassword(String email) async{
    email = email.trim().toLowerCase();
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}