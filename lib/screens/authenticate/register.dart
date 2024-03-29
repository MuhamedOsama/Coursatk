import 'package:coursatk/screens/authenticate/authenticate.dart';
import 'package:coursatk/screens/authenticate/rest_register.dart';
import 'package:flutter/material.dart';
import 'package:coursatk/services/auth.dart';
import 'package:coursatk/shared/loading.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // _ to make it private, Calls the AuthService instance
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

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
          title: Text('Coursatk - Sign up'),
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
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  TextFormField(
                    onChanged: (val){
                      setState(() => email = val); // Assigns the value placed in the form in email string
                    },
                    autocorrect: false,
                    style: TextStyle(color: Colors.redAccent),
                    decoration: InputDecoration(
                      labelText: 'Enter your Email', // Adds the Hint above text.
                      labelStyle: TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    onChanged: (val) {
                      setState(() => password = val); // Assigns the value placed in the form in password string
                    },
                    obscureText: true,
                    autocorrect: false,
                    style: TextStyle(color: Colors.redAccent),
                    decoration: InputDecoration(
                      labelText: 'Enter your Password', // Adds the Hint above text.
                      labelStyle: TextStyle(color: Colors.amberAccent),
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
                      setState(() => loading = true);
                      if(_formKey.currentState.validate()) {
                        if(password.length < 6) {
                          error = 'Password needs to be at least 6 Characters!';
                          loading = false;
                        }
                        else {
                          setState(() => loading = true);
                          dynamic result = await _auth.register(
                              email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                              loading = false;
                            });
                          }
                          else {
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (context) =>
                                Reg()), (route) => false);
                          }
                        }
                      }
                    } ,
                  ),
                  error == '' ? Text('') : Text('Error, $error', style: TextStyle(color: Colors.red),),
                ],

              )
          ),
        )
    );
  }
}
