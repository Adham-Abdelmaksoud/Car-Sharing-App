bool validateLogin(String email, String password){
  email = email.trim();
  if(email == '19p1250@eng.asu.edu.eg' && password == '1234'){
    return true;
  }
  return false;
}