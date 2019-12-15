import 'package:flutter/material.dart';
import 'package:coursatk/models/courses.dart';
import 'package:coursatk/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coursatk/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseTile extends StatelessWidget {

  final Course course;
  final String majors;
  CourseTile({this.course, this.majors});
  String enrolledCourses = '';
  String simpleError = '';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void _showInfoPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Colors.grey[900],
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Name: ${course.title}\nDescription: ${course.description}\n'
                    'Currently Enrolled: ${course.currentStudents}/${course.maxStudents}',
                style: TextStyle(
                    color: Colors.amberAccent, fontSize: 13.0,
                ),
              ),
                RaisedButton(
                  child: Row(
                      children: <Widget>[
                        Text('Download files', style: TextStyle(fontSize: 12),),
                        Icon(
                          Icons.file_download,
                          color: Colors.black,
                        )
                      ]
                  ),
                  color: Colors.pink,
                  onPressed: (){
                  },
                ),
              ],
            )
          );
      });
    }
    void _showErrorPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
            color: Colors.grey[900],
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  simpleError,
                  style: TextStyle(
                    color: Colors.amberAccent, fontSize: 13.0,
                  ),
                ),
              ],
            )
        );
      });
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.grey[900],
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Name: ${course.title}\n' //Description: ${course.description}
                    'Currently Enrolled: ${course.currentStudents}/${course.maxStudents}',
                style: TextStyle(color: Colors.amberAccent, fontSize: 16.0),
              ),
              RaisedButton(
                child: Row(
                    children: <Widget>[
                      Text('Enroll'),
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      )
                    ]
                ),
                color: Colors.pink,
                onPressed: (){
                  Firestore.instance.collection('data').document(user.uid).snapshots().listen((data) {
                    enrolledCourses = data['enrolledCourses'];
                    //print(data['enrolledCourses']);
                    //print(course.title+"_");
                    if(enrolledCourses.contains(course.title+"_"))
                      {
                        simpleError = 'You already ENROLLED this course';
                        _showErrorPanel();
                        //print('You already ENROLLED this course');
                      }
                    else
                    {
                      if(course.currentStudents < course.maxStudents)
                        {
                          if(course.majors == data['majors'])
                            {
                              DatabaseService().enrollCourse(course.title, course.currentStudents, user.uid);
                            }
                          else
                            {
                              simpleError = 'You are not MAJORING in this!';
                              _showErrorPanel();
                              //print("You are not MAJORING in this!");
                            }
                        }
                      else
                        {
                          simpleError = 'Maximum Students for this course is REACHED';
                          _showErrorPanel();
                          //print('Maximum Students for this course is REACHED');
                        }
                    }
                  });
                },
              ),

              RaisedButton(
                child: Row(
                    children: <Widget>[
                      Text('Details'),
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                      )
                    ]
                ),
                color: Colors.pink,
                onPressed: () => _showInfoPanel(),
              ),
            ]
        ),
      ),
    );
  }
}
