import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/tab_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                  icon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "Password",
                  icon: Icon(Icons.password_outlined),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  signIn();
                },
                label: const Text(
                  "Sign In",
                ),
                icon: const Icon(Icons.login_outlined),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  signUp();
                },
                icon: const Icon(Icons.add_circle_outline_outlined),
                label: const Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() {
    if (_formKey.currentState!.validate()) {
      try {
        auth
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .catchError((e) {
          log('errror $e');
        }).whenComplete(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(
                  content: Text("Logged In Successfully"),
                ),
              )
              .closed
              .whenComplete(
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const TabPage(title: 'Flutter Demo Home Page'),
                  ),
                ),
              );
        });
      } catch (e) {
        log('message $e');
      }
    }
  }

  void signUp() {
    if (_formKey.currentState!.validate()) {
      auth
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .whenComplete(
            () => ScaffoldMessenger.of(context)
                .showSnackBar(
                  const SnackBar(
                    content: Text("Successfully Signed Up"),
                  ),
                )
                .closed
                .whenComplete(
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TabPage(title: "Home"),
                    ),
                  ),
                ),
          );
    }
  }
}
