import 'package:flutter/material.dart';
import 'package:myapp/data/aluno.dart';
import 'package:myapp/pages/banco_de_dados.dart';
import 'package:myapp/pages/edita_bancada.dart';
import 'package:myapp/pages/pagina_inicial.dart';


class ExibeAluno extends StatelessWidget {
  const ExibeAluno({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Usuários EurekaMap'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), 
            onPressed: () {
              Navigator.of(context).pop(); // Fecha a tela atual
            },
          ),
          actions: [
            Builder(
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
          ],
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
      ),
      body: FutureBuilder<List<Aluno>>(
        future: consultaAluno(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum usuário encontrado'));
          } else {
            final alunos = snapshot.data!;
            return ListView.builder(
              itemCount: alunos.length,
              itemBuilder: (context, index) {
                final aluno = alunos[index];
                return ListTile(
                  title: Text(aluno.nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(aluno.email1),
                      Text(aluno.cpf),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
