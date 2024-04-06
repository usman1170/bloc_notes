import 'package:flutter/material.dart';
import 'package:zoom/presentation/widgets/glass_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.blue.shade400,
                  const Color.fromARGB(255, 155, 110, 206),
                  Colors.purple,
                ])),
          ),
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
            child: GlassWidget(
              height: 420,
              width: 350,
              child: Column(
                children: [
                  const Text(
                    "Welcome to Notes",
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
                          "Enter details to Sign up.",
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
                  _inputField(isname: true),
                  const SizedBox(
                    height: 16,
                  ),
                  _inputField(),
                  const SizedBox(
                    height: 16,
                  ),
                  _inputField(ispassword: true),
                  const SizedBox(
                    height: 16,
                  ),
                  _signUpButton(),
                  const SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Already have an Account? Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: .4,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _inputField({bool ispassword = false, bool isname = false}) {
    return TextField(
      controller: ispassword
          ? _password
          : isname
              ? _name
              : _email,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(.5),
        filled: true,
        hintText: ispassword
            ? "Enter your password"
            : isname
                ? "Enter your name"
                : "Enter your email",
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
            : isname
                ? const Icon(
                    Icons.person,
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

  Widget _signUpButton() {
    return Container(
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
    );
  }
}
