import 'package:flutter/material.dart';
import 'package:myapp/data/usuario_app.dart';
import 'package:myapp/utils/drawers.dart';

bool isAdmin(admin) {
  if (admin == 1 || admin == "1") {
    return true;
  } else {
    return false;
  }
}

class ListaUsuariosPage extends StatefulWidget {
  const ListaUsuariosPage({super.key});
    @override
   // ignore: library_private_types_in_public_api
   _ListaUsuariosPageState createState() => _ListaUsuariosPageState();
}
class _ListaUsuariosPageState extends State<ListaUsuariosPage> {
  late Future<List<UsuarioApp>> _usuariosAppFuture;
  final TextEditingController _searchController = TextEditingController();

@override
  void initState() {
    super.initState();
    _usuariosAppFuture = consultaUsuariosApp();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Usuários do EurekaMap'),
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
            child: FutureBuilder<List<UsuarioApp>>(
              future: _usuariosAppFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum usuário encontrado'));
                } else {
                  final usuarios = snapshot.data!;
                  return ListView.builder(
                    itemCount: usuarios.length,
                    itemBuilder: (context, index) {
                      final usuario = usuarios[index];
                      // Verifica se o nome do usuario contém o texto de busca
                      if (_searchController.text.isNotEmpty &&
                          !usuario.email.toLowerCase().contains(_searchController.text.toLowerCase())) {
                        return SizedBox.shrink(); // Se não contiver, oculta o item da lista
                      }
                      return ListTile(
                        title: Text(usuario.email),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(isAdmin(usuario.admin) == true ? 'Administrador' : 'Usuário'),
                            Text(
                                'Data de Criação: ${usuario.dataCriacao.toString()}'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Cor de fundo
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cor do texto
                            ),
                          onPressed: () {
                            caixaExclusao(context, usuario);
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

  void caixaExclusao(BuildContext context, UsuarioApp usuarioApp) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Excluir usuario'),
          content: Text('Deseja excluir o usuario ${usuarioApp.email}?'),
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
                await deletaUsuarioApp(context, usuarioApp);
                // Atualiza a lista de usuarioApps após a exclusão
                _usuariosAppFuture = consultaUsuariosApp();
                setState(() {}); // atualiza a tela
                // Exibe uma mensagem de sucesso
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Usuário excluído com sucesso'),
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
