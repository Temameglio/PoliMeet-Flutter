import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Future<String> signUp({String email = "", String password = ""}) async {
    print("function");
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Done");
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      String result = "Error: ${e.message}";
      print(result);
      return result;
    }
  }
}
