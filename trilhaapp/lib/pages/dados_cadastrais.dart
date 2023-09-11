import 'package:flutter/material.dart';

class DadosCadastrais extends StatelessWidget {
  final String text;
  final List<String> data;
  const DadosCadastrais({super.key, required this.text, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: const Center(child: Text('Dados Cadastrais')),
    );
  }
}
