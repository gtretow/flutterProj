// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController(text: "");
  TextEditingController passwordController =
      new TextEditingController(text: "");
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Expanded(
                        flex: 5,
                        child: Image.network(
                          'https://e7.pngegg.com/pngimages/625/782/png-clipart-dio-logo-musician-others-miscellaneous-text.png',
                          height: 125,
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Já tem cadastro?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Faça seu login e make the change",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: TextField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(top: 0),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            hintText: "E-mail",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.deepPurple,
                            )),
                      )),
                  const SizedBox(height: 15),
                  Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: TextField(
                        obscureText: visibility,
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 0),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            hintText: "Senha",
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              child: Icon(
                                  visibility
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.deepPurple),
                            )),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (emailController.text.trim() != "" &&
                              passwordController.text.trim() != "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('login efetuado')));
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Erro ao logar')));
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepPurple)),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                          color: Colors.yellow, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
