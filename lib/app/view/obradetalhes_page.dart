import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ObraDetalhesPage extends StatefulWidget {
  final String no;
  final String li;
  final String lo;
  final String des;

  const ObraDetalhesPage(
      {Key? key,
      required this.no,
      required this.li,
      required this.lo,
      required this.des})
      : super(key: key);

  @override
  _ObraDetalhesPageState createState() => _ObraDetalhesPageState();
}

class _ObraDetalhesPageState extends State<ObraDetalhesPage> {
  // ignore: unused_field
  Future<void>? _launched;

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Erro ao abrir o link: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 137, 66),
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 61, 50, 63),
        title: Text(
          widget.no,
          style: const TextStyle(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Container(
                  height: 145 * 2.2,
                  width: 90 * 2.2,
                  color: Colors.black,
                  child: Image.network(
                    widget.li,
                    fit: BoxFit.fill,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return splashObra(26);
                    },
                  )),
              const SizedBox(height: 30),
              divisoria("Descrição", 128.5),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.des,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    overflow: TextOverflow.visible,
                    color: Color.fromARGB(255, 61, 50, 63),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              divisoria("Link da Obra", 119),
              Text(
                widget.lo,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  color: Color.fromARGB(255, 61, 50, 63),
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
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
                onPressed: () => setState(() {
                  _launched = _launchInWebViewOrVC(widget.lo);
                }),
                child: const Text(
                  'Abrir Link',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color.fromARGB(255, 61, 50, 63),
                    overflow: TextOverflow.clip,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  divisoria(String titulo, double largura) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 2,
          width: largura,
          color: const Color.fromARGB(255, 61, 50, 63),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Text(
            titulo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 2,
          width: largura,
          color: const Color.fromARGB(255, 61, 50, 63),
        ),
      ],
    );
  }
}

Widget splashObra(double tamanho) {
  return Container(
    color: const Color.fromARGB(255, 185, 88, 53),
    child: Center(
        child: Text(
      "ALBRA",
      style: TextStyle(
        color: const Color.fromARGB(255, 61, 50, 63),
        fontSize: tamanho,
        fontWeight: FontWeight.bold,
      ),
    )),
  );
}
