import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'obradetalhes_page.dart';

class ObrasLeitor extends StatefulWidget {
  const ObrasLeitor({Key? key}) : super(key: key);

  @override
  _ObrasLeitorState createState() => _ObrasLeitorState();
}

class _ObrasLeitorState extends State<ObrasLeitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 137, 66),
      appBar: AppBar(
        title: const Text(
          "Obras Gerais",
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
          stream:
              FirebaseFirestore.instance.collection("Obras_Gerais").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return splashObra(26);
                                    },
                                  )),
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
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(document['des'],
                                              textAlign: TextAlign.justify,
                                              maxLines: 6,
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 16,
                                              )),
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
          }),
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
