import 'package:flutter/material.dart';
import 'package:jogodavelha/components/jogadores_model.dart';
import 'package:jogodavelha/jogo.dart';
import 'package:jogodavelha/home.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  JogadoresModel jog = JogadoresModel(nomeJogadorX: '', nomeJogadorO: '');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/jogo": (context) => const Jogo(),
      },
    );
  }
}
