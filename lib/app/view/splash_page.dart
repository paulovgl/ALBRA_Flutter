import 'package:albra/app/service/auth_service.dart';
import 'package:albra/app/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homeautor_page.dart';
import 'homeleitor_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    setState(() {
      auth;
    });

    if (auth.isLoading) {
      return Loading();
    } else if (auth.usuario == null) {
      return LoadingCall();
    } else {
      auth.choice();
      return (auth.isAutor) ? const AutorHome() : const LeitorHome();
    }
  }

  // ignore: non_constant_identifier_names
  LoadingCall() {
    return const LoginPage();
  }

  // ignore: non_constant_identifier_names
  Loading() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 137, 66),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Titulo(),
          const SizedBox(height: 5),
          const CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 185, 88, 53)),
          ),
        ]),
      ),
    );
  }
}
