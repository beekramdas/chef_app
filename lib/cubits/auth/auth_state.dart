part of 'auth_cubit.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  restaurantNotRegistered,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final UserModelR? user;
  final bool isLoading;
  final String? errorMessage;
  final bool restaurantExists;

  const AuthState({
    required this.authStatus,
    required this.user,
    required this.isLoading,
    required this.errorMessage,
    required this.restaurantExists,
  });

  factory AuthState.initial() {
    return const AuthState(
      authStatus: AuthStatus.unknown,
      user: null,
      isLoading: false,
      errorMessage: null,
      restaurantExists: false,
    );
  }

  @override
  String toString() {
    return 'AuthState{authStatus: $authStatus, user: $user, isLoading: $isLoading, errorMessage: $errorMessage, restaurantExists: $restaurantExists}';
  }

  @override
  List<Object?> get props => [
    authStatus,
    user,
    isLoading,
    errorMessage,
    restaurantExists,
  ];

  AuthState copyWith({
    AuthStatus? authStatus,
    UserModelR? user,
    bool? isLoading,
    String? errorMessage,
    bool? restaurantExists,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      restaurantExists: restaurantExists ?? this.restaurantExists,
    );
  }
}
