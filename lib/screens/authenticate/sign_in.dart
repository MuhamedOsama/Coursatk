import 'package:flutter/material.dart';
import 'package:coursatk/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // _ to make it private, Calls the AuthService instance
  final AuthService _auth = AuthService();

  // TextField states
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                onChanged: (val){
                  setState(() => email = val);
                },
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Enter your Email',
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                onChanged: (val) {
                  setState(() => password = val);
                },
                obscureText: true,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Enter your Password',
                ),
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                    'Sign in',
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




