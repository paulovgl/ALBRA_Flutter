import 'package:albra/app/service/auth_service.dart';
import 'package:albra/app/view/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthService())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ALBRA',
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
