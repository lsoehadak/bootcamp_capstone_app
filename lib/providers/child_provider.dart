import 'package:flutter/material.dart';
import '../models/child_model.dart';

class ChildProvider with ChangeNotifier {
  final List<ChildModel> _children = [];
  ChildModel? _activeChild;
  bool _isLoading = false;

  List<ChildModel> get children => _children;
  ChildModel? get activeChild => _activeChild;
  bool get isLoading => _isLoading;

  // TODO: Fetch children from Firestore

  Future<void> addChild(ChildModel child) async {
    _isLoading = true;
    notifyListeners();
    // Dummy delay
    await Future.delayed(const Duration(seconds: 1));
    final newChild = ChildModel(
      id: DateTime.now().toIso8601String(), // dummy id
      nik: child.nik,
      name: child.name,
      age: child.age,
      gender: child.gender,
      weight: child.weight,
      height: child.height,
      headCircumference: child.headCircumference,
    );
    _children.add(newChild);
    _isLoading = false;
    notifyListeners();
  }

  void setActiveChild(ChildModel? child) {
    _activeChild = child;
    notifyListeners();
  }

  // TODO: Add update child logic
}
