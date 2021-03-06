import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Prism/main.dart' as main;

final databaseReference = Firestore.instance;
List userProfileWalls;
int len = 0;
Future<List> getuserProfileWalls(String email) async {
  userProfileWalls = [];
  await databaseReference
      .collection("walls")
      .where('review', isEqualTo: true)
      .where('email', isEqualTo: email)
      .orderBy("createdAt", descending: true)
      .getDocuments()
      .then((value) {
    userProfileWalls = [];
    value.documents.forEach((f) {
      userProfileWalls.add(f.data);
    });
    len = userProfileWalls.length;
    print(len);
  }).catchError((e) {
    print(e.toString());
    print("data done with error");
  });
  return userProfileWalls;
}

Future<int> getProfileWallsLength(String email) async {
  var tempList = [];
  await databaseReference
      .collection("walls")
      .where('review', isEqualTo: true)
      .where('email', isEqualTo: email)
      .orderBy("createdAt", descending: true)
      .getDocuments()
      .then((value) {
    tempList = [];
    value.documents.forEach((f) {
      tempList.add(f.data);
    });
    len = tempList.length;
    print(len);
  }).catchError((e) {
    print(e.toString());
    print("data done with error");
  });
  return len;
}

Future setUserTwitter(String twitter, String id) async {
  await databaseReference
      .collection("users")
      .document(id)
      .updateData({"twitter": twitter});
  main.prefs.put("twitter", twitter);
}

Future setUserIG(String ig, String id) async {
  await databaseReference
      .collection("users")
      .document(id)
      .updateData({"instagram": ig});
  main.prefs.put("instagram", ig);
}
