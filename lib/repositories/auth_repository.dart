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
    required password,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;
    final userModelR = UserModelR(id: user.uid, name: name, email: email);
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
