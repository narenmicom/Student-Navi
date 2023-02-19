import 'dart:developer';
import 'package:code/services/auth/supabase.dart';
import 'package:code/utilities/dialog/generic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final SupabaseAuthProvider _login;
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
    _login = SupabaseAuthProvider();
    await _login.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Please log in to your account in order to inter'),
            TextField(
              controller: _email,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  const InputDecoration(hintText: "Enter your E-mail here"),
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
            TextButton(
              onPressed: () async {
                try {
                  final email = _email.text;
                  final password = _password.text;
                  await _login.logIn(
                    email: email,
                    password: password,
                  );
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 200,
                  );
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/attendanceRoute/', (route) => false);
                } on AuthException catch (e) {
                  log(e.toString());
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Verify Email"),
                      content: const Text(
                          "Please check your mail for Account verification"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              child: const Text("Okay"),
                            ))
                      ],
                    ),
                  );
                }
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () async {
                await _login.sendPasswordReset(email: _email.text);
                LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white,
                  size: 200,
                );
                // ignore: use_build_context_synchronously
                showGenericDialog<void>(
                  context: context,
                  title: 'Forgot Password',
                  content:
                      'An Reset link for password has been send. Please Check your Email',
                  optionBuilder: () => {
                    'OK': null,
                  },
                );
              },
              child: const Text('Forgot Password'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/registerRoute/', (route) => false);
              },
              child: const Text('Not Register yet? Register here'),
            )
          ],
        ),
      ),
    );
  }
}
