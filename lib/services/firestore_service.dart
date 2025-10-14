import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/analysis_history.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> saveAnalysisHistory(
    String userId,
    AnalysisHistory analysisHistory,
  ) async {
    try {
      final historyCollectionRef = _db
          .collection('users')
          .doc(userId)
          .collection('analysisHistory');

      await historyCollectionRef.add(analysisHistory.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<AnalysisHistory>> getAnalysisHistoryList(String userId) async {
    final historyCollectionRef = _db
        .collection('users')
        .doc(userId)
        .collection('analysisHistory');

    final querySnapshot = await historyCollectionRef
        .orderBy('date', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      debugPrint(doc.data().toString());
      debugPrint('id : ${doc.id}');
      return AnalysisHistory.fromJson(doc.data(), doc.id);
    }).toList();
  }

  Future<bool> deleteAnalysisHistory(String userId, String docId) async {
    try {
      final historyCollectionRef = _db
          .collection('users')
          .doc(userId)
          .collection('analysisHistory');
      await historyCollectionRef.doc(docId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateAnalysisHistory(String userId, AnalysisHistory analysisHistory) async {
    try {
      final historyCollectionRef = _db
          .collection('users')
          .doc(userId)
          .collection('analysisHistory');
      await historyCollectionRef.doc(analysisHistory.id).update(analysisHistory.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
