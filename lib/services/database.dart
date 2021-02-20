import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference profileCollection = Firestore.instance.collection('profiles');
  Future updateUserData(String name, int age) async {
    return await profileCollection.document(uid).setData({
      'name': name,
      'age': age,
    });
  }
}