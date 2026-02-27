import 'package:chef_app/cubits/restaurant/restaurant_cubit.dart';
import 'package:chef_app/indexPage.dart';
import 'package:chef_app/registration/login.dart';
import 'package:chef_app/registration/restaurant_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth/auth_cubit.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      /// LISTENER → Trigger Restaurant Load
      listener: (context, authState) {
        if (authState.authStatus == AuthStatus.authenticated) {
          context.read<RestaurantCubit>().getRestaurant(authState.user!.id);
        }
      },

      /// BUILDER → Show Screens
      builder: (context, authState) {
        /// Not Logged In
        if (authState.authStatus == AuthStatus.unauthenticated) {
          return const LoginPage();
        }

        /// Logged In → Check Restaurant
        return BlocBuilder<RestaurantCubit, RestaurantState>(
          builder: (context, restaurantState) {
            if (restaurantState.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            /// No Restaurant → Register
            if (restaurantState.restaurant == null) {
              return const RestaurantRegister();
            }

            /// Restaurant Exists → Home
            return const IndexPage();
          },
        );
      },
    );
  }
}
