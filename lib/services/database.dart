import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursatk/models/user.dart';
import 'package:coursatk/models/courses.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference registerCollection = Firestore.instance.collection('data');
  final CollectionReference courseCollection = Firestore.instance.collection('course');

  Future update(String name,String majors, String enrolledCourses) async{
    return await registerCollection.document(uid).setData({
      'name': name,
      'majors': majors,
      'enrolledCourses': enrolledCourses,
    });
  }

  Future addCourseData(String title, String description, String majors, String hours, String maxStudents, int currentStudents) async{
    return await courseCollection.document(title).setData({

      'title': title,
      'description': description,
      'majors': majors,
      'maxStudents': int.parse(maxStudents),
      'currentStudents': currentStudents,
      'hours': int.parse(hours),
    });
  }

   Data _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Data(
        uid: uid,
        name: snapshot.data['name'],
        majors: snapshot.data['majors'],
        enrolledCourses: snapshot.data['enrolledCourses'],
    );
  }

  // get user doc stream
  Stream<Data> get data {
    return registerCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  // Get course stream
  Stream<List<Course>> get courses {
    return courseCollection.snapshots()
    .map(_courseListSnapshot);
  }

  // Courses list
  List<Course> _courseListSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Course(
        title: doc.data['title'] ?? '',
        description: doc.data['description'] ?? '',
        majors: doc.data['majors'] ?? '',
        hours: doc.data['hours'] ?? 0,
        currentStudents: doc.data['currentStudents'] ?? 0,
        maxStudents: doc.data['maxStudents'] ?? 0,
      );
    }).toList();
  }

enrollCourse(String title, int currentStudents,String uid) async{
  String enrolledCourses = '';
  registerCollection.snapshots().listen((data) =>
      data.documents.forEach((doc) { if(doc.toString() == uid); enrolledCourses = doc['enrolledCourses']; } ));
    await courseCollection.document(title).updateData({'currentStudents': currentStudents+1,});
    await registerCollection.document(uid).updateData({'enrolledCourses': enrolledCourses+title+"_"});

   }
}
