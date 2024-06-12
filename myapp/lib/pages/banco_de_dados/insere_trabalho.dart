import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/data/trabalhos.dart';
import 'package:myapp/utils/drawers.dart';

class InsereTrabalho extends StatelessWidget {
  final _tituloController = TextEditingController();
  final _orientadorController = TextEditingController();
  final _coorientadorController = TextEditingController();
  final _resumoController = TextEditingController();
  final _idEstandeController = TextEditingController();

  InsereTrabalho({super.key});
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Inserir Trabalho'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextFormField(
              controller: _orientadorController,
              decoration: const InputDecoration(labelText: 'Orientador (numero inteiro)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextFormField(
              controller: _coorientadorController,
              decoration: const InputDecoration(labelText: 'Coorientador (numero inteiro)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextFormField(
              controller: _resumoController,
              decoration: const InputDecoration(labelText: 'Resumo'),
            ),
            TextFormField(
              controller: _idEstandeController,
              decoration: const InputDecoration(labelText: 'Id Estande'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  insereTrabalho(
                  _tituloController.text,
                  int.parse(_orientadorController.text),
                  int.parse(_coorientadorController.text),
                  _resumoController.text,
                  int.parse(_idEstandeController.text)
                );
                showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text("Trabalho inserido com sucesso!"),
                    );
                  },
                );
                } catch (e) {
                  showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Erro ao tentar inserir trabalho $e"),
                    );
                  },
                );
                }
              },
              child: const Text('Inserir'),
            ),
          ],
        ),
      ),
    );
  }
}