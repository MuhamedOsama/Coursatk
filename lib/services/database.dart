import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursatk/models/user.dart';
import 'package:coursatk/models/majors.dart';
import 'package:coursatk/models/courses.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference registerCollection = Firestore.instance.collection('data');
  final CollectionReference courseCollection = Firestore.instance.collection('course');

  Future update(String name,String majors) async{
    return await registerCollection.document(uid).setData({
      'name': name,
      'majors': majors,
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

  List<Major> _useDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Major(
          name: doc.data['name'] ?? '',
          majors: doc.data['majors'] ?? ''
      );
    }).toList();
  }

   Data _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Data(
        uid: uid,
        name: snapshot.data['name'],
        majors: snapshot.data['majors']
    );
  }

  Stream<List<Major>> get major {
    return registerCollection.snapshots()
        .map(_useDataListFromSnapshot);
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

}
