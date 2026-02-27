import 'dart:async';

import 'package:chef_app/models/UserModel.dart';
import 'package:chef_app/repositories/auth_repository.dart';
import 'package:chef_app/repositories/restaurant_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  final RestaurantRepository restaurantRepository;
  StreamSubscription? _authSubscription;

  AuthCubit({required this.authRepository, required this.restaurantRepository})
    : super(AuthState.initial()) {
    _authSubscription = authRepository.user.listen((firebaseUser) async {
      if (firebaseUser != null) {
        final exists = await restaurantRepository.restaurantExists(
          firebaseUser.uid,
        );
        if (exists) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.authenticated,
              restaurantExists: exists,
            ),
          );
        } else {
          emit(state.copyWith(authStatus: AuthStatus.restaurantNotRegistered));
        }
      } else {
        emit(
          state.copyWith(authStatus: AuthStatus.unauthenticated, user: null),
        );
      }
    });
  }

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
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: null,
          user: user,
          authStatus: AuthStatus.authenticated,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> signIn({required email, required password}) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final user = await authRepository.signIn(
        email: email,
        password: password,
      );
      emit(
        state.copyWith(
          isLoading: false,
          authStatus: AuthStatus.authenticated,
          user: user,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(state.copyWith(user: null, authStatus: AuthStatus.unauthenticated));
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
