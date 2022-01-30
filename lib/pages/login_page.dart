import 'package:flutter/material.dart';
import 'package:smolapp/model/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void _completeLogin() async {
    await Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      _completeLogin();
    }
    return Scaffold(
      body: Form(
        key: _key,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameController,
                  validator: validateEmail,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: validatePassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Sign up'),
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          await auth.createUserWithEmailAndPassword(
                            email: _usernameController.text,
                            password: _passwordController.text,
                          );
                          setState(() {});
                        }
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Sign In'),
                      onPressed: () async {
                        await auth.signInWithEmailAndPassword(
                            email: _usernameController.text,
                            password: _passwordController.text);
                        setState(() {});
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'E-mail address is required';
  }

  String pattern = r'\w+@\w+\.\w';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Addres format.';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required';
  }

  String pattern = r'^().{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword)) {
    return 'Password must contain at least 8 characters.';
  }

  return null;
}
