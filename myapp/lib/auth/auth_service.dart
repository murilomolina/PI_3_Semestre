// Classe de simulação do serviço de autenticação
import 'package:myapp/data/usuario_app.dart';

class AuthService {
  // Simula o processo de login
  Future<String> login(String email, String senha) async {
    // TEmpo para fazedr a pesquisa no banco
    await Future.delayed(const Duration(seconds: 2));
    List<UsuarioApp> usuarios = await consultaUsuariosApp();

    for (final usuario in usuarios) {
      if (usuario.email == email && usuario.senha == senha) {
        return ''; // vazia pouis a função entende que se o retorno for vazio o login foi bem sucedido
      }
    }
    return 'Nome de usuário ou senha inválidos'; // Mensagem de erro
  }

  // Simula o processo de cadastro
  Future<String> signup(String name, String password) async {
    // TEmpo para fazedr a pesquisa no banco
    await Future.delayed(const Duration(seconds: 2));
    // Lógica de cadastro simulada
    if (name != 'teste@gmail.com') {
      return ''; // se Cadastro bem-sucedido retorna uma string vazia
    }
    return 'O nome de usuário já está em uso'; // Mensagem de erro
  }

  // Simula o processo de recuperação de senha
  Future<String> recoverPassword(String name) async {
    // TEmpo para fazedr a pesquisa no banco
    await Future.delayed(const Duration(seconds: 2));
    // Lógica de recuperação de senha simulada
    if (name == 'teste@gmail.com') {
      return ''; // se Recuperação de senha bem-sucedida retorna uma string vazia
    }
    return 'Nome de usuário não encontrado'; // Mensagem de erro
  }
}