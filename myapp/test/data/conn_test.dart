import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConnTest {
  Future<void> testeCadastro() async {
    // Dado: Conexão com o banco feita com sucesso
    await dotenv.load(fileName: "lib/assets/.env");
    try {
      final conn = await MySQLConnection.createConnection(
        host: dotenv.get("HOST_BD"),
        port: int.parse(dotenv.get("PORT_BD")),
        userName: dotenv.get("USUARIO_BD"),
        password: dotenv.get("SENHA_BD"),
        databaseName: "bdeurekamap",
      );

      await conn.connect();

      await conn
          .execute("DELETE FROM usuarios WHERE email = 'teste@email.com'");

      // Quando: insiro as informações e confirmo
      String email = "teste@email.com";
      String senha = "123";

      await conn.execute(
          "INSERT INTO usuarios (email, senha) VALUES ('$email', '$senha')");

      // Então: deve mostrar uma mensagem de sucesso
      print("Cadastro OK");

      await conn.close();
    } catch (e) {
      print("Erro ao conectar: ${e}");
    }
  }

  Future<void> testeLogin() async {
    // Dado: Conexão com o banco feita com sucesso
    await dotenv.load(fileName: "lib/assets/.env");
    try {
      final conn = await MySQLConnection.createConnection(
        host: dotenv.get("HOST_BD"),
        port: int.parse(dotenv.get("PORT_BD")),
        userName: dotenv.get("USUARIO_BD"),
        password: dotenv.get("SENHA_BD"),
        databaseName: "bdeurekamap",
      );

      await conn.connect();

      var res = await conn.execute("SELECT * FROM usuarios", {});

      // Quando: insiro as informações e confirmo
      String email = "teste@email.com";
      String senha = "123";

      bool loginOK = false;
      for (final row in res.rows) {
        if (row.colAt(1) == email && row.colAt(2) == senha) {
          loginOK = true;
          break;
        }
      }

      // Então: deve mostrar uma mensagem de sucesso e fazer login
      if (!loginOK) {
        print("Falha no login");
      } else
        print("Login feito com sucesso");

      await conn.close();
    } catch (e) {
      print("Erro ao conectar: ${e}");
    }
  }
}

void main() async{
  test('ConnTest testeCadastro', () async {
    await ConnTest().testeCadastro();
  });

  test('ConnTest testeLogin', () async {
    await ConnTest().testeLogin();
  });
}
