import 'package:flutter/material.dart';
import 'package:myapp/data/consultas_grid.dart';
import 'package:myapp/utils/drawers.dart';
import 'package:myapp/widgets/cria_grid.dart';
import 'package:myapp/widgets/desenha_grid.dart';
import 'dart:math';


//funçao usando regex pra otimizar o input do usuarioa
String limpaString(String input) {
  // Remove espaços no final da string
  input = input.replaceAll(RegExp(r'\s+$'), '');

  // Reduz espaços consecutivos a um único espaço
  input = input.replaceAll(RegExp(r'\s\s+'), ' ');

  return input;
}

List<int> coordenadas = [];
// deixei global a fim de quando for utilizar no grid ficar de facil acesso (fica ao critério seu (vini) quando for arrumar o grid)
List<Sugestoes> sugestoes = [];
var resumo = "";
var titulo = "";
var idEstande; // por algum motivo não é possivel definir como int, eu acho que seja por causa do tipo que está armazenado no banco de dados
var idAluno ;
var idTrabalho;

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final inputUsuario = TextEditingController();
  // int nBusca = -1; // controlador de buscas


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Tela Inicial'),
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
        drawer: drawerPaginaInicial(context),
        body:  SingleChildScrollView(
          // mudei para esse modo afim de deixar toda a página scrollavel
          child: Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Cria o botao para inserir coordenadas
                TextField(
                  controller: inputUsuario,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Insira o local desejado",
                  ),
                ),
                MaterialButton(
                onPressed: () async {
                  // nBusca++;
                  inputUsuario.text = limpaString(inputUsuario.text);
                  sugestoes = await buscaTrabalhoNoBanco(inputUsuario.text);
                  if (inputUsuario.text != "") {
                    if (sugestoes.isNotEmpty) {
                        resumo = sugestoes[0].resumo;
                        idEstande = sugestoes[0].idEstande;
                        idTrabalho = sugestoes[0].idTrabalho;
                        idAluno = sugestoes[0].idAluno;
                        titulo = sugestoes[0].titulo;
                        print("resumo: $resumo");
                        print("idestande: $idEstande");
                        print("idtrabalho: $idTrabalho");
                        print("idaluno: $idAluno");
                        print("titulo: $titulo");

                    } else {
                      print("Sem sugestões encontradas");
                    }
                  } else {
                    print("Nenhuma entrada de texto fornecida");
                  }
                  CriaGrid();
                },
                color: Colors.blue,
                child: const Text(
                  "Enviar",
                  style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  // o vs sugere que deixe essa caixa como uma const, porem se deixar o grid nunca se altera (deixando de fazer sua unica função)
                  height: 800,
                  child: Stack(
                    children: [
                      DesenhaGrid(),
                      Positioned(
                        top: 55,
                        left: 110,
                        child: Text("Arquibancada", style: TextStyle(color: Colors.purple[900], fontSize: 20, fontWeight: FontWeight.bold),)
                      ),
                      Positioned(
                        top: 250,
                        left: 0,
                        child: Transform.rotate(angle: 90 * pi / 180, child: const Text("Corredor 1", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),)
                      ),
                      Positioned(
                        top: 550,
                        left: 0,
                        child: Transform.rotate(angle: 90 * pi / 180, child: const Text("Corredor 1", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),)
                      ),
                      Positioned(
                        top: 250,
                        left: 65,
                        child: Transform.rotate(angle: 90 * pi / 180, child: const Text("Corredor 2", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),)
                      ),
                      Positioned(
                        top: 550,
                        left: 65,
                        child: Transform.rotate(angle: 90 * pi / 180, child: const Text("Corredor 2", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),)
                      ),
                      Positioned(
                        top: 250,
                        left: 143,
                        child: Transform.rotate(angle: 90 * pi / 180, child: const Text("Corredor 3", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),)
                      ),
                      Positioned(
                        top: 550,
                        left: 143,
                        child: Transform.rotate(angle: 90 * pi / 180, child: const Text("Corredor 3", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),)
                      ),
                      Positioned(
                        top: 250,
                        left: 207,
                        child: Transform.rotate(angle: 90 * pi / 180, child: const Text("Corredor 4", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),)
                      ),
                      Positioned(
                        top: 550,
                        left: 207,
                        child: Transform.rotate(angle: 90 * pi / 180, child: const Text("Corredor 4", style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),),)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
