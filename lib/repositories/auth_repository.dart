import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/UserModel.dart';

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  const AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<User?> get user => firebaseAuth.authStateChanges();

  /// SIGN UP CHEF
  Future<UserModelR> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;

      final userModel = UserModelR(id: user.uid, name: name, email: email);

      await firebaseFirestore
          .collection("RestaurantUsers")
          .doc(user.uid)
          .set(userModel.toMap());

      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        /// try login instead
        final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final uid = credential.user!.uid;

        final doc = await firebaseFirestore
            .collection("RestaurantUsers")
            .doc(uid)
            .get();

        /// If restaurant already registered
        if (doc.exists) {
          throw Exception("Email already registered.");
        }

        /// If auth exists but firestore missing -> create document
        final userModel = UserModelR(id: uid, name: name, email: email);

        await firebaseFirestore
            .collection("RestaurantUsers")
            .doc(uid)
            .set(userModel.toMap());

        return userModel;
      }

      if (e.code == 'weak-password') {
        throw Exception("Password is too weak");
      }

      if (e.code == 'invalid-email') {
        throw Exception("Invalid email format");
      }

      throw Exception(e.message);
    }
  }

  /// SIGN IN CHEF
  Future<UserModelR> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;
      final doc = await firebaseFirestore
          .collection("RestaurantUsers")
          .doc(uid)
          .get();

      if (!doc.exists) {
        await firebaseAuth.signOut();
        throw Exception("This account is not registered as Chef");
      }

      return UserModelR.fromMap(doc.data()!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found with this email");
      } else if (e.code == 'wrong-password') {
        throw Exception("Incorrect password");
      } else {
        throw Exception(e.message);
      }
    }
  }

  /// Fetch user by UID from Firestore
  Future<UserModelR> getUser(String uid) async {
    final doc = await firebaseFirestore
        .collection("RestaurantUsers")
        .doc(uid)
        .get();
    if (!doc.exists) {
      throw Exception("User not found in Firestore");
    }
    return UserModelR.fromMap(doc.data()!);
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
