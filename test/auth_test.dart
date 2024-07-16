import 'package:zoom/data/services/auth/auth_provider.dart';
import 'package:zoom/data/services/auth/auth_user.dart';

void main() {}

class MockAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  AuthUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> intialize() {
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> login({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    throw UnimplementedError();
  }
}
