import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_env_flutter/item_model.dart';

class ItemRepository {
  final refItems = FirebaseFirestore.instance.collection("test_collection");

  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) => Item.fromFirestore(doc)).toList();
    } catch (e) {
      return [];
    }
  }

  Stream<List<Item>> get itemList {
    return refItems.snapshots().map(_itemListFromSnapshot);
  }
}
