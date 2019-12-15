import 'package:coursatk/models/courses.dart';
import 'package:coursatk/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coursatk/screens/home/course_tile.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    final courses = Provider.of<List<Course>>(context);
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index){
        return CourseTile(course: courses[index],);
      },
    );
  }
}

