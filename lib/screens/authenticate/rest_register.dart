import 'package:coursatk/models/user.dart';
import 'package:coursatk/screens/home/home.dart';
import 'package:coursatk/services/database.dart';
import 'package:coursatk/shared/designs.dart';
import 'package:coursatk/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coursatk/services/auth.dart';
import 'package:provider/provider.dart';

class Reg extends StatefulWidget {
  @override
  _RegState createState() => _RegState();
}

class _RegState extends State<Reg> {

  final _formKey = GlobalKey<FormState>();
  String name;
  String _majors;
  final List<String> majors = ['Development','Design','Business'];
  String error;



  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    
            return StreamBuilder<Data>(
              stream: DatabaseService(uid: user.uid).data,
              builder: (context, snapshot) { // ignore: missing_return
                if(snapshot.hasData){
                  Data data = snapshot.data;
                  return Scaffold(
                    backgroundColor: Colors.grey[900],
                    appBar: AppBar(
                      title: Text('Coursatk'),
                      backgroundColor: Colors.grey[850],
                      elevation: 0.0,
                    ),
                    body: Container(
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            TextFormField(
                              initialValue: data.name,
                              decoration: design.copyWith(hintText: 'Name'),
                              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                              onChanged: (val) => setState(() => name = val),
                            ),
                            SizedBox(height: 10.0),
                            DropdownButtonFormField(
                              value: _majors,
                              decoration: design.copyWith(hintText: 'Majors'),
                              items: majors.map((String major) {
                                return DropdownMenuItem(
                                  value: major,
                                  child: Text('$major'),
                                );
                              }).toList(),
                              onChanged: (val) => setState(() => _majors = val ),
                            ),
                            SizedBox(height: 20.0,),
                            RaisedButton(
                              color: Colors.deepOrange,
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async{
                                if(_formKey.currentState.validate())
                                {
                                  await DatabaseService(uid: user.uid).update(
                                      name ?? snapshot.data.name,
                                      _majors ?? snapshot.data.majors
                                  );
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()),(route)=> false );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            );
  }
}
