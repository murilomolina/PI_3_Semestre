import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql_client/mysql_client.dart';
class Trabalhos{
  final idTrabalho;
  final titulo;
  final orientador;
  final coorientador;
  final resumo;
  final idEstande;
  Trabalhos({
    required this.idTrabalho,      
    required this.titulo,        
    required this.orientador,            
    required this.coorientador,            
    required this.resumo,            
    required this.idEstande,           
  });
}

Future<List<Trabalhos>> consultaTrabalhos() async {
  List<Trabalhos> trabalhos = [];

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
    var res = await conn.execute("SELECT * FROM trabalhos", {});
    for (final row in res.rows) {
      trabalhos.add(Trabalhos(
        idTrabalho: row.colAt(0),
        titulo: row.colAt(1),
        orientador: row.colAt(2),
        coorientador: row.colAt(3),
        resumo: row.colAt(4),
        idEstande: row.colAt(5),
      ));
    }

    await conn.close();
  } catch (e) {
    "Erro ao conectar: $e";
  }

  return trabalhos;
}

insereTrabalho(titulo, int orientador, int coorientador, resumo, int idEstande) async {
  if (titulo == '' && orientador <= 0 && idEstande == '') return "Erro, campos não preenchidos";
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
      "INSERT INTO trabalhos (titulo, orientador, coorientador, resumo, idEstande) VALUES ('$titulo', '$orientador', '$coorientador', '$resumo', '$idEstande')");
    
    await conn.close();
    return '';
    } catch (e) {
      print(e);
    return "Erro ao conectar: $e";
  }
}
editaTrabalho(int idTrabalho, titulo, int idOrientador, int? idCoorientador, resumo, int? idEstande,
  ) async {
  if (titulo == '' || idOrientador < 0) {
    return "Título ou orientador não foram preenchidos corretamente. Abos devem ser preenchidos!!";
  }
  
  await dotenv.load(fileName: "lib/assets/.env");
  try {
    final conn = await MySQLConnection.createConnection(
      host: dotenv.get("HOST_BD"),
      port: int.parse(dotenv.get("PORT_BD")),
      userName: dotenv.get("USUARIO_BD"),
      password: dotenv.get("SENHA_BD"),
      databaseName: "bdeurekamap",
    );
    print(titulo);
    
    // Construir a query SQL de atualização com base nos parâmetros fornecidos
    String query = "UPDATE trabalhos SET ";
    List<String> updates = [];

    // Adicionar os campos que foram fornecidos para atualização
    if (titulo != '') {
      updates.add("titulo = '$titulo'");
    }
    if (idOrientador >= 0) {
      updates.add("orientador = $idOrientador");
    }
    
    if (idCoorientador != null && idCoorientador >= 0) {
      updates.add("coorientador = $idCoorientador");
    } else {
      updates.add("coorientador = NULL");
    }
    
    if (resumo.isNotEmpty) {
      updates.add("resumo = '$resumo'");
    } else {
      updates.add("resumo = NULL");
    }
    
    if (idEstande != null && idEstande >= 0) {
      updates.add("idEstande = $idEstande");
    } else {
      updates.add("idEstande = NULL");
    }
    
    // Montar a query final
    query += updates.join(", ");
    query += " WHERE idTrabalho = $idTrabalho";
    await conn.connect();
    await conn.execute(query);
    
    await conn.close();
    
    return '';
  } catch (e) {
    // Capturar e imprimir o erro, retornar uma mensagem de erro
    print("Erro ao tentar editar o trabalho: $e");
    return "Erro ao tentar editar o trabalho: $e";
  }
}

deletaTrabalho(context, trabalho) async {
  var titulo = trabalho.titulo;
  var idTrabalho = trabalho.idTrabalho;
  var idEstande = trabalho.idEstande;

  if (titulo == '' || idTrabalho == "" || idEstande == "") return "Erro. Campos titulo, idTrabalho e idEstande vazios!";

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

    await conn.execute("DELETE FROM trabalhos WHERE titulo = '$titulo' AND idEstande = '$idEstande' AND idTrabalho = '$idTrabalho'");
    print("Deletou");

    await conn.close();

    return '';
  } catch (e) {
    print(e);
    return "Erro ao tentar excluir o trabalho ($titulo): $e";
  }
}
vinculaTrabalhoAluno(context, trabalho, aluno) async {
  var idaluno = 0;
  var idTrabalho = trabalho.idTrabalho;

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
    var res = await conn.execute("SELECT idAluno FROM aluno WHERE nome = '$aluno'");
    for (final row in res.rows) {
      idaluno = row.colAt(0) as int;
    }
    await conn.execute("UPDATE trabalhos_aluno SET idAluno = '$idaluno' WHERE idTrabalho = '$idTrabalho'");
    print("Vinculou");
    await conn.close();
    return '';
    }catch (e) {
    print(e);
    return "Erro ao tentar vincular o trabalho ({$idTrabalho}) com o aluno ({$aluno}): $e";
  }
}