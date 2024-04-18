import 'package:flutter/material.dart';
import 'package:myapp/data/data_populator.dart';

class UserInsertScreen extends StatefulWidget {
  const UserInsertScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserInsertScreenState createState() => _UserInsertScreenState();
}

class _UserInsertScreenState extends State<UserInsertScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _email1Controller = TextEditingController();
  final TextEditingController _email2Controller = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _serieController = TextEditingController();
  final TextEditingController _periodoController = TextEditingController();
  final TextEditingController _idHabilitacaoController = TextEditingController();
  final TextEditingController _registroController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _idUserLoginController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserir Usuário'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: _email1Controller,
                decoration: const InputDecoration(labelText: 'Email 1'),
              ),
              TextField(
                controller: _email2Controller,
                decoration: const InputDecoration(labelText: 'Email 2'),
              ),
              TextField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              TextField(
                controller: _celularController,
                decoration: const InputDecoration(labelText: 'Celular'),
              ),
              TextField(
                controller: _serieController,
                decoration: const InputDecoration(labelText: 'Série'),
              ),
              TextField(
                controller: _periodoController,
                decoration: const InputDecoration(labelText: 'Período'),
              ),
              TextField(
                controller: _idHabilitacaoController,
                decoration: const InputDecoration(labelText: 'ID de Habilitação'),
              ),
              TextField(
                controller: _registroController,
                decoration: const InputDecoration(labelText: 'Registro'),
              ),
              TextField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              TextField(
                controller: _idUserLoginController,
                decoration: const InputDecoration(labelText: 'ID de Usuário de Login'),
              ),
              TextField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
              ),
              TextField(
                controller: _profileController,
                decoration: const InputDecoration(labelText: 'Profile'),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton( // tinha colocado como MaterialButton, para seguir o padrão, porem o elevated é mais bonito
                    onPressed: () {
                      _confirmInsertion(context);
                    },
                    child: const Text('Confirmar Inserção'),
                    
                  ),
                  ElevatedButton( // tinha colocado como MaterialButton, para seguir o padrão, porem o elevated é mais bonito
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    
                    child: const Text('Cancelar', 
                      style: TextStyle(color: Colors.black),),
                    
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _confirmInsertion(BuildContext context) {
    // Verifique se todos os campos obrigatórios estão preenchidos
    if (_nomeController.text.isNotEmpty &&
        _email1Controller.text.isNotEmpty &&
        _email2Controller.text.isNotEmpty) {
      // Se todos os campos estão preenchidos, exiba um diálogo de confirmação
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmar Inserção'),
            content: const Text('Deseja realmente inserir este usuário?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar',
                  style: TextStyle(color: Colors.red),),
              ),
              ElevatedButton( // tinha colocado como MaterialButton, para seguir o padrão, porem o elevated é mais bonito
                onPressed: () {
                  _insertUser();
                  Navigator.of(context).pop();
                },
                child: const Text('Confirmar'),
              ),
            ],
          );
        },
      );
    } else {
      // Se algum campo obrigatório estiver vazio, exiba um snackbar de erro
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos obrigatórios.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  void _insertUser() {
    DataPopulator.insertUsuarioFromUserInput(
    nome: _nomeController.text,
    email1: _email1Controller.text,
    email2: _email2Controller.text,
    telefone: _telefoneController.text,
    celular: _celularController.text,
    serie: int.tryParse(_serieController.text),
    periodo: _periodoController.text,
    idHabilitacao: int.tryParse(_idHabilitacaoController.text),
    registro: _registroController.text,
    senha: _senhaController.text,
    idUserLogin: int.tryParse(_idUserLoginController.text),
    cpf: _cpfController.text,
    profile: _profileController.text,
    );

  }
}