import 'dart:io';

import 'package:chef_app/constants/db_constants.dart';
import 'package:chef_app/models/restaurantModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RestaurantRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  const RestaurantRepository({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  Future<List<String>> uploadMultipleFiles(List<File> files) async {
    List<String> downloadUrls = [];
    for (final file in files) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = firebaseStorage.ref().child(
        "uploads/restaurants/$fileName",
      );
      final uploadTask = await storageRef.putFile(file);
      final url = await uploadTask.ref.getDownloadURL();
      downloadUrls.add(url);
    }
    return downloadUrls;
  }

  bool isImage(File file) {
    final ext = file.path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(ext);
  }

  Future<void> addRestaurant(RestaurantModel restaurant) async {
    try {
      final docRef = restaurantRef.doc(restaurant.userId);
      final restaurantWithId = restaurant.copyWith(res_id: restaurant.userId);
      await docRef.set(restaurantWithId.toMap());
      print("Restaurant added successfully with id ${docRef.id}");
    } catch (e) {
      rethrow;
    }
  }

  Stream<RestaurantModel?> getRestaurant(String userId) {
    return restaurantRef.doc(userId).snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      }

      return RestaurantModel.fromMap(doc.data()!);
    });
  }

  Future<bool> restaurantExists(String userId) async {
    final doc = await restaurantRef.doc(userId).get();
    return doc.exists;
  }
}
