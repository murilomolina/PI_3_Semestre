import 'data.dart';

class DataPopulator {
  static Future<void> insertUsuarioFromUserInput({
    required String nome,
    String? email1,
    String? email2,
    String? telefone,
    String? celular,
    int? serie,
    String? periodo,
    int? idHabilitacao,
    String? registro,
    int primeiraVez = 1,
    int ativo = 0,
    String? senha,
    int participacaoAnterior = 0,
    int? idUserLogin,
    int pesquisa = 0,
    int dataPesquisa = 0,
    String? cpf,
    String? profile,
  }) async {
    Map<String, dynamic> usuario = {
      'nome': nome,
      'email1': email1,
      'email2': email2,
      'telefone': telefone,
      'celular': celular,
      'serie': serie,
      'periodo': periodo,
      'idHabilitacao': idHabilitacao,
      'registro': registro,
      'primeiraVez': primeiraVez,
      'ativo': ativo,
      'senha': senha,
      'participacaoAnterior': participacaoAnterior,
      'id_user_login': idUserLogin,
      'pesquisa': pesquisa,
      'data_pesquisa': dataPesquisa,
      'cpf': cpf,
      'profile': profile,
    };
    if (nome.isNotEmpty) {
      // Insere o usuário no banco de dados
      await Data.insertUsuario(usuario);
    } else {
      throw Exception('Nome do usuário é obrigatório.');
    }
  }
}