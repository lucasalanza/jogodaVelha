import 'package:flutter/material.dart';
import 'package:jogodavelha/components/input_field.dart';
import 'package:jogodavelha/components/jogadores_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final jogador1 = TextEditingController();
  final jogador2 = TextEditingController();

  Widget alertDialog(texto) {
    return AlertDialog(
      title: const Text("Atenção"),
      content: Text(texto),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Jogo da Velha"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Bem-vindo! Informe os nomes dos jogadores:",
                style: TextStyle(fontSize: 20),
              ),
              InputField(
                label: "Jogador 1 (X)",
                controller: jogador1,
              ),
              InputField(
                label: "Jogador 2 (O)",
                controller: jogador2,
                obscureText: false,
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  child: const Text("Jogar"),
                  onPressed: () {
                    var jog1 = jogador1.text;
                    var jog2 = jogador2.text;

                    if (jog1 == "" || jog2 == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("informe o nome")));

                      showDialog<String>(
                          context: context,
                          builder: (context) =>
                              alertDialog("Informe o nome dos 2 jogadores"));
                    } else {
                      Navigator.pushNamed(context, "/jogo",
                          arguments: JogadoresModel(
                              nomeJogadorX: "$jog1 (X)",
                              nomeJogadorO: "$jog2 (O)"));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
