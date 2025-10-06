import 'dart:io';

import 'package:chef_app/models/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants/db_constants.dart';

class ProductRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ProductRepository({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  Future<void> addProduct(Product product) async {
    try {
      await productRef.add(product.toMap());
    } catch (e) {
      print("Failed to add product: $e");
    }
  }

  /// ✅ Upload a single image/video and return its download URL
  Future<String> uploadFile(File file) async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference ref = firebaseStorage
          .ref()
          .child('products')
          .child(fileName);

      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception("Upload failed: $e");
    }
  }

  /// ✅ Upload multiple files (returns a list of URLs)
  Future<List<String>> uploadMultipleFiles(List<File> files) async {
    try {
      List<String> downloadUrls = [];

      for (final file in files) {
        String url = await uploadFile(file);
        downloadUrls.add(url);
      }

      return downloadUrls;
    } catch (e) {
      throw Exception("Multiple file upload failed: $e");
    }
  }
}
