import 'package:coursatk/screens/authenticate/authenticate.dart';
import 'package:coursatk/screens/home/home.dart';
import 'package:coursatk/shared/loading.dart';
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
  String error = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
        title: Text('Coursatk - Sign in'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Homepage'),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Authenticate()),(route)=> false );
            },
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
                  setState(() => email = val);
                },
                autocorrect: false,
                style: TextStyle(color: Colors.redAccent),
                decoration: InputDecoration(
                  labelText: 'Enter your Email',
                  labelStyle: TextStyle(color: Colors.amberAccent),
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                onChanged: (val) {
                  setState(() => password = val);
                },
                obscureText: true,
                autocorrect: false,
                style: TextStyle(color: Colors.redAccent),
                decoration: InputDecoration(
                  labelText: 'Enter your Password',
                  labelStyle: TextStyle(color: Colors.amberAccent),
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
                  setState(() => loading = true);
                  dynamic result = await _auth.signIn(email, password);
                  if(result == null)
                  {
                    setState(() {
                      error = 'Please supply a valid email';
                      loading = false;
                    });
                  }
                  else
                    {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()),(route)=> false );
                    }
                } ,
              ),
              error == '' ? Text('') : Text('Error, Kindly $error', style: TextStyle(color: Colors.red),),
            ],

          )
        ),
      )
    );
  }
}




