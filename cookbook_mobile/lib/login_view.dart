import 'package:cookbook/main.dart';
import 'package:cookbook/new_entry_view.dart';
import 'package:cookbook/signup_view.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tools.dart';

class LoginView extends StatefulWidget {
  @override
  State createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailFieldController;
  TextEditingController passwordFieldController;

  @override
  void initState() {
    super.initState();

    emailFieldController = TextEditingController();
    passwordFieldController = TextEditingController();
  }

  @override
  void dispose() {
    emailFieldController.dispose();
    passwordFieldController.dispose();

    super.dispose();
  }

  void tappedLogin(_) async {
    final email = emailFieldController.text.trim();
    final password = passwordFieldController.text.trim();

    try {
      await Auth.login(email, password);

      DartNotificationCenter.post(channel: "AppState", options: AppState.main);
    } catch (e) {
      print("failed");
    }
  }

  void tappedSignup(_) async {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => SignupView()));
  }

  @override
  Widget build(BuildContext context) {
    return NavView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Cookbook App",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Email"),
                controller: emailFieldController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Password"),
                controller: passwordFieldController,
              ),
              GestureDetector(
                onTapUp: tappedLogin,
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: tappedSignup,
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                  child: Text(
                    'Need to sign up?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
