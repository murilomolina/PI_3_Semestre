import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class QueryExecutor extends StatefulWidget {
  const QueryExecutor({super.key});

  @override
  _QueryExecutorState createState() => _QueryExecutorState();
}

class _QueryExecutorState extends State<QueryExecutor> {
  late MySqlConnection _connection;
  List<Map<String, dynamic>> _queryResult = [];

  @override
  void initState() {
    super.initState();
    _connectToDatabase();
  }

  Future<void> _connectToDatabase() async {
    try {
      final settings = ConnectionSettings(
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        password: '',
        db: 'bdeurekamap',
      );

      _connection = await MySqlConnection.connect(settings);
      await _executeQuery();
    } catch (e) {
      print('Erro ao conectar ao banco de dados: $e');
    }
  }

  Future<void> _executeQuery() async {
    try {
      final results = await _connection.query('SELECT * FROM usuariosApp');
      setState(() {
        _queryResult = results.toList().cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Erro ao executar a consulta: $e');
    } finally {
      await _connection.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados da Consulta'),
      ),
      body: ListView.builder(
        itemCount: _queryResult.length,
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text('Usuarios Cadastrados:'),
          );
        },
      ),
    );
  }
}
