import 'package:flutter/material.dart';
import 'package:trilhaapp/model/register/register_data_model.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/repositories/register_data_repository.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  late RegisterDataRepo registerDataRepo;
  var registerDataModel = RegisterDataModel.empty();
  var nameController = TextEditingController(text: "");
  var dateController = TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var liguagemRepository = LinguagensRepository();
  bool saving = false;

  var niveis = [];
  var linguagens = [];

  @override
  void initState() {
    niveis = (nivelRepository.retornaNiveis());
    linguagens = (liguagemRepository.returnLinguagens());
    super.initState();
    loadData();
  }

  loadData() async {
    registerDataRepo = await RegisterDataRepo.load();
    registerDataModel = registerDataRepo.getData();

    nameController.text = registerDataModel.name!;
    dateController.text = registerDataModel.birthDate.toString();
    if (dateController.text.isNotEmpty) {
      registerDataModel.birthDate = DateTime.parse(dateController.text);
    }
  }

  List<DropdownMenuItem<int>> returnItens(int maxQuantity) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i < maxQuantity; i++) {
      itens.add(DropdownMenuItem(value: i, child: Text(i.toString())));
    }
    return itens;
  }

  returnText(String texto) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Text(texto,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Dados"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: ListView(
          children: [
            returnText("Nome"),
            TextField(
              controller: nameController,
            ),
            returnText("Data de Nascimento"),
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: () async {
                var data = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1900, 1, 1),
                    lastDate: DateTime(2023, 10, 23));

                if (data != null) {
                  dateController.text = data.toString();
                  registerDataModel.birthDate = data;
                }
              },
            ),
            returnText("Niveis de expêriencia"),
            Column(
                children: niveis
                    .map((nivel) => RadioListTile(
                        title: Text(nivel.toString()),
                        selected: registerDataModel.experienceLevel == nivel,
                        value: nivel.toString(),
                        groupValue: registerDataModel.experienceLevel,
                        onChanged: (value) {
                          setState(() {
                            registerDataModel.experienceLevel =
                                value.toString();
                          });
                        }))
                    .toList()),
            returnText("Tempo de Experiência"),
            DropdownButton(
                value: registerDataModel.experienceTime,
                isExpanded: true,
                items: returnItens(50),
                onChanged: (value) {
                  setState(() {
                    registerDataModel.experienceTime =
                        int.parse(value.toString());
                  });
                }),
            returnText('Linguagens preferidas'),
            Column(
              children: linguagens
                  .map((e) => CheckboxListTile(
                      title: Text(e),
                      value: registerDataModel.linguages.contains(e),
                      onChanged: (bool? value) {
                        if (value!) {
                          setState(() {
                            registerDataModel.linguages.add(e);
                          });
                        } else {
                          setState(() {
                            registerDataModel.linguages.remove(e);
                          });
                        }
                      }))
                  .toList(),
            ),
            returnText(
                "Pretenção Salarial. R\$ ${registerDataModel.salary?.round().toString()} "),
            Slider(
                min: 0,
                max: 10000,
                value: registerDataModel.salary ?? 0,
                onChanged: (double value) {
                  setState(() {
                    registerDataModel.salary = value;
                  });
                }),
            TextButton(
              onPressed: () async {
                setState(() {
                  saving = false;
                });
                if (nameController.text.trim().length < 3) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("O nome deve ser preenchido")));
                  return;
                }
                if (registerDataModel.birthDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Data de nascimento inválida")));
                  return;
                }
                if (registerDataModel.experienceLevel?.trim() == '') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("O nível deve ser selecionado")));
                  return;
                }
                if (registerDataModel.linguages.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Deve ser selecionado ao menos uma linguagem")));
                  return;
                }
                if (registerDataModel.experienceTime == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Deve ter ao menos um ano de experiência em uma das linguagens")));
                  return;
                }
                if (registerDataModel.salary == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("A pretenção salarial deve ser maior que 0")));
                  return;
                }
                registerDataModel.name = nameController.text;
                registerDataRepo.save(registerDataModel);

                setState(() {
                  saving = true;
                });
                Future.delayed(const Duration(seconds: 3), () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Dados salvo com sucesso")));
                  setState(() {
                    saving = false;
                  });
                  Navigator.pop(context);
                });
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
