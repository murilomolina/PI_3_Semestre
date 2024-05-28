import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_test/flutter_test.dart';

class ConnTest {
  Future<void> testeSelect() async {
    try {
      print("Conectando ao banco de dados");

      final conn = await MySQLConnection.createConnection(
        host: "127.0.0.1",
        port: 3306,
        userName: "root",
        password: "",
        databaseName: "bdeurekamap",
      );

      await conn.connect();

      print("Conectado com sucesso");

      var res = await conn.execute("SELECT * FROM usuarios");

      for (final row in res.rows) {
        print(row.assoc());
      }

      print("Fechando conexão");
      await conn.close();
    } catch (e) {
      print("Erro ao conectar: ${e}");
    }
  }
}

void main() {
  test('ConnTest testeSelect', () async {
    await ConnTest().testeSelect();
  });
}
