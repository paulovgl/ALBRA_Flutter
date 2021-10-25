import 'package:albra/app/view/obrasleitor_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'leitorinicial_page.dart';

class LeitorHome extends StatefulWidget {
  const LeitorHome({Key? key}) : super(key: key);

  @override
  _LeitorHomeState createState() => _LeitorHomeState();
}

class _LeitorHomeState extends State<LeitorHome> {
  int paginaAtual = 1;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(index) {
    setState(() {
      paginaAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: const [
          ObrasLeitor(),
          LeitorInicialPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(255, 185, 88, 53),
        backgroundColor: const Color.fromARGB(255, 255, 137, 66),
        height: 55,
        index: paginaAtual,
        items: const <Widget>[
          Icon(
            Icons.book,
            size: 20,
            color: Color.fromARGB(255, 61, 50, 63),
          ),
          Icon(
            Icons.home,
            size: 20,
            color: Color.fromARGB(255, 61, 50, 63),
          ),
        ],
        animationDuration: const Duration(
          milliseconds: 400,
        ),
        onTap: (index) {
          debugPrint("Index atual: $index");
          pc.animateToPage(
            index,
            duration: const Duration(
              milliseconds: 400,
            ),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
