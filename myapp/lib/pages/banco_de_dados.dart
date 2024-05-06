import 'package:flutter/material.dart';
import 'package:myapp/data/database_atual.dart';
import 'package:myapp/data/user_insert_screen.dart';
import 'package:myapp/pages/pagina_inicial.dart';

class BancoDeDados extends StatelessWidget {
  const BancoDeDados({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        drawer: Drawer(
          // Definindo o Drawer com os botões adicionais
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                    'Opções'),
              ),
              ListTile(
                title: const Text('Página inicial'),
                onTap: () {
                  // Lógica para ação ao pressionar Opção 1
                  Navigator.pop(context); // Fechar o menu
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaginaInicial(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Mapa'), // atualmente ainda está na página inicial
                onTap: () {
                  // Lógica para ação
                  Navigator.pop(context); // fecha o menu
                },
              ),
            ],
          ),
        ),
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
                            builder: (context) => const UserInsertScreen(),
                          ),
                        );
                      },
                      child: const Text('Pressione para inserir usuário'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ), // espaçamento entre os botões
                    ElevatedButton(
                      // Botão posicionado no topo apenas por motivos de testes e exibição de como ele ira funcionar
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DatabaseAtual(),
                          ),
                        );
                      },
                      child: const Text(
                          'Pressione para visualizar o estado atual do banco de dados'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
