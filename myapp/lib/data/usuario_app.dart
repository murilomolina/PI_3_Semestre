// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UsuarioApp {
  final id;
  final email;
  final senha;
  final admin;
  final dataCriacao;

  UsuarioApp({
    required this.id,
    required this.email,
    required this.senha,
    required this.admin,
    required this.dataCriacao,
  });
}

Future<List<UsuarioApp>> consultaUsuariosApp() async {
  List<UsuarioApp> usuarios = [];

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
    var res = await conn.execute("SELECT * FROM usuariosapp", {});
    for (final row in res.rows) {
      usuarios.add(UsuarioApp(
        id: row.colAt(0),
        email: row.colAt(1)  ,
        senha: row.colAt(2)  ,
        admin: row.colAt(3),
        dataCriacao: row.colAt(4)  ,
      ));
    }

    await conn.close();
  } catch (e) {
    "Erro ao conectar: ${e}";
  }

  return usuarios;
}

insereUsuarioApp(email, senha) async {
  if (email == '' && senha == '') return "Erro, campos não preenchidos";
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
    await conn.execute(
      "INSERT INTO usuariosapp (email, senha) VALUES ('$email', '$senha')");
    
    await conn.close();
    return '';
    } catch (e) {
    return "Erro ao conectar: $e";
  }
}