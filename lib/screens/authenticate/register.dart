import 'package:flutter/material.dart';
import 'package:coursatk/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // _ to make it private, Calls the AuthService instance
  final AuthService _auth = AuthService();

  // TextField states
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          elevation: 0.0,
          title: Text('Coursatk - Sign up'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Homepage'),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  TextFormField(
                    onChanged: (val){
                      setState(() => email = val); // Assigns the value placed in the form in email string
                    },
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Enter your Email', // Adds the Hint above text.
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    onChanged: (val) {
                      setState(() => password = val); // Assigns the value placed in the form in password string
                    },
                    obscureText: true,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Enter your Password', // Adds the Hint above text.
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      print('$email\n$password');
                    } ,
                  ),
                ],

              )
          ),
        )
    );
  }
}
