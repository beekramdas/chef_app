import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/UserModel.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/restaurant_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final RestaurantRepository restaurantRepository;
  StreamSubscription? _authSubscription;

  AuthCubit({required this.authRepository, required this.restaurantRepository})
    : super(AuthState.initial()) {
    // Listen to Firebase auth state changes
    _authSubscription = authRepository.user.listen((firebaseUser) async {
      if (firebaseUser == null) {
        emit(
          AuthState.initial().copyWith(authStatus: AuthStatus.unauthenticated),
        );
      } else {
        try {
          final user = await authRepository.getUser(firebaseUser.uid);
          final restaurantExists = await restaurantRepository.restaurantExists(
            user.id,
          );

          emit(
            state.copyWith(
              authStatus: restaurantExists
                  ? AuthStatus.authenticated
                  : AuthStatus.restaurantNotRegistered,
              user: user,
              restaurantExists: restaurantExists,
              isLoading: false,
              errorMessage: null,
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.unauthenticated,
              isLoading: false,
              errorMessage: e.toString(),
            ),
          );
        }
      }
    });
  }

  /// -------------------- SIGN UP --------------------
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final user = await authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );

      // For new users, restaurant obviously doesn't exist yet
      emit(
        state.copyWith(
          isLoading: false,
          authStatus: AuthStatus.restaurantNotRegistered,
          user: user,
          restaurantExists: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// -------------------- SIGN IN --------------------
  Future<void> signIn({required String email, required String password}) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final user = await authRepository.signIn(
        email: email,
        password: password,
      );
      final restaurantExists = await restaurantRepository.restaurantExists(
        user.id,
      );

      emit(
        state.copyWith(
          isLoading: false,
          authStatus: restaurantExists
              ? AuthStatus.authenticated
              : AuthStatus.restaurantNotRegistered,
          user: user,
          restaurantExists: restaurantExists,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// -------------------- SIGN OUT --------------------
  Future<void> signOut() async {
    try {
      emit(state.copyWith(isLoading: true));
      await authRepository.signOut();
      emit(
        AuthState.initial().copyWith(authStatus: AuthStatus.unauthenticated),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// -------------------- CLEAR ERROR --------------------
  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
