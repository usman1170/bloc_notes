// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom/presentation/constants.dart';
import 'package:zoom/presentation/screens/auth/login.dart';
import 'package:zoom/presentation/widgets/dialogs.dart';
import 'package:zoom/presentation/widgets/glass_widget.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
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
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          //   child: const Center(child: Text("data")),
          // ),
          Center(
            child: isLoading
                ? const LoadingWidget()
                : GlassWidget(
                    height: 380,
                    width: 350,
                    child: Column(
                      children: [
                        const Text(
                          "Welcome",
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
                                "Please verify yourself...",
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: mainColor,
                                )),
                            child: Text(
                              "We have sent you verification email, or check your spam folder. If you didn't receive yhe email please click the button to get email",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                letterSpacing: .4,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _loginButton(() async {
                          setState(() {
                            isLoading = true;
                          });
                          final user = FirebaseAuth.instance.currentUser;
                          try {
                            await user!.sendEmailVerification().then((value) {
                              Dialogs().errorDialog(context, 'Email Sent',
                                  "Please check your mail box and verify yourself");
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "network-request-failed") {
                              setState(() {
                                isLoading = false;
                              });
                              Dialogs().errorDialog(
                                  context, 'Error Occured', "Network Error");
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                        }, "Send Verification Email"),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "-OR-",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        _loginButton(() async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        }, "Back To Login"),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget _loginButton(VoidCallback ontap, String title) {
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
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const GlassWidget(
        height: 380,
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 24,
            ),
            Text("Please wait...")
          ],
        ));
  }
}
