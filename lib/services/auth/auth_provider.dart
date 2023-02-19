abstract class AuthProvider {
  Future<void> initialize();

  Future<void> logIn({
    required String email,
    required String password,
  });

  Future<void> createUser({
    required String email,
    required String password,
  });

  Future<void> sendPasswordReset({required String email});

  Future<void> logOut();
}
