// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:zoom/data/services/auth/auth_exceptions.dart';
import 'package:zoom/data/services/auth/auth_services.dart';
import 'package:zoom/presentation/screens/auth/signup.dart';
import 'package:zoom/presentation/screens/auth/verify.dart';
import 'package:zoom/presentation/screens/notes/home.dart';
import 'package:zoom/presentation/widgets/dialogs.dart';
import 'package:zoom/presentation/widgets/glass_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/imgs/bg4.jpeg",
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: isLoading
                ? const LoadingWidget()
                : GlassWidget(
                    height: 420,
                    width: 350,
                    child: Column(
                      children: [
                        const Text(
                          "Welcome Again!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Row(
                            children: [
                              Text(
                                "Enter details to Login.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: .4,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        _inputField(),
                        const SizedBox(
                          height: 16,
                        ),
                        _inputField(ispassword: true),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen(),
                                      ));
                                },
                                child: const Text(
                                  "Create account?",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        _loginButton(
                          () async {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isLoading = true;
                            });
                            final email = _email.text.toString();
                            final password = _password.text.toString();
                            try {
                              await AuthServices.firebase()
                                  .login(
                                email: email,
                                password: password,
                              )
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                final user =
                                    AuthServices.firebase().currentUser;
                                if (user!.isEmailVerified) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const VerifyScreen(),
                                    ),
                                  );
                                }
                              });
                            } on WrongCredentialsAuthException {
                              setState(() {
                                isLoading = false;
                              });
                              Dialogs().errorDialog(context, "Error Occured",
                                  "Invalid Credentials");
                            } on InvalidEmailAuthException {
                              setState(() {
                                isLoading = false;
                              });
                              Dialogs().errorDialog(
                                  context, "Error Occured", "Invalid Email");
                            } on InternetNotFoundAuthException {
                              setState(() {
                                isLoading = false;
                              });
                              Dialogs().errorDialog(context, "Error Occured",
                                  "Please check your internet connectivity");
                            } on GeneralAuthException {
                              setState(() {
                                isLoading = false;
                              });

                              Dialogs().errorDialog(context, "Error Occured",
                                  "Something wents wrong");
                            }
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _divider(),
                        const SizedBox(
                          height: 16,
                        ),
                        _otherLogin(),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _inputField({
    bool ispassword = false,
  }) {
    return TextField(
      controller: ispassword ? _password : _email,
      obscureText: ispassword,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(.5),
        filled: true,
        hintText: ispassword ? "Enter your password" : "Enter your email",
        hintStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: ispassword
            ? const Icon(
                Icons.lock,
                color: Colors.purple,
              )
            : const Icon(
                Icons.email,
                color: Colors.purple,
              ),
        suffixIcon: ispassword
            ? Padding(
                padding: const EdgeInsets.only(right: 6),
                child: InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.visibility,
                    color: Colors.purple,
                  ),
                ),
              )
            : const SizedBox(),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: .01),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.purple, width: .4),
        ),
      ),
    );
  }

  Widget _loginButton(VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.purple.shade400,
            Colors.purple.shade500,
            Colors.purple.shade700,
          ]),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 2,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
          ),
          Container(
            height: 2,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
          ),
          Container(
            height: 2,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
          ),
        ],
      ),
    );
  }

  Widget _otherLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage("assets/imgs/g.png"))),
          ),
          Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage("assets/imgs/f.png"))),
          ),
        ],
      ),
    );
  }
}
