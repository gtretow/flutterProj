// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trilhaapp/model/model.dart';
import 'package:trilhaapp/repositories/configs_repository.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfigPages extends StatefulWidget {
  const ConfigPages({Key? key}) : super(key: key);

  @override
  State<ConfigPages> createState() => _ConfigPagesState();
}

class _ConfigPagesState extends State<ConfigPages> {
  late ConfigRepository configRepository;
  ConfigModel configModel = ConfigModel.empty();

  TextEditingController userNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configRepository = await ConfigRepository.load();
    configModel = configRepository.getData();

    userNameController.text = configModel.username;
    heightController.text = (configModel.height).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Configurações")),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Nome usuário"),
                    controller: userNameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "height"),
                    controller: heightController,
                  ),
                ),
                SwitchListTile(
                  title: const Text("Receber notificações"),
                  onChanged: (bool value) {
                    setState(() {
                      configModel.receiveNotification = value;
                    });
                  },
                  value: configModel.receiveNotification,
                ),
                SwitchListTile(
                    title: const Text("Tema escuro"),
                    value: configModel.darkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        configModel.darkTheme = value;
                      });
                    }),
                TextButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        configModel.height =
                            double.parse(heightController.text);
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text("Meu App"),
                                content: const Text(
                                    "Favor informar uma height válida!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Ok"))
                                ],
                              );
                            });
                        return;
                      }
                      configModel.username = userNameController.text;
                      configRepository.save(configModel);
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar"))
              ],
            )));
  }
}
