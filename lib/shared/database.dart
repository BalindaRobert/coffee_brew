
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lewandowski/models/brews.dart';
import 'package:lewandowski/models/bro.dart';

import '../models/bro.dart';
import '../models/bro.dart';
import '../models/bro.dart';

class DatabaseService{
  final CollectionReference brewsCollection = FirebaseFirestore.instance.collection('brews');
 late final String uid;
 DatabaseService({required this.uid});

  Future updateDatabase(String sugar , String name, dynamic strength) async {
    return await brewsCollection.doc(uid).set({
      sugar: sugar,
      name: name,
      strength: strength,
    });


  }
  //brew list from snapshot
  Iterable<Brews> _brewListFromSnapsot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brews(
          name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',

      );
    }).toList();
  }
// user data from snapshot
  UserData (DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength'],);
  }
// brews stream
Stream<QuerySnapshot> get brews {
    return brewsCollection.snapshots();
}
// user data stream
Stream<UserData> get userData{
    return brewsCollection.doc(uid).snapshots()
    .map(_brewListFromSnapsot);

}
}