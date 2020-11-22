import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based onfirebaseUser
  User _userFromFirebseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth changes
  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFirebseUser(user));
        .map(_userFromFirebseUser);
  }

  //sign in
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sing in with email and password
  Future signinwithEmailandPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signup with email and password

  Future registerwithEmailandPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new crew member', 100);
      return _userFromFirebseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
