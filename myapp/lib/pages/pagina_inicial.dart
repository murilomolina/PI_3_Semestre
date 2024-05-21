import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/pages/banco_de_dados.dart';
import 'package:myapp/pages/edita_bancada.dart';
import 'package:myapp/pages/tela_login.dart';
import 'package:myapp/widgets/cria_grid.dart';
import 'package:myapp/widgets/desenha_grid.dart';
import 'package:widget_zoom/widget_zoom.dart';


List<int> coordenadas = [];

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final inputUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                title: const Text('Banco de Dados'),
                onTap: () {
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
                  Navigator.pop(context); // Fechar o menu
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditaBancada(), 
                          ),
                        );
                },
              ),
              ListTile( 
                title: const Text('Tela Login'),
                onTap: () {
                  Navigator.pop(context); // Fechar o menu
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TelaLogin(), // atualmente apenas para motivos de exibição do layout da tela de login.
                          ),
                        );
                },
              ),
            ],
          ),
        ),
        body:  SingleChildScrollView(
          // mudei para esse modo afim de deixar toda a página scrollavel
          child: Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // ignore: prefer_const_constructors
                WidgetZoom(
                  heroAnimationTag: 'tag',
                  zoomWidget:
                      // ignore: prefer_const_constructors
                      SizedBox(
                    // o vs sugere que deixe essa caixa como uma const, porem se deixar o grid nunca se altera (deixando de fazer sua unica função)
                    height: 400,
                    child: DesenhaGrid(),
                  ),
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
      ),
    );
  }
}
