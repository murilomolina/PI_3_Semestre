import 'package:flutter/material.dart';
import 'package:myapp/cria_grid.dart';

List<int> coordenadas = [];

class Busca extends StatefulWidget {
  const Busca({super.key});

  @override
  State<Busca> createState() => _BuscaState();
}

class _BuscaState extends State<Busca> {
  final inputUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Grid Display'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ignore: prefer_const_constructors
              Expanded(
                // ignore: prefer_const_constructors
                child: CriaGrid(),
              ),
              TextField(
                controller: inputUsuario,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Insira o local desejado",
                ),
              ),
              // Cria o botao para inserir coordenadas
              MaterialButton(
                onPressed: () => {
                  setState(() {
                    if(inputUsuario.text != ""){
                      // Mudar o tratamento quando adicionar a busca por ra nome trabalho, etc
                      coordenadas = inputUsuario.text.split(',').map(int.parse).toList();
                    }
                    else{
                      // Reseta as coordenadas para limpar o grid caso o usuario envie uma mensagem vazia, mudar para um botao de "limpar caminho no futuro"
                      coordenadas = [];
                    }
                  }),
                  // Cria a grid novamente
                  // ignore: prefer_const_constructors
                  CriaGrid(),
                },
                color: Colors.blue,
                child: const Text(
                  "Enviar",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}