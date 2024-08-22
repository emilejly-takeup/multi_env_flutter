import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String name;
  final String category;

  Item({
    required this.id,
    required this.name,
    required this.category,
  });

  factory Item.fromFirestore(QueryDocumentSnapshot<Object?> doc) {
    return Item(
      id: doc.id,
      name: doc.get("name"),
      category: doc.get("category"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "category": category,
    };
  }
}
