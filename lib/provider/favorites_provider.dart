import 'package:flutter/material.dart';
import '../models/famous_model.dart';

class FavoritesProvider with ChangeNotifier {
  List<FamousPerson> _favorites = [];

  List<FamousPerson> get favorites => _favorites;

  void toggleFavorite(FamousPerson person) {
    if (_favorites.contains(person)) {
      _favorites.remove(person);
    } else {
      _favorites.add(person);
    }
    notifyListeners();
  }

  bool isFavorite(FamousPerson person) {
    return _favorites.contains(person);
  }
}
