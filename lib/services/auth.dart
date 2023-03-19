import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lewandowski/models/bro.dart';

import '../shared/database.dart';

class AuthService{
  // method to sign in anon
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Bro? get bro => null;
  // create an object based on firebaseuser
  Bro? _userfromFirebaseUser(Bro? user){
    return User != null ? Bro(uid:user!.uid) : null;
  }

// change user stream

  Stream<Bro?> get user {
    return _auth.authStateChanges().map(_userfromFirebaseUser);
  }
  Future signAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    }
    catch (e) {
      print(e.toString());

      return null;
    }
  }


  Future signInWithEmailandPassword(String email, String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromFirebaseUser(user as Bro);
    }
    catch(e){
      print(e.toString());
    }
  }// method to sign in with email and password

  // method to sign up with email and password
  Future registerWithEmailandPassword(String email, String password) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // use of brewscollection
      await DatabaseService(uid: user!.uid).updateDatabase('0', 'new user', 100);
      return _userfromFirebaseUser(user as Bro);
    }
    catch(e){
      print(e.toString());
    }
  }

  //method to sign out
Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
    return null;
}

}