import 'package:firebase_auth/firebase_auth.dart';
import 'package:coursatk/models/user.dart';

class AuthService {
  // Creates an instance of our FirebaseAuth
  // Allows to communicate with our firebase_auth in our backend.
  // Remainder: Final = once assigned won't change in the future.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User Object based on FIreBaseUser
  User _fireBaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth change stream
  Stream<User> get user {
    // Listens for AuthChanges and returns what happened.
    // Uses .map function to return in our custom class for User in models/user.dart
    return _auth.onAuthStateChanged.map(_fireBaseUser);
    //same as this but shorter. .map((FirebaseUser user) => _fireBaseUser(user));

  }

  // Anonymous Sign-In
  // If you are not aware what Future & async are flutter-academy.com/async-in-flutter-futures
  Future signInAnon() async {
    // Try & Catch in case of any error we can get a result for it then solve it.
    try {
    // await - Waits for the result from firebase
    // returns a AuthResult (named result) which shows us what happened (success or fail & error in the case)
     AuthResult result = await _auth.signInAnonymously();
     // Now we have access to that user, Let's assign it somewhere.
     FirebaseUser user = result.user;
     return _fireBaseUser(user); // return it for other functions to use (if needed)
    } catch(e) {
      // Catches the error & converts it to string to be printed.
      print(e.toString());
      return null;
    }
  }

  // Email & Pass Sign-In

  // Email & Pass Register

  // Sign Out
  Future signOut() async {
    try{
      // a firebase method that logs user out. unimaginable right?
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}