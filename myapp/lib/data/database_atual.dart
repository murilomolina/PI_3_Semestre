import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAtual extends StatefulWidget {
  const DatabaseAtual({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DatabaseAtualState createState() => _DatabaseAtualState();
}

class _DatabaseAtualState extends State<DatabaseAtual> {
  List<Map<String, dynamic>>? _databaseContent;

  @override
  void initState() {
    super.initState();
    _loadDatabaseContent();
  }

  Future<void> _loadDatabaseContent() async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'usuarios.db'),
      );
      final List<Map<String, dynamic>> content =
          await db.rawQuery('SELECT * FROM usuarios');
      setState(() {
        _databaseContent = content;
      });
    } catch (e) {
      print('Erro ao carregar o conteúdo do banco de dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conteúdo do Banco de Dados'),
      ),
      body: _databaseContent == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _databaseContent!.isEmpty
              ? const Center(
                  child: Text('O banco de dados está vazio.'),
                )
              : ListView.builder(
                  itemCount: _databaseContent!.length,
                  itemBuilder: (context, index) {
                    final row = _databaseContent![index];
                    return ListTile(
                      title: Text('ID: ${row['idUsuario']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nome: ${row['nome']}'),
                          Text('Email 1: ${row['email1'] ?? ''}'),
                          Text('Email 2: ${row['email2'] ?? ''}'),
                          Text('Telefone: ${row['telefone'] ?? ''}'),
                          Text('Celular: ${row['celular'] ?? ''}'),
                          Text('Foto: ${row['foto'] ?? 'fotos/semfoto.jpg'}'),
                          Text('Série: ${row['serie'] ?? ''}'),
                          Text('Período: ${row['periodo'] ?? ''}'),
                          Text(
                              'ID de Habilitação: ${row['idHabilitacao'] ?? ''}'),
                          Text('Registro: ${row['registro'] ?? ''}'),
                          Text('Primeira Vez: ${row['primeiraVez'] ?? ''}'),
                          Text('Ativo: ${row['ativo'] ?? ''}'),
                          Text('Senha: ${row['senha'] ?? ''}'),
                          Text(
                              'Participação Anterior: ${row['participacaoAnterior'] ?? ''}'),
                          Text(
                              'ID de Usuário de Login: ${row['id_user_login'] ?? ''}'),
                          Text('Pesquisa: ${row['pesquisa'] ?? ''}'),
                          Text(
                              'Data de Pesquisa: ${row['data_pesquisa'] ?? ''}'),
                          Text('CPF: ${row['cpf'] ?? ''}'),
                          Text('Profile: ${row['profile'] ?? ''}'),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
