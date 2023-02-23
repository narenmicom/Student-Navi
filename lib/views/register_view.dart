import 'package:code/services/auth/supabaseprovider.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final SupabaseAuthProvider _register;
  late bool _passwordVisible;

  @override
  void initState() {
    initialize();
    _email = TextEditingController();
    _password = TextEditingController();
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void initialize() async {
    _register = SupabaseAuthProvider();
    await _register.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text('Enter your email and password to see your notes'),
            TextField(
              controller: _email,
              autocorrect: false,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter your E-mail here",
              ),
            ),
            TextFormField(
              controller: _password,
              obscureText: !_passwordVisible,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Enter your Password here",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      final res = await _register.createUser(
                          email: email, password: password);
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Registered"),
                          content: const Text(
                              "Account has been Created. Please check your mail for verification"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/loginRoute/', (route) => false);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Okay"),
                                ))
                          ],
                        ),
                      );
                    },
                    child: const Text("Register"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/loginRoute/', (route) => false);
                      },
                      child: const Text('Already registered? Login here'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
