import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quickfood/presentation_layer/components/default_button.dart';
import 'package:quickfood/presentation_layer/components/default_text_form_field.dart';

import '../../../../../../infra/infra.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late LoginCubit _controller;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _controller = Modular.get<LoginCubit>();
    _name = TextEditingController(text: '');
    _email = TextEditingController(text: '');
    _password = TextEditingController(text: '');
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final design = DesignSystem.of(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      bottomNavigationBar: DefaultButton(
        label: 'Cadastrar',
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _controller.registerUser(
              name: _name.text,
              password: _password.text,
              email: _email.text,
            );
          }
        },
      ).addMargin(
        EdgeInsets.symmetric(
          horizontal: 24.width,
          vertical: 20.0.height,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            DefaultTextFormField(
              textCapitalization: TextCapitalization.characters,
              controller: _name,
              context: context,
              required: true,
              labelText: 'Nome',
              hintText: 'Nome',
              textInputAction: TextInputAction.next,
              maxLength: 30,
              validator: Validators.required(),
              // inputFormatters: [makeOnlyCharactersFormatter()],
            ),
            DefaultTextFormField(
              textCapitalization: TextCapitalization.characters,
              controller: _email,
              context: context,
              required: true,
              labelText: 'Email',
              hintText: 'Email',
              textInputAction: TextInputAction.next,
              maxLength: 30,
              validator: Validators.required(),
              // inputFormatters: [makeOnlyCharactersFormatter()],
            ),
            DefaultTextFormField(
              textCapitalization: TextCapitalization.characters,
              controller: _password,
              context: context,
              required: true,
              toggleObscureText: () {},
              labelText: 'Senha',
              hintText: 'Senha',
              textInputAction: TextInputAction.next,
              obscureText: false,
              maxLength: 30,
              validator: Validators.required(),
              // inputFormatters: [makeOnlyCharactersFormatter()],
            ),
          ],
        ),
      ),
    );
  }
}
