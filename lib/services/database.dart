import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursatk/models/user.dart';
import 'package:coursatk/models/majors.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  final CollectionReference registerCollection =Firestore.instance.collection('data');

  Future update(String name,String majors) async{
    return await registerCollection.document(uid).setData({
      'name': name,
      'majors': majors,
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


}
