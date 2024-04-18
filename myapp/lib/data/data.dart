import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Data {
  static Database? _database;
  static const String tableName = 'usuarios';

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // Se o banco de dados não existir, inicialize-o
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'usuarios.db');

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            idUsuario INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            email1 TEXT,
            email2 TEXT,
            telefone TEXT,
            celular TEXT,
            foto TEXT DEFAULT 'fotos/semfoto.jpg',
            serie INTEGER,
            periodo TEXT,
            idHabilitacao INTEGER,
            registro TEXT,
            primeiraVez INTEGER NOT NULL DEFAULT 1,
            ativo INTEGER NOT NULL DEFAULT 0,
            senha TEXT,
            participacaoAnterior INTEGER NOT NULL DEFAULT 0,
            id_user_login INTEGER,
            pesquisa INTEGER NOT NULL DEFAULT 0,
            data_pesquisa INTEGER NOT NULL DEFAULT 0,
            cpf TEXT,
            profile TEXT,
            FOREIGN KEY(idHabilitacao) REFERENCES habilitacoes(idHabilitacao)
          )
        ''');
      },
    );
  }
  static Future<void> insertUsuario(Map<String, dynamic> usuario) async {
    final db = await database;
    await db.insert(tableName, usuario,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> batchInsertUsuarios(List<Map<String, dynamic>> usuarios) async {
    final db = await database;
    final batch = db.batch();
    for (var usuario in usuarios) {
      batch.insert(tableName, usuario,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }
}
