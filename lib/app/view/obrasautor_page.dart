import 'package:albra/app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';
import 'obradetalhes_page.dart';

class ObrasAutor extends StatefulWidget {
  const ObrasAutor({Key? key}) : super(key: key);

  @override
  _ObrasAutorState createState() => _ObrasAutorState();
}

class _ObrasAutorState extends State<ObrasAutor> {
  @override
  Widget build(BuildContext context) {
    String usuId = context.read<AuthService>().usuario!.uid.toString();

    Future<void> deleteObra(String obraId) {
      return FirebaseFirestore.instance
          .collection("Autor_Obras")
          .doc(usuId)
          .collection("Obras")
          .doc(obraId)
          .delete()
          .then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                "Obra Removida",
                textAlign: TextAlign.center,
              ))))
          .catchError((error) =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                "Erro ao Remover a Obra, Tente Novamente",
                textAlign: TextAlign.center,
              ))));
    }

    Future<void> deleteObraLeitor(String obraNo) {
      return FirebaseFirestore.instance
          .collection("Obras_Gerais")
          .doc(obraNo)
          .delete()
          // ignore: avoid_print
          .then((value) => print("Obra Removida"))
          // ignore: avoid_print
          .catchError((error) => print("Failed to delete user: $error"));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 137, 66),
      appBar: AppBar(
        title: const Text(
          "Obras Cadastradas",
          style: TextStyle(
            color: Color.fromARGB(255, 61, 50, 63),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 185, 88, 53),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Autor_Obras")
            .doc(usuId)
            .collection("Obras")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 255, 137, 66),
              body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Titulo(),
                      const SizedBox(height: 5),
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 185, 88, 53)),
                      ),
                    ]),
              ),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return GestureDetector(
                  child: SizedBox(
                    height: 145,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: const Color.fromARGB(255, 238, 205, 134),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: SizedBox(
                              height: 30 * 1.3,
                              width: 30 * 1.3,
                              child: PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 0,
                                    child: Center(
                                      child: Text(
                                        "Deletar",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 61, 50, 63),
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                onSelected: (result) {
                                  if (result == 0) {
                                    String obraId = document.reference.id;
                                    String obraNo = document["no"];
                                    deleteObra(obraId);
                                    deleteObraLeitor(obraNo);
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: 145,
                              width: 90,
                              color: Colors.black,
                              child: Image.network(
                                document['li'],
                                fit: BoxFit.fill,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return splashObra(26);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, right: 5.0, left: 100),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 145,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      document['no'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 31.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          document['des'],
                                          textAlign: TextAlign.justify,
                                          maxLines: 6,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () => obraDetalhes(document["no"], document["li"],
                      document["lo"], document["des"]),
                );
              }).toList(),
              padding: const EdgeInsets.all(5),
            );
          }
        },
      ),
    );
  }

  obraDetalhes(String nome, String link, String linkO, String des) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                ObraDetalhesPage(no: nome, li: link, lo: linkO, des: des)));
  }
}
