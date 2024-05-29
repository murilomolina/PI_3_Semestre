import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:myapp/auth/auth_service.dart';
import 'package:myapp/pages/pagina_inicial.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    const inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: 'EurekaMap',
      logo: const AssetImage('lib/assets/logo/logo_maua_provisorio.jpg'),
      onLogin: (loginData) {
        return AuthService().login(loginData.name, loginData.password);
      },
      onSignup: (loginData) {
        return AuthService().signup(loginData.name ?? '', loginData.password ?? '');
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const PaginaInicial(),
        ));
      },
      onRecoverPassword: (name) {
        return AuthService().recoverPassword(name);
      }, // o que fazer para recuperar a senha???

      messages: LoginMessages(
        userHint: 'Usuario',
        passwordHint: 'Senha',
        confirmPasswordHint: 'Confirma',
        loginButton: 'LOG IN',
        signupButton: 'Cadastre-se',
        forgotPasswordButton: 'Esqueceu sua senha?',
        recoverPasswordButton: 'Ajuda',
        goBackButton: 'Voltar',
        confirmPasswordError: 'Senha Inválida',
        recoverPasswordDescription:
            'Aqui o usuario receberá uma pequena instrução sobre o que deve fazer para recuperar a senha.', // Criar um texto explicando como restaura a senha
        recoverPasswordSuccess: 'Senha recuperada com sucesso!!!',
      ),
      theme: LoginTheme(
        primaryColor: Colors.white,
        accentColor: Colors.blue.shade700,
        errorColor: Colors.red,
        titleStyle: const TextStyle(
          color: Color.fromARGB(255, 13, 71, 161),
          fontFamily: 'Quicksand',
          letterSpacing: 4,
          fontWeight: FontWeight.bold,
        ),
        bodyStyle: const TextStyle(
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
            color: Colors.black),
        textFieldStyle: const TextStyle(
          color: Color.fromARGB(255, 236, 113, 126),
          shadows: [Shadow(color: Colors.redAccent, blurRadius: 2)],
        ),
        buttonStyle: const TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          color: Colors.blue.shade50,
          elevation: 5,
          margin: const EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: const TextStyle(
            backgroundColor: Colors.red,
            color: Colors.white,
          ),
          labelStyle: const TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Colors.blue[900],
          highlightColor: Colors.lightBlue,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
