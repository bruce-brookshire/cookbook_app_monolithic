
import 'package:cookbook/tools.dart';
import 'package:flutter/material.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

class SignupView extends StatefulWidget {
  @override
  State createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool canSignup = false;

  TextEditingController firstNameController,
      lastNameController,
      emailController,
      passwordController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  bool signupAvailable() => ![
        firstNameController.text,
        lastNameController.text,
        emailController.text,
        passwordController.text
      ].any((field) => field.trim() == "");

  void textChanged(_) {
    final newVal = signupAvailable();
    if (newVal != canSignup) setState(() => canSignup = newVal);
  }

  void tappedSignup(_) {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    User.createUser(firstName, lastName, email, password).then(
      (value) {
        Navigator.popUntil(context, (route) => route.isFirst);
        DartNotificationCenter.post(
          channel: "AppState",
          options: AppState.main,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => NavView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: "First Name"),
                      onChanged: textChanged,
                      controller: firstNameController,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: "Last Name"),
                      onChanged: textChanged,
                      controller: lastNameController,
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(hintText: "Email"),
                onChanged: textChanged,
                controller: emailController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Password"),
                onChanged: textChanged,
                controller: passwordController,
              ),
              GestureDetector(
                onTapUp: canSignup ? tappedSignup : null,
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: canSignup ? Colors.blue : Colors.grey,
                  ),
                  child: Text(
                    'Signup',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
