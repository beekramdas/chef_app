import 'package:flutter/material.dart';
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
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    print("name:$_name//email:$_email//password:$_password");
  }

  @override
  Widget build(BuildContext context) {
    double Height = MediaQuery.of(context).size.height;
    double Width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              // Background color
              Container(color: const Color(0xFF1E1E2E)),

              // SVG on top
              SvgPicture.asset(
                "assets/ui/login.svg",
                colorFilter: const ColorFilter.mode(
                  Colors.white12, // or any color you want for the SVG
                  BlendMode.srcIn,
                ),
              ),
              Positioned(
                top: 105,
                left: -10,
                right: -10,
                child: Container(
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: Height / 1.45,
                  width: Width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                  ),
                  child: Form(
                    autovalidateMode: _autovalidateMode,
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          spacing: 12,
                          children: [
                            Text("NAME"),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "John Doe",
                                hintStyle: const TextStyle(fontSize: 14),
                                fillColor: Color(0xFFF0F5FA),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Name required';
                                }
                                if (value.trim().length < 2) {
                                  return 'Name must be at least 2 characters long';
                                }

                                return null;
                              },
                              onSaved: (String? value) {
                                _name = value;
                              },
                            ),
                            Text("EMAIL"),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Example@gmail.com",
                                hintStyle: TextStyle(fontSize: 14),
                                fillColor: Color(0xFFF0F5FA),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Email required";
                                }
                                if (!isEmail(value.trim())) {
                                  return "Enter a valid Email";
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                _email = value;
                              },
                            ),
                            Text("PASSWORD"),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              obscuringCharacter: "*",
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "* * * * * * * * * *",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  color: Color(0xFFB4B9CA),
                                ),
                                labelStyle: TextStyle(fontSize: 14),
                                fillColor: Color(0xFFF0F5FA),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Password Required";
                                }
                                if (value.trim().length < 6) {
                                  return "Password characters must be 6 character long";
                                }
                                return null;
                              },
                            ),
                            Text("RE-PASSWORD"),
                            TextFormField(
                              obscureText: _obscurePassword,
                              obscuringCharacter: "*",
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "* * * * * * * * * *",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  color: Color(0xFFB4B9CA),
                                ),
                                labelStyle: TextStyle(fontSize: 14),
                                fillColor: Color(0xFFF0F5FA),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (String? value) {
                                if (_passwordController.text != value) {
                                  return "Password not match";
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                _password = value;
                              },
                            ),
                            GestureDetector(
                              onTap: _signUp,
                              child: Container(
                                height: 62,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFFFF7622),
                                ),
                                child: Center(
                                  child: Text(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 30,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      weight: 2,
                      color: Color(0xFF5E616F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
