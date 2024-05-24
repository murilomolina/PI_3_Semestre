// Classe de simulação do serviço de autenticação
class AuthService {
  // Simula o processo de login
  Future<String> login(String name, String password) async {
    // TEmpo para fazedr a pesquisa no banco
    await Future.delayed(const Duration(seconds: 2));
    // Lógica de autenticação simulada
    if (name == 'teste@gmail.com' && password == '1234') {
      return ''; // se Login bem-sucedido retorna uma string vazia
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