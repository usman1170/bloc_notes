import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom/presentation/constants.dart';
import 'package:zoom/presentation/routes.dart';
import 'package:zoom/presentation/screens/auth/login.dart';
import 'package:zoom/presentation/widgets/auth_dialogs.dart';
import 'package:zoom/presentation/widgets/dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) {
              log(value.toString());
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () async {
                    Dialogs.showMassage(context, "Logout");
                    final val = await AuthDialogs().logoutDialogBool(context);
                    log(val.toString());
                    if (val) {
                      await FirebaseAuth.instance.signOut().then((nValue) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginroute, (route) => false);
                      });
                    }
                  },
                  value: MenuAction.logout,
                  child: const Text("logout"),
                ),
                PopupMenuItem(
                  onTap: () {
                    Dialogs.showMassage(context, "Settings");
                  },
                  value: MenuAction.settings,
                  child: const Text("Settings"),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
