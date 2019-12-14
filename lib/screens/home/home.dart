import 'package:coursatk/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:coursatk/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Home boii'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Authenticate()),(route)=> false );

            },
          )
        ],
      ),

    );
  }
}
