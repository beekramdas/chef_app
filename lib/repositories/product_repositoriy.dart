import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  final FirebaseFirestore firebaseFirestore;

  ProductRepository({required this.firebaseFirestore});
}
