import 'package:brewfirebaseapp/models/brew.dart';
import 'package:brewfirebaseapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection refernce
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

//name of it is brews

//add new documents from the collection,read,remove ,update
//we can do using the above refernce

  //every package of stream will snapshots of the document at the particular moment of time

  //function update

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //brew lsit form snapshot
  List<Brew> _brewlistfromsnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          sugars: doc.data['sugars'] ?? '0',
          strength: doc.data['strength'] ?? 0);
    }).toList();
  }

  //get Stream

  //get userdoc strem

  Stream<Userdata> get userdata {
    return brewCollection.document(uid).snapshots().map(_userdataFromsnapshot);
  }

  //userdata from snapshot

  Userdata _userdataFromsnapshot(DocumentSnapshot snapshot) {
    return Userdata(
        uid: uid,
        strength: snapshot.data['strength'],
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars']);
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewlistfromsnapshot);
  }
}
