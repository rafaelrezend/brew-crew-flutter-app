import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/models/user.dart';
import 'package:first_flutter_app/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  AppUser _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null ? AppUser(uid: firebaseUser.uid) : null;
  }

  Stream<AppUser> get user {
    return _auth.authStateChanges()
        .map((User firebaseUser) => _userFromFirebaseUser(firebaseUser));
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
     try {
       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User firebaseUser = result.user;

       // create a document for the new user
       await DatabaseService(uid: firebaseUser.uid).updateUserData('0', 'new member', 100);

       return _userFromFirebaseUser(firebaseUser);
     } catch (e) {
       print(e.toString());
       return null;
     }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }

}