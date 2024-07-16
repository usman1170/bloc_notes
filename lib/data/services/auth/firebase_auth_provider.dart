import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';
import 'package:zoom/data/services/auth/auth_exceptions.dart';
import 'package:zoom/data/services/auth/auth_provider.dart';
import 'package:zoom/data/services/auth/auth_user.dart';
import 'package:zoom/firebase_options.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw WeakPasswordAuthException();
      } else if (e.code == "email-already-in-use") {
        throw EmailAlreadyUsedAuthException();
      } else {
        throw GeneralAuthException();
      }
    } catch (_) {
      throw GeneralAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException code: ${e.code}");
      print("Error message: ${e.message}");
      print("Error details: ${e.toString()}");
      switch (e.code) {
        case 'wrong-password':
          throw WrongCredentialsAuthException();
        case 'invalid-email':
          throw InvalidEmailAuthException();
        case 'user-not-found':
          throw WrongCredentialsAuthException();
        case 'user-disabled':
          throw UserNotLoggedInAuthException();
        case 'invalid-credential':
          throw WrongCredentialsAuthException();
        case 'operation-not-allowed':
        default:
          throw GeneralAuthException();
      }
    } catch (e) {
      print("Exception: $e");
      throw GeneralAuthException();
    }
  }

  // @override
  // Future<AuthUser> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     final user = currentUser;
  //     if (user != null) {
  //       return user;
  //     } else {
  //       throw UserNotLoggedInAuthException();
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.code);
  //     print("FirebaseAuthException code: ${e.code}");
  //     switch (e.code) {
  //       case 'wrong-password':
  //       case 'invalid-credential':
  //       case 'user-not-found':
  //         throw WrongCredentialsAuthException();
  //       case 'user-disabled':
  //         throw UserNotLoggedInAuthException();
  //       case 'operation-not-allowed':
  //         throw GeneralAuthException();
  //       default:
  //         throw GeneralAuthException();
  //     }
  //   } catch (_) {
  //     throw GeneralAuthException();
  //   }
  // }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> intialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }
}
