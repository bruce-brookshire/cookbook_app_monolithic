import 'package:cookbook/login_view.dart';
import 'package:cookbook/new_entry_view.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State createState() => _MainAppState();
}

enum AppState { auth, main }

class _MainAppState extends State<MainApp> {
  AppState _appState;

  @override
  void initState() {
    super.initState();

    _appState = AppState.auth;

    DartNotificationCenter.subscribe(
      channel: "AppState",
      observer: this,
      onNotification: (state) => setState(() => _appState = state),
    );
  }

  @override
  void dispose() {
    super.dispose();

    DartNotificationCenter.unsubscribe(observer: this);
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget;

    if (_appState == AppState.auth) 
      currentWidget = LoginView();
    else 
      currentWidget = MyHomePage(title: "Cookbook");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: currentWidget,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTapUp: (_) => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => NewEntryView(),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: Text(
                  'New Recipe',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
