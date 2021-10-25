import 'package:albra/app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String tipoUsu = "";
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  final nome = TextEditingController();
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    loginScreen() {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 137, 66),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 137, 66),
          shadowColor: const Color.fromARGB(0, 255, 137, 66),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 61, 50, 63)),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Titulo(),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 61, 50, 63),
                          ),
                          decoration: const InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Informe o email corretamente!";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: senha,
                          keyboardType: TextInputType.number,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          obscureText: true,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 61, 50, 63)),
                          decoration: const InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Informe a senha";
                            } else if (value.length < 6) {
                              return "A senha deve conter no mínimo 6 caracteres";
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        EsqueceuASenha(),
                        const Padding(padding: EdgeInsets.only(bottom: 50)),
                        ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                              width: 280, height: 60),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 185, 88, 53),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                entrar();
                              }
                            },
                            child: const Text(
                              "Entrar",
                              style: TextStyle(
                                color: Color.fromARGB(255, 61, 50, 63),
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  const Divider(color: Color.fromARGB(255, 61, 50, 63)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  const Text(
                    "Ainda não tem uma conta?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 185, 88, 53),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 280, height: 60),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 219, 105, 64),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        isLogin = false;
                        setState(() {
                          isLogin;
                        });
                      },
                      child: const Text(
                        "Cadastre-se",
                        style: TextStyle(
                          color: Color.fromARGB(255, 61, 50, 63),
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    registroScreen() {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 137, 66),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 137, 66),
          shadowColor: const Color.fromARGB(0, 255, 137, 66),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 61, 50, 63)),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      "ALBRA",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 61, 50, 63),
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: nome,
                          keyboardType: TextInputType.name,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 61, 50, 63),
                          ),
                          decoration: const InputDecoration(
                            labelText: "Nome",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Informe o nome";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 61, 50, 63),
                          ),
                          decoration: const InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Informe o email corretamente!";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: senha,
                          keyboardType: TextInputType.number,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          obscureText: true,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 61, 50, 63)),
                          decoration: const InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 185, 88, 53),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Informe a senha";
                            } else if (value.length < 6) {
                              return "A senha deve conter no mínimo 6 caracteres";
                            }
                            return null;
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 20)),
                        const Text(
                          "Escolha o tipo de usuário:",
                          style: TextStyle(
                              color: Color.fromARGB(255, 185, 88, 53),
                              fontSize: 18),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints.tightFor(
                                  width: 150, height: 60),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 219, 105, 64),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  tipoUsu = "Autor";
                                  setState(() {
                                    tipoUsu;
                                  });
                                },
                                child: const Text(
                                  "Autor",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 61, 50, 63),
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15)),
                            ConstrainedBox(
                              constraints: const BoxConstraints.tightFor(
                                  width: 150, height: 60),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 219, 105, 64),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  tipoUsu = "Leitor";
                                  setState(() {
                                    tipoUsu;
                                  });
                                },
                                child: const Text(
                                  "Leitor",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 61, 50, 63),
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 50)),
                        ConstrainedBox(
                          constraints: const BoxConstraints.tightFor(
                              width: 280, height: 60),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 185, 88, 53),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (tipoUsu.isNotEmpty) {
                                  cadastro();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Informe o Tipo de Usuário",
                                              textAlign: TextAlign.center)));
                                }
                              }
                            },
                            child: const Text(
                              "Cadastrar",
                              style: TextStyle(
                                color: Color.fromARGB(255, 61, 50, 63),
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 20)),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  const Divider(color: Color.fromARGB(255, 61, 50, 63)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  const Text(
                    "Já possui uma conta?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 185, 88, 53),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 280, height: 60),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 219, 105, 64),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        isLogin = true;
                        setState(() {
                          isLogin;
                        });
                      },
                      child: const Text(
                        "Entrar",
                        style: TextStyle(
                          color: Color.fromARGB(255, 61, 50, 63),
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (isLogin) {
      return loginScreen();
    } else {
      return registroScreen();
    }
  }

  entrar() async {
    try {
      await context.read<AuthService>().entrar(email.text, senha.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.message,
        textAlign: TextAlign.center,
      )));
    }
  }

  cadastro() async {
    try {
      await context
          .read<AuthService>()
          .registrar(email.text, senha.text, nome.text, tipoUsu);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.message,
        textAlign: TextAlign.center,
      )));
    }
  }
}

// ================================================================ Widgets:

// ignore: non_constant_identifier_names
Widget Titulo() {
  return const Padding(
    padding: EdgeInsets.only(bottom: 50),
    child: Text(
      "ALBRA",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(255, 61, 50, 63),
        fontSize: 42,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget EsqueceuASenha() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      GestureDetector(
        onTap: () {},
        child: const Text(
          "Esqueceu a senha?",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color.fromARGB(255, 185, 88, 53),
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}
