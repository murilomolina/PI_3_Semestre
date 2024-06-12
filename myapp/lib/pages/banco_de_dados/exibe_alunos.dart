import 'package:flutter/material.dart';
import 'package:myapp/data/aluno.dart';
import 'package:myapp/utils/drawers.dart';

class ExibeAluno extends StatefulWidget {
  const ExibeAluno({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExibeAlunoState createState() => _ExibeAlunoState();
}

class _ExibeAlunoState extends State<ExibeAluno> {
  late Future<List<Aluno>> _alunosFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _alunosFuture = consultaAluno();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alunos'),
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
      drawer: drawerPaginasBancoDeDados(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar aluno',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Atualiza o estado para refletir a mudança na busca
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Aluno>>(
              future: _alunosFuture,
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
                      // Verifica se o nome do aluno contém o texto de busca
                      if (_searchController.text.isNotEmpty &&
                          !aluno.nome.toLowerCase().contains(_searchController.text.toLowerCase())) {
                        return SizedBox.shrink(); // Se não contiver, oculta o item da lista
                      }
                      return ListTile(
                        title: Text(aluno.nome),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(aluno.email1),
                            Text(aluno.cpf),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Cor de fundo
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cor do texto
                            ),
                          onPressed: () {
                            caixaExclusao(context, aluno);
                          },
                          child: Text('Excluir'),
                          
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

void caixaExclusao(BuildContext context, Aluno aluno) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Excluir Aluno'),
          content: Text('Deseja excluir o aluno ${aluno.nome}?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text('Excluir'),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await deletaAluno(context, aluno);
                // Atualiza a lista de alunos após a exclusão
                _alunosFuture = consultaAluno();
                setState(() {}); // atualiza a tela
                // Exibe uma mensagem de sucesso
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Aluno excluído com sucesso'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}