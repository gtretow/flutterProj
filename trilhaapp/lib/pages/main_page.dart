import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/dados_cadastrais.dart';
import 'package:trilhaapp/pages/pagina1.dart';
import 'package:trilhaapp/pages/pagina2.dart';
import 'package:trilhaapp/pages/pagina3.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);
  int pagePosition = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Main Page"),
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: const Text("Dados Cadastrais")),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DadosCadastrais(
                                  text: 'filho',
                                  data: ['dados1', 'dados2'],
                                )));
                  },
                ),
                const Divider(),
                const SizedBox(height: 20),
                const Text("Configurações"),
                const Divider(),
                const SizedBox(height: 20),
                const Text("Sair")
              ],
            ),
          ),
        ),
        body: Expanded(
          child: PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                pagePosition = value;
              });
            },
            //scrollDirection: Axis.vertical,
            children: const [Page1(), Page2(), Page3()],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              controller.jumpToPage(value);
            },
            currentIndex: pagePosition,
            items: const [
              BottomNavigationBarItem(label: "Pag1", icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: "Pag2", icon: Icon(Icons.add)),
              BottomNavigationBarItem(
                  label: "Pag3", icon: Icon(Icons.exit_to_app))
            ]),
      ),
    );
  }
}
