import 'package:flutter/material.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class DadosCadastrais extends StatefulWidget {
  const DadosCadastrais({super.key});

  @override
  State<DadosCadastrais> createState() => _DadosCadastraisState();
}

class _DadosCadastraisState extends State<DadosCadastrais> {
  var nameController = TextEditingController(text: "");
  var dateController = TextEditingController(text: "");
  var nivelRepository = NivelRepository();
  var liguagemRepository = LinguagensRepository();
  var nivelSelected = "";
  List<String> linguagensSelected = [];
  double salarySelected = 0;
  int experienceTime = 0;
  DateTime? birthDate;
  bool saving = false;

  AppStorageService storage = AppStorageService();

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
    nameController.text = await storage.getRegistrationDataName();
    dateController.text = await storage.getRegistrationBirthDate();
    if (dateController.text.isNotEmpty) {
      birthDate = DateTime.parse(dateController.text);
    }
    nivelSelected = await storage.getRegistrationExperienceLevel();
    linguagensSelected = await storage.getRegistrationLanguages();
    experienceTime = await storage.getRegistrationExperienceTime();
    salarySelected = await storage.getRegistrationSalary();
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
                  birthDate = data;
                }
              },
            ),
            returnText("Niveis de expêriencia"),
            Column(
                children: niveis
                    .map((nivel) => RadioListTile(
                        title: Text(nivel.toString()),
                        selected: nivelSelected == nivel,
                        value: nivel.toString(),
                        groupValue: nivelSelected,
                        onChanged: (value) {
                          setState(() {
                            nivelSelected = value.toString();
                          });
                        }))
                    .toList()),
            returnText("Tempo de Experiência"),
            DropdownButton(
                value: experienceTime,
                isExpanded: true,
                items: returnItens(50),
                onChanged: (value) {
                  setState(() {
                    experienceTime = int.parse(value.toString());
                  });
                }),
            returnText('Linguagens preferidas'),
            Column(
              children: linguagens
                  .map((e) => CheckboxListTile(
                      title: Text(e),
                      value: linguagensSelected.contains(e),
                      onChanged: (bool? value) {
                        if (value!) {
                          setState(() {
                            linguagensSelected.add(e);
                          });
                        } else {
                          setState(() {
                            linguagensSelected.remove(e);
                          });
                        }
                      }))
                  .toList(),
            ),
            returnText(
                "Pretenção Salarial. R\$ ${salarySelected.round().toString()} "),
            Slider(
                min: 0,
                max: 10000,
                value: salarySelected,
                onChanged: (double value) {
                  setState(() {
                    salarySelected = value;
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
                if (birthDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Data de nascimento inválida")));
                  return;
                }
                if (nivelSelected.trim() == '') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("O nível deve ser selecionado")));
                  return;
                }
                if (linguagensSelected.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Deve ser selecionado ao menos uma linguagem")));
                  return;
                }
                if (experienceTime == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Deve ter ao menos um ano de experiência em uma das linguagens")));
                  return;
                }
                if (salarySelected == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("A pretenção salarial deve ser maior que 0")));
                  return;
                }

                await storage.setRegistrationDataName(nameController.text);
                await storage.setRegistrationBirthDate(birthDate!);
                await storage.setRegistrationExperienceTime(experienceTime);
                await storage.setRegistrationLanguages(linguagensSelected);
                await storage.setRegistrationSalary(salarySelected);
                await storage.setRegistrationExperienceLevel(nivelSelected);

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
