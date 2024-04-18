import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/widgets/cria_grid.dart';
import 'package:myapp/data/database_atual.dart';
import 'package:myapp/data/user_insert_screen.dart';

List<int> coordenadas = [];

class Busca extends StatefulWidget {
  const Busca({super.key});

  @override
  State<Busca> createState() => _BuscaState();
}

class _BuscaState extends State<Busca> {
  final inputUsuario = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tela Inicial'), // mudei pois tudo se inicia aqui (se for manter essa tela como a inicial, lembrar de mudar o nome da classe e do arquivo)
        ),
        body: SingleChildScrollView( // mudei para esse modo afim de deixar toda a página scrollavel
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ListView( // tambem foi alterado o widget (column) afim de tornar mais eficiente a exibição dos widgets e mais "limpo" e não dar erro de overflow.
                  shrinkWrap: true,
                  children: [
                    ElevatedButton( // Botão posicionado no topo apenas por motivos de testes e exibição de como ele ira funcionar
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
                    const SizedBox(height: 10.0,), // espaçamento entre os botões
                    ElevatedButton( // Botão posicionado no topo apenas por motivos de testes e exibição de como ele ira funcionar
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
                    const SizedBox(height: 20.0), // só para dar um espaço entre o ultimo botão e o grid
                    // defini um espaço fixo, porem ainda não é a melhor solução

                    // ignore: prefer_const_constructors
                    SizedBox( // o vs sugere que deixe essa caixa como uma const, porem se deixar o grid nunca se altera (deixando de fazer sua unica função)
                      height: 400, 
                      child: CriaGrid(),
                    ),
                  ],
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
