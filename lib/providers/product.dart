import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavourite = false});

  void toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://shopping-app-9d541.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(url,
          body: json.encode({
            isFavourite,
          }));
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
