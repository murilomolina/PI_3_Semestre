import 'package:flutter/material.dart';
import 'package:myapp/data/habilitacoes.dart';
import 'package:myapp/utils/drawers.dart';

class HabilitacoesForm extends StatefulWidget {
  const HabilitacoesForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabilitacoesFormState createState() => _HabilitacoesFormState();
}

class _HabilitacoesFormState extends State<HabilitacoesForm> {
  final _formKey = GlobalKey<FormState>();
  final _codigoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _textoWebController = TextEditingController();

  @override
  void dispose() {
    _codigoController.dispose();
    _descricaoController.dispose();
    _textoWebController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final novaHabilitacao = Habilitacao(
        codigoHabilitacao: _codigoController.text,
        descricao: _descricaoController.text,
        textoWeb: _textoWebController.text,
      );

      insereHabilitacao(novaHabilitacao).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Habilitação inserida com sucesso!')),
        );
        _formKey.currentState!.reset();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao inserir habilitação: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Inserir Habilitação'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _codigoController,
                decoration: const InputDecoration(labelText: 'Código Habilitação'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o código da habilitação';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _textoWebController,
                decoration: const InputDecoration(labelText: 'Texto Web'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o texto web';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Inserir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
