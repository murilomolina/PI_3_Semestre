import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_test/flutter_test.dart';

class ConnTest {
  Future<void> testeInsert() async {
    try {
      print("Conectando ao banco de dados");

      final conn = await MySQLConnection.createConnection(
        host: "127.0.0.1",
        port: 3306,
        userName: "root",
        password: "goodpassword",
        databaseName: "bdeurekamap",
      );

      await conn.connect();

      print("Conectado com sucesso");

      var res = await conn.execute("DELETE FROM usuarios");
      res = await conn.execute(
          "INSERT INTO usuarios (email, senha) VALUES ('teste@email.com', '123')");

      print("Insert OK");

      print("Fechando conexão");
      await conn.close();
    } catch (e) {
      print("Erro ao conectar: ${e}");
    }
  }

  Future<void> testeSelect() async {
    try {
      print("Conectando ao banco de dados");

      final conn = await MySQLConnection.createConnection(
        host: "127.0.0.1",
        port: 3306,
        userName: "root",
        password: "goodpassword",
        databaseName: "bdeurekamap",
      );

      await conn.connect();

      print("Conectado com sucesso");

      var res = await conn.execute("SELECT * FROM usuarios", {});

      bool emailEncontrado = false;
      for (final row in res.rows) {
        if (row.colAt(1) == 'teste@email.com') {
          emailEncontrado = true;
          break;
        }
      }

      if (!emailEncontrado) {
        print("Email teste@email.com não encontrado.");
      } else
        print("Email teste@email.com encontrado.");

      print("Fechando conexão");
      await conn.close();
    } catch (e) {
      print("Erro ao conectar: ${e}");
    }
  }
}

void main() {
  test('ConnTest testeInsert', () async {
    await ConnTest().testeInsert();
  });

  test('ConnTest testeSelect', () async {
    await ConnTest().testeSelect();
  });
}
