import 'package:flutter/material.dart';

export './models/api.dart';


enum AppState { auth, main }

class NavView extends StatelessWidget {
  final Widget child;

  NavView({this.child});


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}

