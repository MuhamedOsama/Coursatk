import 'package:flutter/material.dart';
import 'package:coursatk/screens/authenticate/register.dart';
import 'package:coursatk/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Coursatk'),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
          elevation: 0.0,
        ),
      body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/c.jpg'),
                radius: 60.0,
              )
            ),
            // Divider(height: 60.0, color: Colors.white, thickness: 15.0,),
            SizedBox(height: 20.0,),
            RaisedButton(
                color: Colors.grey[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.grey[800],),
                ),
                onPressed: () {},
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              color: Colors.grey[400],
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.grey[800],),
              ),
              onPressed: () {},
            )
          ],
        )
      ],
    )
    );
    /*Container(
      child: Register(),
    );*/
  }
}
