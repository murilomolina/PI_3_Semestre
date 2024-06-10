import 'package:flutter/material.dart';
import 'package:myapp/pages/banco_de_dados.dart';
import 'package:myapp/pages/edita_bancada.dart';
import 'package:myapp/pages/pagina_inicial.dart';

Drawer drawerPaginaInicial(context) {
  return Drawer(
    // Definindo o Drawer com os botões adicionais
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Opções'),
        ),
        ListTile(
          title: const Text("Banco de Dados"),
          onTap: () {
            // Lógica para ação ao pressionar Opção 1
            Navigator.pop(context); // Fechar o menu
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BancoDeDados(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Editor de Mapa'),
          onTap: () {
            // Lógica para ação ao pressionar Opção 2
            Navigator.pop(context); // Fechar o menu
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const EditaBancada(), // atualmente apenas para motivos de exibição de rota, foi deixado como destino a página de banco de dados.
              ),
            );
          },
        ),
      ],
    ),
  );
}

Drawer drawerEditaBancada(context) {
  return Drawer(
    // Definindo o Drawer com os botões adicionais
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Opções'),
        ),
        ListTile(
          title: const Text('Banco de Dados'),
          onTap: () {
            // Lógica para ação ao pressionar Opção 1
            Navigator.pop(context); // Fechar o menu
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BancoDeDados(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Editor de Mapa'),
          onTap: () {
            // Lógica para ação ao pressionar Opção 2
            Navigator.pop(context); // Fechar o menu
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const EditaBancada(), // atualmente apenas para motivos de exibição de rota, foi deixado como destino a página de banco de dados.
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Tela Inicial'),
          onTap: () {
            // Lógica para ação ao pressionar Opção 2
            Navigator.pop(context); // Fechar o menu
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const PaginaInicial(), // atualmente apenas para motivos de exibição de rota, foi deixado como destino a página de banco de dados.
              ),
            );
          },
        ),
      ],
    ),
  );
}

Drawer drawerBancoDeDados(context) {
  return Drawer(
    // Definindo o Drawer com os botões adicionais
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Opções'),
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
          title: const Text('Editor de Mapa'),
          onTap: () {
            // Lógica para ação ao pressionar Opção 2
            Navigator.pop(context); // Fechar o menu
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const EditaBancada(), // atualmente apenas para motivos de exibição de rota, foi deixado como destino a página de banco de dados.
              ),
            );
          },
        ),
      ],
    ),
  );
}
Drawer drawerPaginasBancoDeDados(context){
  return Drawer(
        // Definindo o Drawer com os botões adicionais
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Opções'),
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
              title: const Text('Editor de Mapa'),
              onTap: () {
                // Lógica para ação ao pressionar Opção 2
                Navigator.pop(context); // Fechar o menu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const EditaBancada(), // atualmente apenas para motivos de exibição de rota, foi deixado como destino a página de banco de dados.
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Banco de Dados'),
              onTap: () {
                // Lógica para ação ao pressionar Opção 3
                Navigator.pop(context); // Fechar o menu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BancoDeDados(),
                  ),
                );
              },
            ),
          ],
        ),
      );
}