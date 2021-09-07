import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/screens/chatmenuscreen.dart';
import 'package:flutter_projects/screens/welcomescreen.dart';
import 'package:flutter_projects/services/sharedPreference.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   bool isUserLoggedIn=false ;

  getLoggedInState()async{
    await SharedPreferenceFunctions.getUserLoggedIn().then((value){
      setState(() {
        isUserLoggedIn=value;
      });
    });
  }
  @override
  void initState() {
    super.initState();
    getLoggedInState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff303952),
      ),
      home: isUserLoggedIn? ChatMenu() : Welcome(),
    );
  }
}
