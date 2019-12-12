import 'package:flutter/material.dart';
import 'models/user.dart';
import 'screens/warpper.dart';
import 'services/auth.dart';
import 'package:provider/provider.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( // Creates a provider widget which listens on a specific stream
      value: AuthService().user, // specifies the value the stream listens to for changes
      child: MaterialApp(
        home: Wrapper(),
      ),
    );

  }
}

