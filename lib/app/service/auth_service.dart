import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message = "";
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;
  bool isAutor = true;
  String userType = "";
  String nome = "";

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  _isLeitor() {
    isAutor = false;
    notifyListeners();
  }

  _isAutor() {
    isAutor = true;
    notifyListeners();
  }

  _setNome(String n) {
    nome = n;
    notifyListeners();
  }

  String getNome() {
    return nome;
  }

  _addUsu(String email, String nome, String tipoUsu) {
    String uid = usuario!.uid;

    CollectionReference usu = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(uid)
        .collection("Info");

    Map<String, String> usuarios = {
      'nome': nome,
      'perfil': tipoUsu,
      'email': email,
    };

    Future<void> usuAdd() {
      return usu
          .add(usuarios)
          // ignore: avoid_print
          .then((value) => print("Usuario Cadastrado"))
          // ignore: avoid_print
          .catchError((erro) => print("Erro ao Cadastrar: $erro"));
    }

    usuAdd();
  }

  fetchNome() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(usuario!.uid)
        .collection("Info")
        .get();

    for (var doc in snapshot.docs) {
      String n = doc["nome"];
      _setNome(n);
    }
  }

  choice() {
    String uid = usuario!.uid;

    FirebaseFirestore.instance
        .collection("Usuarios")
        .doc(uid)
        .collection("Info")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        userType = doc['perfil'];
      }
      if (userType == "Leitor") {
        _isLeitor();
      } else {
        _isAutor();
      }
    });
  }

  registrar(String email, String senha, String nome, String tipoUsu) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
      _addUsu(email, nome, tipoUsu);
    } on FirebaseAuthException catch (e) {
      if (e.code == "week-password") {
        throw AuthException("A senha é muito fraca!");
      } else if (e.code == "email-already-in-use") {
        throw AuthException("Este email já está cadastrado!");
      }
    }
  }

  entrar(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw AuthException("Email não encontrado. Cadastre-se");
      } else if (e.code == "wrong-password") {
        throw AuthException("Senha incorreta, tente novamente");
      } else {
        throw AuthException("Erro no Login");
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
