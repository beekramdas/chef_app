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

  Future<UserModelR> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential;

    try {
      /// Try login first (if account already exists in User App)
      credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      /// If account does not exist → create new
      if (e.code == 'user-not-found') {
        credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        rethrow;
      }
    }
    final user = credential.user!;
    final userModelR = UserModelR(id: user.uid, name: name, email: email);

    /// Save chef user in RestaurantUsers collection
    await firebaseFirestore
        .collection("RestaurantUsers")
        .doc(user.uid)
        .set(userModelR.toMap());

    return userModelR;
  }

  Future<UserModelR> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final doc = await firebaseFirestore
        .collection("RestaurantUsers")
        .doc(credential.user!.uid)
        .get();
    return UserModelR.fromMap(doc.data()!);
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
