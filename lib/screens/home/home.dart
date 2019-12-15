import 'package:coursatk/models/courses.dart';
import 'package:coursatk/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:coursatk/services/auth.dart';
import 'package:coursatk/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coursatk/screens/home/course_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Course>>.value(
      value: DatabaseService().courses,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('Coursatk'),
          backgroundColor: Colors.grey[850],
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

        body: CourseList()

      ),
    );
  }
}


