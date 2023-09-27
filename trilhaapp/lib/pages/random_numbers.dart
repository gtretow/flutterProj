// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RandomNumbers extends StatefulWidget {
  const RandomNumbers({super.key});

  @override
  State<RandomNumbers> createState() => _RandomNumbersState();
}

class _RandomNumbersState extends State<RandomNumbers> {
  int? numeroGerado = 0;
  int? quantidadeDeCliques = 0;
  late Box storage;

  final random_number_key = "random_number";
  final number_of_clicks = "number_clicks";
  //late SharedPreferences storage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    if (Hive.isBoxOpen('box_random_numbers')) {
      storage = Hive.box('box_random_numbers');
    } else {
      storage = await Hive.openBox('box_random_numbers');
    }
    // storage = await SharedPreferences.getInstance();
    numeroGerado = storage.get('generatedNumber') ?? 0;
    quantidadeDeCliques = storage.get('numberOfClicks') ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gerador de Números"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Numero gerado: ${numeroGerado == null ? "" : numeroGerado.toString()}",
                style: const TextStyle(fontSize: 22),
              ),
              Text(
                "Quantidade de clicks: ${quantidadeDeCliques == null ? "" : quantidadeDeCliques.toString()}",
                style: const TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              var random = Random();
              setState(() {
                numeroGerado = random.nextInt(1000);
                quantidadeDeCliques = (quantidadeDeCliques ?? 0) + 1;
              });
              storage.put('generatedNumber', numeroGerado);
              storage.put('numberOfClicks', quantidadeDeCliques);
            }),
      ),
    );
  }
}
