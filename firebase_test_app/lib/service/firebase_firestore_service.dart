import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test_app/model/Info.dart';

//https://grokonez.com/flutter/flutter-firestore-example-firebase-firestore-crud-operations-with-listview
//Link above was used as a source to solve this assignment as it shows how to create crud operations with a listview using
//a firebase database. This link was also added to our course as a learning source.

//set collection's name in database
final CollectionReference infoCollection = Firestore.instance.collection('infos');

class FirebaseFirestoreService {

  static final FirebaseFirestoreService firestoreInstance = new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => firestoreInstance;

  FirebaseFirestoreService.internal();

  Future<InfoData> createInfo(String name, String laptop, String year) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(infoCollection.document());

      final InfoData informationData = new InfoData(ds.documentID, name, laptop, int.parse(year));
      final Map<String, dynamic> data = informationData.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return InfoData.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getInfoList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = infoCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateInfo(InfoData info) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(infoCollection.document(info.id));

      await tx.update(ds.reference, info.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteInfo(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(infoCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}