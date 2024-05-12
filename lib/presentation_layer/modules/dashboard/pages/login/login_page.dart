import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minhaloja/infra/base.dart';
import 'package:minhaloja/infra/utils.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => const Duration(milliseconds: 2250);
  late LoginCubit _controller;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<LoginCubit>();
  }

  Future<String?> _signupUser(SignupData data) async {
    return Future.delayed(loginTime).then((_) async {
      if (data.name != null && data.password != null) {
        await _controller.registerUser(
          name: data.name.toString().split('@')[0],
          email: data.name.toString(),
          password: data.password.toString(),
        );
      }
      return null;
    });
  }

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) async {
      final response = await _controller.signUp(
        email: data.name.toString(),
        password: data.password.toString(),
      );
      if (response == null) {
        return 'Email nāo cadastrado';
      }
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) async {
    return Future.delayed(loginTime).then((_) async {
      await _controller.recoverPassword(email: name);
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return FlutterLogin(
      title: 'Minha Loja',
      savedEmail: 'patrick2.bms@gmail.com',
      savedPassword: '123456',
      theme: LoginTheme(
        primaryColor: bgColor,
        // primaryColor: design.primary100,
        // textFieldStyle: design.h2(color: Colors.black),
        // cardTheme: const CardTheme(
        //   color: Color.fromARGB(255, 182, 182, 183),
        // ),
        titleStyle: GoogleFonts.yesevaOne(
          textStyle: TextStyle(
            height: 0,
            fontSize: 32.0,
            fontWeight: FontWeight.w700,
            color: design.white,
          ),
        ),
      ),
      // logo: AssetImage('assets/images/ecorp-lightblue.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        // FirebaseAuth.instance.userChanges().asBroadcastStream().listen((event) {
        //   if (event != null) {
        //     Modular.to.pushReplacementNamed(PageRoutes.dashboard);
        //   }
        // });
      },
      onRecoverPassword: _recoverPassword,
      messages: LoginMessages(
        loginButton: 'ENTRAR',
        signupButton: 'CADASTRAR',
        forgotPasswordButton: 'Esqueceu a sua senha?',
        confirmPasswordHint: 'Confirme a sua Senha',
        passwordHint: 'Senha',
        recoverPasswordButton: 'REDEFINIR',
        recoverPasswordIntro: 'Redefina a sua senha aqui',
        goBackButton: 'VOLTAR',
      ),
    );
  }
}
