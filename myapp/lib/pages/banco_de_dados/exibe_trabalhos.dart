import 'package:flutter/material.dart';
import 'package:myapp/data/trabalhos.dart';
import 'package:myapp/utils/drawers.dart';

class ExibeTrabalhos extends StatefulWidget {
  const ExibeTrabalhos({super.key});

  @override
  State<ExibeTrabalhos> createState() => _ExibeTrabalhosState();
}

class _ExibeTrabalhosState extends State<ExibeTrabalhos> {
  
  late Future<List<Trabalhos>> _trabalhosFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _trabalhosFuture = consultaTrabalhos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Trabalhos'),
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
          const Text("Clique no bloco do trabalho para editar"),
          Padding(padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar Usuario',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Atualiza o estado para refletir a mudança na busca
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Trabalhos>>(
              future: _trabalhosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum trabalho encontrado'));
                } else {
                  final trabalhos = snapshot.data!;
                  return ListView.builder(
                    itemCount: trabalhos.length,
                    itemBuilder: (context, index) {
                      final trabalho = trabalhos[index];
                      // Verifica se o nome do usuario contém o texto de busca
                      if (_searchController.text.isNotEmpty &&
                          !trabalho.titulo.toLowerCase().contains(_searchController.text.toLowerCase())) {
                        return SizedBox.shrink(); // Se não contiver, oculta o item da lista
                      }
                      return ListTile(
                        title: Text(trabalho.titulo),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(trabalho.resumo),
                            Text('Id Trabalho: ${trabalho.idTrabalho}'),
                            Text('Orientador: ${trabalho.orientador}'),
                            Text('Coorientador: ${trabalho.coorientador}'),
                            Text('Resumo: ${trabalho.resumo}'),
                            Text('Id Estande: ${trabalho.idEstande}'),
                          ],
                        ),
                         /*onTap: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditaTrabalhoPage(trabalho: trabalho),
                          ),
                        );
                        },*/
                        trailing: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Cor de fundo
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cor do texto
                            ),
                          onPressed: () {
                            caixaExclusao(context, trabalho);
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

  void caixaExclusao(BuildContext context, Trabalhos trabalho) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Excluir usuario'),
          content: Text('Deseja excluir o trabalho ${trabalho.titulo}?'),
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
                await deletaTrabalho(context, trabalho);
                // Atualiza a lista de trabalhos após a exclusão
                _trabalhosFuture = consultaTrabalhos();
                setState(() {}); // atualiza a tela
                // Exibe uma mensagem de sucesso
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Trabalho excluído com sucesso'),
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