import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static final AuthServices instance = AuthServices._init();
  AuthServices._init();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithEmailAndPassword ({required String email, required String password}) async{
    return firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> createAccountWithEmailAndPassword ({required String email, required String password}) async{
    return firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<String> resetPassword({required String email}) async{
    try{
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message??"";
    }
  }

}