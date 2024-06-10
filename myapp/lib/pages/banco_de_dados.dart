import 'package:flutter/material.dart';
import 'package:myapp/pages/banco_de_dados/exibe_alunos.dart';
import 'package:myapp/pages/banco_de_dados/insere_aluno.dart';
import 'package:myapp/pages/banco_de_dados/lista_usuarios_page.dart';
import 'package:myapp/utils/drawers.dart';

class BancoDeDados extends StatelessWidget {
  const BancoDeDados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Banco de Dados'),
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
        drawer: drawerBancoDeDados(context),
        body: SingleChildScrollView(
          // mudei para esse modo afim de deixar toda a página scrollavel
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListView(
                  // tambem foi alterado o widget (column) afim de tornar mais eficiente a exibição dos widgets e mais "limpo" e não dar erro de overflow.
                  shrinkWrap: true,
                  children: [
                    ElevatedButton(
                      // Botão posicionado no topo apenas por motivos de testes e exibição de como ele ira funcionar
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExibeAluno(),
                          ),
                        );
                      },
                      child: const Text('Alunos cadastrados'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InsereAluno(),
                          ),
                        );
                      },
                      child: const Text(
                          'Inserir aluno'),
                    ),
                     const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      // Botão posicionado no topo apenas por motivos de testes e exibição de como ele ira funcionar
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListaUsuariosPage(),
                          ),
                        );
                      },
                      child: const Text(
                          'Usuários do EurekaMap'),
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
