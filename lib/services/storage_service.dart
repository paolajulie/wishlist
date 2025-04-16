import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/wish_item.dart';

class StorageService {
  static const _key = 'wishlist';

  Future<void> saveItems(List<WishItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = items.map((e) => e.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  Future<List<WishItem>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List list = jsonDecode(jsonString);
    return list.map((e) => WishItem.fromJson(e)).toList();
  }
}
