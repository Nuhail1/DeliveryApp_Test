import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/providers/loginProvider.dart';
import 'src/providers/orderProvider.dart';
import 'src/screens/loginScreen.dart';
import 'src/screens/orderScreen.dart';
import 'src/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: AppConstants.themeSwatch,
            primaryColor: AppConstants.themeColor,
            scaffoldBackgroundColor: AppConstants.backgroundColor),
        home: mainPage(),
      ),
    );
  }

  mainPage() {
    return FutureBuilder<bool>(
        future: isAlreadyLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return snapshot.data! ? OrderScreen() : LoginScreen();
            } else {
              return const Scaffold(body: CircularProgressIndicator());
            }
          } else {
            return const Scaffold(body: CircularProgressIndicator());
          }
        });
  }

  Future<bool> isAlreadyLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;
    return loggedIn;
  }
}
