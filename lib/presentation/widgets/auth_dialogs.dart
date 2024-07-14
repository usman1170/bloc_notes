import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom/presentation/routes.dart';

class AuthDialogs {
  Future<bool> logoutDialogBool(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('LogOut?'),
          content: const Text(
            "Are you sure You want to\nLogOut",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cencel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Logout'),
            )
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  Future<void> logOutDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('LogOut?'),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25, bottom: 12, right: 20),
            child: Text(
              "Are you sure You want to\nLogOut",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 110),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cencel'),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().then(
                          (value) => Navigator.pushNamedAndRemoveUntil(
                              context, loginroute, (route) => false),
                        );
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
