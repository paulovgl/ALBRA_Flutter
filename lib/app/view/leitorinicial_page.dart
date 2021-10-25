import 'package:albra/app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LeitorInicialPage extends StatefulWidget {
  const LeitorInicialPage({Key? key}) : super(key: key);

  @override
  State<LeitorInicialPage> createState() => _LeitorInicialPageState();
}

class _LeitorInicialPageState extends State<LeitorInicialPage> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    setState(() {
      auth;
    });

    auth.fetchNome();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 137, 66),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Color.fromARGB(255, 61, 50, 63),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 0,
                child: Center(
                  child: Text(
                    "Sair",
                    style: TextStyle(
                      color: Color.fromARGB(255, 61, 50, 63),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const PopupMenuItem(
                value: 1,
                child: Center(
                  child: Text(
                    "Configurações",
                    style: TextStyle(
                      color: Color.fromARGB(255, 61, 50, 63),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
            onSelected: (result) {
              if (result == 0) {
                sair();
              } else if (result == 1) {}
            },
          ),
        ],
        title: const Text(
          "ALBRA",
          style: TextStyle(
            color: Color.fromARGB(255, 61, 50, 63),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 185, 88, 53),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bem vindo ${auth.getNome()}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  sair() {
    context.read<AuthService>().logout();
  }
}
