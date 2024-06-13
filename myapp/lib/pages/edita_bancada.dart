import 'package:flutter/material.dart';
import 'package:myapp/utils/drawers.dart';
import 'package:myapp/widgets/cria_grid.dart';
import 'dart:math';

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
               SizedBox(
                  // o vs sugere que deixe essa caixa como uma const, porem se deixar o grid nunca se altera (deixando de fazer sua unica função)
                  height: 800,
                  child: Stack(
                    children: [
                      CriaGrid(),
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
