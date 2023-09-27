// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfigPages extends StatefulWidget {
  const ConfigPages({Key? key}) : super(key: key);

  @override
  State<ConfigPages> createState() => _ConfigPagesState();
}

class _ConfigPagesState extends State<ConfigPages> {
  AppStorageService storage = AppStorageService();

  TextEditingController userNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String? userName;
  double? height;
  bool receiveNotifications = false;
  bool darkTheme = false;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    userNameController.text = await storage.getConfigUsername();
    heightController.text = (await (storage.getConfigHeight())).toString();
    receiveNotifications = await storage.getConfigReceiveNotification();
    darkTheme = await storage.getConfigDarkTheme();
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
                      receiveNotifications = value;
                    });
                  },
                  value: receiveNotifications,
                ),
                SwitchListTile(
                    title: const Text("Tema escuro"),
                    value: darkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        darkTheme = value;
                      });
                    }),
                TextButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        await storage.setConfigHeight(
                            double.parse(heightController.text));
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
                      await storage.setConfigUsername(userNameController.text);
                      await storage
                          .setConfigReceiveNotification(receiveNotifications);
                      await storage.setConfigDarkTheme(darkTheme);
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar"))
              ],
            )));
  }
}
