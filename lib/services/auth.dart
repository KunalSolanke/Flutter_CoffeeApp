import 'package:brewfirebaseapp/models/user.dart';
import 'package:brewfirebaseapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  //we will define all the differnt process which wilhelp us interact with
  //firebase app
  //it is just like the databasehelper class

  //we have to create instance of firebase database

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //final will note change in future

  //custom usr based on firebase user

  User _userfromfirebaseeUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //this is our stream set up for the custom user
  //so we will know the changes between user login
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userfromfirebaseeUser(user)
            //.map(_userfireaseUser(user))
            );
  }

  //signin annonymous method--this will be a async method

  Future signInAnon() async {
    //this could end up in error

    try {
      AuthResult result = await _auth.signInAnonymously();
      //result is returned form the backend that is by the Firebase
      //result is a AuthResult is object also on the resultobj we have access to user object

      FirebaseUser user = result.user;
      //type of user object is FirebaseUser

      return _userfromfirebaseeUser(user);
      //allows us to sin in anonymously

    } catch (e) {
      print(e.toString());
      //error to string
      return null;
    }

    //we have created a signin meth which can be used
  }

  //sigin using email and pass
  Future signInwithemailndPass(String email, String paasw)  async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: paasw);
      FirebaseUser user = result.user ;
      return _userfromfirebaseeUser(user) ;
    }catch(e){
      print(e.toString()) ;
      return null ;
    }
  }


  //register with eamil and pass

  Future registerInwithemailndPass(String email, String paasw)  async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: paasw);
      FirebaseUser user = result.user ;
      //we are creating a document of brew for thw user

      await DatabaseService(uid : user.uid).updateUserData('0', 'newCrewmember',100) ;

      return _userfromfirebaseeUser(user) ;
    }catch(e){
      print(e.toString()) ;
      return null ;
    }
  }





  //sign- out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
