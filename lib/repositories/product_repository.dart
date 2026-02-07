import 'dart:io';

import 'package:chef_app/constants/db_constants.dart';
import 'package:chef_app/models/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ProductRepository({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  Future<void> addProduct(Product product) async {
    try {
      final docRef = productRef.doc();
      // Assign Firestore doc ID to product
      final productWithId = product.copyWith(id: docRef.id);
      // Save to Firestore
      await docRef.set(productWithId.toMap());
      print("Product added successfully with ID: ${docRef.id}");
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  // ✅ Upload multiple files (image/video)
  Future<List<String>> uploadMultipleFiles(List<File> files) async {
    List<String> downloadUrls = [];
    for (final file in files) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = firebaseStorage.ref().child("uploads/$fileName");
      final uploadTask = await storageRef.putFile(file);
      final url = await uploadTask.ref.getDownloadURL();
      downloadUrls.add(url);
    }
    return downloadUrls;
  }

  // ✅ Save product data
  // Future<void> saveProductData({
  //   required String name,
  //   required String description,
  //   required double price,
  //   required List<String> mediaUrls,
  //   required List<String> ingredients,
  //   required bool pickup,
  //   required bool delivery,
  // }) async {
  //   await firebaseFirestore.collection('products').add({
  //     "name": name,
  //     "description": description,
  //     "price": price,
  //     "media": mediaUrls,
  //     "ingredients": ingredients,
  //     "pickup": pickup,
  //     "delivery": delivery,
  //     "createdAt": FieldValue.serverTimestamp(),
  //   });
  // }

  // ✅ Optional: Check if a file is image or video
  bool isImage(File file) {
    final ext = file.path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(ext);
  }

  Stream<List<Product>> getProducts() {
    return productRef.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) {
        return Product.fromMap({...doc.data(), "id": doc.id});
      }).toList(),
    );
  }
}
