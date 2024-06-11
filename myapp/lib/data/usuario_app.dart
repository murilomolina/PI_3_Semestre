import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UsuarioApp {
  final int? id;  // Considerando que o ID pode ser gerado automaticamente pelo banco
  final String email;
  final String senha;
  final bool admin;
  final DateTime dataCriacao;

  UsuarioApp({
    this.id,  // ID não é necessário na criação, dependendo se é autoincrement no banco
    required this.email,
    required this.senha,
    required this.admin,
    required this.dataCriacao,
  });
}

  Future<MySQLConnection> _getConnection() async {
    await dotenv.load(fileName: "lib/assets/.env");
    return await MySQLConnection.createConnection(
      host: dotenv.get("HOST_BD"),
      port: int.parse(dotenv.get("PORT_BD")),
      userName: dotenv.get("USUARIO_BD"),
      password: dotenv.get("SENHA_BD"),
      databaseName: "bdeurekamap",
    );
  }

  Future<List<UsuarioApp>> consultaUsuariosApp() async {
    List<UsuarioApp> usuarios = [];
    var conn = await _getConnection();
    await conn.connect();
    var res = await conn.execute("SELECT * FROM usuariosapp");
    for (final row in res.rows) {
      usuarios.add(UsuarioApp(
        id: row.colAt(0) as int,
        email: row.colAt(1) as String,
        senha: row.colAt(2) as String,
        admin: row.colAt(3) == 1,
        dataCriacao: DateTime.parse(row.colAt(4) as String),
      ));
    }

    await conn.close();
    return usuarios;
  } 

Future<bool> cadastraUsuarioApp(UsuarioApp novoUsuario) async {
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

    // Verifica se o email já está em uso
    var verificaEmail = await conn.execute(
      "SELECT email FROM usuariosapp WHERE email = :email", {'email': novoUsuario.email}
    );
    if (verificaEmail.rows.isNotEmpty) {
      print("Erro: Email já está em uso.");
      await conn.close();
      return false;
    }

    // Insere o novo usuário
    await conn.execute(
      "INSERT INTO usuariosapp (email, senha, admin, dataCriacao) VALUES (:email, :senha, :admin, :dataCriacao)",
      {
        'email': novoUsuario.email,
        'senha': novoUsuario.senha,
        'admin': novoUsuario.admin ? 1 : 0,
        'dataCriacao': novoUsuario.dataCriacao.toIso8601String()
      }    
    );

    print("Usuário cadastrado com sucesso.");
    await conn.close();
    return true;
  } catch (e) {
    print("Erro ao conectar ou executar query: ${e}");
    return false;
  }
}
