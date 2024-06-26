import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Aluno {
  final idUsuario;
  final nome;
  final email1;
  final cpf;

  Aluno({
    required this.idUsuario ,
    required this.nome,
    required this.email1,
    required this.cpf,
  });
}

Future<List<Aluno>> consultaAluno() async {
  List<Aluno> alunos = [];

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
    var res = await conn.execute("SELECT * FROM aluno", {});
    for (final row in res.rows) {
      alunos.add(Aluno(
        idUsuario : row.colAt(0),
        nome: row.colAt(1)  ,
        email1: row.colAt(2)  ,
        cpf: row.colAt(3),
      ));
    }

    await conn.close();
  } catch (e) {
    "Erro ao conectar: $e";
  }
  return alunos;
}

insereAluno(nome, email1,cpf) async {
  if (nome == '' && email1 == '' && cpf == '') return 'ERRO, campos não preenchidos';
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
      "INSERT INTO aluno (nome, email1, cpf) VALUES ('$nome', '$email1', $cpf)");
    
    await conn.close();
    return '';
    } catch (e) {
    return "Erro ao conectar: $e";
  }
}

deletaAluno(context, aluno) async {
  var nome = aluno.nome;
  var email = aluno.email1;
  var cpf = aluno.cpf;

  if (nome == '' && email == '') return "Erro campos de nome e email vazios";

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
    print('Conectou');

    await conn.execute("DELETE FROM aluno WHERE nome = '$nome' AND email1 = '$email' AND cpf = '$cpf'");
    print("Deletou");

    await conn.close();

    return '';
  } catch (e) {
    return "Erro ao tentar excluir o aluno ($nome): $e";
  }
}