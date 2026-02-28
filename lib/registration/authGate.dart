import 'package:chef_app/cubits/restaurant/restaurant_cubit.dart';
import 'package:chef_app/indexPage.dart';
import 'package:chef_app/registration/login.dart';
import 'package:chef_app/registration/restaurant_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      context.read<RestaurantCubit>().getRestaurant(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return LoginPage();
    }

    return BlocConsumer<RestaurantCubit, RestaurantState>(
      listener: (context, state) {},

      builder: (context, state) {
        /// Loading
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        /// Restaurant NOT exist
        if (state.restaurant == null) {
          return const RestaurantRegister();
        }

        /// Restaurant Exist
        return IndexPage();
      },
    );
  }
}
