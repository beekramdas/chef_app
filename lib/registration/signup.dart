import 'package:chef_app/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:validators/validators.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _email, _password;
  bool _obscurePassword = true;
  final _passwordController = TextEditingController();

  void _signUp() {
    setState(() => _autovalidateMode = AutovalidateMode.always);
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();

    context.read<AuthCubit>().signUp(
      name: _name!,
      email: _email!,
      password: _password!,
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          if (state.errorMessage != null) {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Error"),
                content: Text(state.errorMessage!),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
            context.read<AuthCubit>().clearError();
          }
          if (state.authStatus == AuthStatus.restaurantNotRegistered) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Container(color: const Color(0xFF1E1E2E)),
                SvgPicture.asset(
                  "assets/ui/login.svg",
                  colorFilter: const ColorFilter.mode(
                    Colors.white12,
                    BlendMode.srcIn,
                  ),
                ),
                Positioned(
                  top: 105,
                  left: -10,
                  right: -10,
                  child: const Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Please sign up to join with us",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height / 1.45,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: _autovalidateMode,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text("NAME"),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "John Doe",
                                  fillColor: const Color(0xFFF0F5FA),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Name required';
                                  }
                                  if (value.trim().length < 2) {
                                    return 'Name must be at least 2 characters long';
                                  }
                                  return null;
                                },
                                onSaved: (value) => _name = value,
                              ),
                              const SizedBox(height: 10),
                              const Text("EMAIL"),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Example@gmail.com",
                                  fillColor: const Color(0xFFF0F5FA),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Email required";
                                  }
                                  if (!isEmail(value.trim())) {
                                    return "Enter a valid Email";
                                  }
                                  return null;
                                },
                                onSaved: (value) => _email = value,
                              ),
                              const SizedBox(height: 10),
                              const Text("PASSWORD"),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  hintText: "* * * * * * * * * *",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () => setState(
                                      () =>
                                          _obscurePassword = !_obscurePassword,
                                    ),
                                  ),
                                  fillColor: const Color(0xFFF0F5FA),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Password Required";
                                  }
                                  if (value.trim().length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                                onSaved: (value) => _password = value,
                              ),
                              const SizedBox(height: 10),
                              const Text("RE-PASSWORD"),
                              TextFormField(
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  hintText: "* * * * * * * * * *",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () => setState(
                                      () =>
                                          _obscurePassword = !_obscurePassword,
                                    ),
                                  ),
                                  fillColor: const Color(0xFFF0F5FA),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (_passwordController.text != value) {
                                    return "Password not match";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: _signUp,
                                child: Container(
                                  height: 62,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xFFFF7622),
                                  ),
                                  child: Center(
                                    child: state.isLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            'SIGN UP',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
