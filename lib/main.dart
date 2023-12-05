import 'package:blog_it/models/user.dart';
import 'package:blog_it/services/auth.dart';
import 'package:blog_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


import 'home/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return StreamProvider<User_?>.value(
      initialData: null,
      value: AuthService().user,
      catchError: (_, err) => null,
      // ignore: prefer_const_constructors
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
          );
        },
      ),
    );
  }
}
