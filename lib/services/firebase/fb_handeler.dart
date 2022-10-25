import 'package:attendence_admin_app/data/initdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/usermodel.dart';

class FbHandeler {
  static final user = FirebaseAuth.instance.currentUser;
  static final firestoreInstance = FirebaseFirestore.instance;

  static const String userpath = "user";

//check doc is exists
  static Future<int> checkdocstatus(String collectionpath, String docid) async {
    var a = await FirebaseFirestore.instance
        .collection(collectionpath)
        .doc(docid)
        .get();
    if (a.exists) {
      return 1;
    } else if (!a.exists) {
      print('Not exists');
      return 0;
    } else {
      return 0;
    }
  }

// create doc random id;
  static Future<int> createDocAuto(
      Map<String, dynamic> model, String collectionpath) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc()
          .set(model)
          .then((_) {
        print("create  doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }

    return res;
  }

  // create doc manual id;
  static Future<int> createDocManual(
      Map<String, dynamic> model, String collectionpath, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc(docid)
          .set(model)
          .then((_) {
        print("create  doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }

    return res;
  }

//update doc
  static Future<int> updateDoc(
      Map<String, dynamic> model, String collectionpath, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance
          .collection(collectionpath)
          .doc(docid)
          .update(model)
          .then((_) {
        print("update doc");
        res = resok;
      });
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }
    return res;
  }

  //delete doc
  static Future<int> deletedoc(String collection, String docid) async {
    int res = resfail;
    try {
      await firestoreInstance.collection(collection).doc(docid).delete();
      print("delete doc");
      res = resok;
    } on Exception catch (e) {
      print(e);
      res = resfail;
    }
    return res;
  }

  static Future<UserModel> getUser() async {
    String uid = user!.email.toString();
    const String collectionpath = "/users/";
    UserModel model;

    DocumentSnapshot documentSnapshot =
        await firestoreInstance.collection(collectionpath).doc(uid).get();
    model = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
    return model;
  }

  // static Future<List<UserModel>> getFuel(String vtext) async {
  //   List<UserModel> list = [];
  //   UserModel userModel;
  //   // QuerySnapshot

  //   final querySnapshot = await firestoreInstance
  //       .collection("/users/")
  //       .where("verifyText", isEqualTo: vtext)
  //       .get();
  //   print(querySnapshot.docs);

  //   for (int i = 0; i < querySnapshot.docs.length; i++) {
  //     var a = querySnapshot.docs[i];
  //     // userModel = userModel.fromSnapshot(a);
  //     userModel = UserModel.fromMap(a.data());
  //     list.add(userModel);
  //     print(userModel.toMap());
  //   }
  //   return list;
  // }
}
