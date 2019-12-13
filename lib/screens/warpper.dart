import 'package:flutter/material.dart';
import 'package:coursatk/screens/authenticate/authenticate.dart';
import 'package:coursatk/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:coursatk/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); // We're trying to receive User date here so..
    // Will either print (null) if we've no date or Instance of User.
    // return either Home or Auth widget.
    if(user == null){ // Good ol' If/else to either show Auth (login/register) or our home.
      return Authenticate();
    }
    else return Home();
  }
}
