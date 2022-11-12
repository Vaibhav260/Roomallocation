import 'package:flutter/material.dart';
import 'package:myproject/Rooms/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [SwipeActionNavigatorObserver()],
      title: 'To do list',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    );
  }
}

