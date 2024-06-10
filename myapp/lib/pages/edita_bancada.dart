import 'package:flutter/material.dart';
import 'package:myapp/utils/drawers.dart';
import 'package:myapp/widgets/cria_grid.dart';


List<int> coordenadas = [];

class EditaBancada extends StatefulWidget {
  const EditaBancada({super.key});

  @override
  State<EditaBancada> createState() => _EditaBancadaState();
}

class _EditaBancadaState extends State<EditaBancada> {
  final inputUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Editor de Bancadas'),
          // Adicionando o ícone de hambúrguer no AppBar
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu), // Ícone de hambúrguer
                onPressed: () {
                  // Ao ser pressionado, abre o menu lateral
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          backgroundColor: Colors.blue[600],
        ),
        drawer: drawerEditaBancada(context),
        body: SingleChildScrollView(
          // mudei para esse modo afim de deixar toda a página scrollavel
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ignore: prefer_const_constructors
                SizedBox(
                  // o vs sugere que deixe essa caixa como uma const, porem se deixar o grid nunca se altera (deixando de fazer sua unica função)
                  height: 400,
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
                      if (inputUsuario.text != "") {
                        // Mudar o tratamento quando adicionar a busca por ra nome trabalho, etc
                        coordenadas = inputUsuario.text
                            .split(',')
                            .map<int>((e) => int.tryParse(e) ?? 0)
                            .toList();
                      } else {
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
