// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:jogodavelha/components/jogadores_model.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  List<String> quadrados = List.filled(9, '');
  String jogadorVez = "";
  bool vencedorencontrado = false;
  late JogadoresModel jogadores;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    jogadores = ModalRoute.of(context)!.settings.arguments as JogadoresModel;
    jogadorVez = jogadores.nomeJogadorX;
  }

  void atualizarQuadrado(int index) {
    if (vencedorencontrado) {
      showDialog<String>(
          context: context,
          builder: (context) =>
              alertDialog("Jogo Ja encerrado. Inície um Novo"));
    } else if (quadrados[index] == '') {
      setState(() {
        quadrados[index] = jogadorVez == jogadores.nomeJogadorO ? 'O' : 'X';
      });

      if (!validaVencedor()) {
        trocaJogador(); // Após atualizar o quadrado, troca o jogador
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Casa Ocupada. Escolha outra.")));
    }
  }

  void trocaJogador() {
    if (jogadorVez == jogadores.nomeJogadorX) {
      setState(() {
        jogadorVez = jogadores.nomeJogadorO;
      });
    } else if (jogadorVez == jogadores.nomeJogadorO) {
      setState(() {
        jogadorVez = jogadores.nomeJogadorX;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Jogador NENHUM")));
    }
  }

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

  bool validaVencedor() {
    // List<int>  casasVencedoras = [];

    // Verificar colunas
    for (int i = 0; i < 3; i++) {
      if (quadrados[i] != '' &&
          quadrados[i] == quadrados[i + 3] &&
          quadrados[i] == quadrados[i + 6]) {
        // O jogador atual venceu na coluna i
        vencedorencontrado = true;
        //  casasVencedoras = [i, i + 3, i + 6];
        break;
      }
    }

    // Verificar linhas
    for (int i = 0; i < 9; i += 3) {
      if (quadrados[i] != '' &&
          quadrados[i] == quadrados[i + 1] &&
          quadrados[i] == quadrados[i + 2]) {
        // O jogador atual venceu na linha i/3
        vencedorencontrado = true;
        //  casasVencedoras = [i, i + 1, i + 2];
        break;
      }
    }

    // Verificar diagonal principal
    if (quadrados[0] != '' &&
        quadrados[0] == quadrados[4] &&
        quadrados[0] == quadrados[8]) {
      // O jogador atual venceu na diagonal principal
      vencedorencontrado = true;
      //  casasVencedoras = [0, 4, 8];
    }

    // Verificar diagonal secundária
    if (quadrados[2] != '' &&
        quadrados[2] == quadrados[4] &&
        quadrados[2] == quadrados[6]) {
      // O jogador atual venceu na diagonal secundária
      vencedorencontrado = true;
      //  casasVencedoras = [2, 4, 6];
    }

    // Verificar se todas as casas estão preenchidas (empate)
    if (!quadrados.contains('')) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Deu velha!")));
    } else
    // Se houver um vencedor, marque as casas vencedoras com fundo verde
    if (vencedorencontrado) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$jogadorVez Venceu!")));
      showDialog<String>(
          context: context,
          builder: (context) => alertDialog("$jogadorVez Venceu!"));
    }
    return vencedorencontrado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Jogo da Velha"),
      ),
      body: Column(
        children: [
          Text(
            "Vez do $jogadorVez",
            style: const TextStyle(fontSize: 25),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: quadrados.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    atualizarQuadrado(
                        index); // Chama a função atualizarQuadrado
                  },
                  child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          quadrados[index],
                          style: const TextStyle(
                            fontSize: 34, // Tamanho da fonte desejado
                          ),
                        ),
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
