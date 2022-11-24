import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/new_shift_screen.dart';
import 'screens/open_shift_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/');
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const MyHomePage());
      case '/openShift':
        return MaterialPageRoute(
            builder: (context) => const OpenShiftListScreen());
      case '/newShift':
        return MaterialPageRoute(builder: (context) => const NewShiftScreen());
      default:
        return MaterialPageRoute(builder: (context) => const MyHomePage());
    }
  }
}
