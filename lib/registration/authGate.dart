import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';
import '../indexPage.dart';
import '../registration/restaurant_register.dart';
import 'login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isLoading || state.authStatus == AuthStatus.unknown) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.authStatus == AuthStatus.unauthenticated) {
          return const LoginPage();
        }

        if (state.authStatus == AuthStatus.restaurantNotRegistered) {
          return const RestaurantRegister();
        }

        if (state.authStatus == AuthStatus.authenticated) {
          return const IndexPage();
        }

        return const LoginPage();
      },
    );
  }
}
