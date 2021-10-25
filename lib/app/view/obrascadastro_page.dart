import 'package:albra/app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObrasCadastro extends StatefulWidget {
  const ObrasCadastro({Key? key}) : super(key: key);

  @override
  _ObrasCadastroState createState() => _ObrasCadastroState();
}

class _ObrasCadastroState extends State<ObrasCadastro> {
  String iDefault =
      "https://ceab.com.br/wp-content/uploads/2017/02/bg-orange.jpg";
  bool isFull = false;
  final formKey = GlobalKey<FormState>();
  final liKey = GlobalKey<FormState>();
  final no = TextEditingController();
  final lo = TextEditingController();
  final li = TextEditingController();
  final des = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference obrasG =
        FirebaseFirestore.instance.collection('Obras_Gerais');

    String usuId = context.read<AuthService>().usuario!.uid.toString();

    Future<void> obraAdd() {
      return obrasG
          .doc(no.text)
          .set({
            'no': no.text.toString(),
            'lo': lo.text.toString(),
            'li': li.text.toString(),
            'des': des.text.toString(),
          })
          // ignore: avoid_print
          .then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                "Obra Cadastrada",
                textAlign: TextAlign.center,
              ))))
          // ignore: avoid_print
          .catchError((error) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                "Erro ao Cadastrar a Obra. Tente Novamente",
                textAlign: TextAlign.center,
              ))));
    }

    Future<void> autorObraAdd() {
      return FirebaseFirestore.instance
          .collection("Autor_Obras")
          .doc(usuId)
          .collection("Obras")
          .add({
            'no': no.text.toString(),
            'lo': lo.text.toString(),
            'li': li.text.toString(),
            'des': des.text.toString(),
          })
          // ignore: avoid_print
          .then((value) => print("Obra Adiconada"))
          // ignore: avoid_print
          .catchError((error) => print("Erro em adicionar a obra: $error"));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 137, 66),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 61, 50, 63)),
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
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Container(
                  height: 215,
                  width: 160,
                  color: const Color.fromARGB(255, 61, 50, 63),
                  child: Image.network(
                    iDefault,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 219, 105, 64))),
                  onPressed: () {
                    if (isFull) {
                      iDefault = li.text.toString();
                      setState(() {
                        iDefault;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        "Informe o Link da Imagem antes de carregar a imagem",
                        textAlign: TextAlign.center,
                      )));
                    }
                  },
                  child: const Text(
                    "Carregar Imagem",
                    style: TextStyle(
                      color: Color.fromARGB(255, 61, 50, 63),
                      fontSize: 16,
                    ),
                  )),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(color: Color.fromARGB(255, 61, 50, 63)),
              ),
              const SizedBox(height: 10),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: no,
                          keyboardType: TextInputType.name,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 61, 50, 63),
                          ),
                          decoration: const InputDecoration(
                            hintText: "Nome da Obra",
                            hintStyle: TextStyle(
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
                              return "Informe o Nome da Obra";
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: lo,
                          keyboardType: TextInputType.url,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 61, 50, 63),
                          ),
                          decoration: const InputDecoration(
                            hintText: "Link da Obra",
                            hintStyle: TextStyle(
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
                              return "Informe o Link da Obra";
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          key: liKey,
                          controller: li,
                          keyboardType: TextInputType.url,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 61, 50, 63),
                          ),
                          decoration: const InputDecoration(
                            hintText: "Link da Imagem",
                            hintStyle: TextStyle(
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
                          onChanged: (value) {
                            isFull = true;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Informe o Link da Imagem";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: des,
                          maxLines: 12,
                          keyboardType: TextInputType.text,
                          cursorColor: const Color.fromARGB(255, 185, 88, 53),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 61, 50, 63),
                          ),
                          decoration: const InputDecoration(
                            hintText: "Descrição da Obra",
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 185, 88, 53),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 185, 88, 53)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 185, 88, 53)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 185, 88, 53)),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Informe a Descrição da Obra";
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
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
                              obraAdd();
                              autorObraAdd();
                              isFull = false;
                              setState(() {
                                isFull;
                                no;
                                lo;
                                li;
                                des;
                              });
                            }
                          },
                          child: const Text(
                            "Cadastrar Obra",
                            style: TextStyle(
                              color: Color.fromARGB(255, 61, 50, 63),
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            width: 200, height: 60),
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
                            no.clear();
                            li.clear();
                            lo.clear();
                            des.clear();
                            iDefault =
                                "https://ceab.com.br/wp-content/uploads/2017/02/bg-orange.jpg";
                            setState(() {
                              iDefault;
                              no;
                              li;
                              lo;
                              des;
                            });
                          },
                          child: const Text(
                            "Limpar Campos",
                            style: TextStyle(
                              color: Color.fromARGB(255, 61, 50, 63),
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
