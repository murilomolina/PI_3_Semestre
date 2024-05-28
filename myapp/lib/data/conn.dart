import 'dart:async';
import 'package:mysql_client/mysql_client.dart';

Future conn() async {
  try {
    print('Conectando ao banco de dados...');
    final pool = MySQLConnectionPool(
      host: '10.0.2.2',
      port: 3306,
      userName: 'root',
      password: '',
      maxConnections: 10,
      databaseName: '', // optional,
    );

    var result = await pool.execute("select * from usuariosapp");
    for (final row in result.rows) {
      print(row.assoc());
    }

    pool.close();
  } catch (e) {
    print("Erro ao conectar");
  }
}