import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:quickfood/infra/infra.dart';
import 'package:quickfood/presentation_layer/components/keyboard_dismiss_on_tap.dart';
import 'package:quickfood/presentation_layer/modules/dashboard/components/components.dart';

class NewStore extends StatefulWidget {
  const NewStore({
    super.key,
  });

  @override
  State<NewStore> createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<NewStore> {
  late LoginCubit _loginController;
  late AuthCubit _authController;

  @override
  void initState() {
    super.initState();
    _loginController = Modular.get<LoginCubit>();
    _authController = Modular.get<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF212332),
      body: KeyboardDismissOnTap(
        child: Center(
          child: Card(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 500,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: design.secondary300,
                            size: 24.fontSize,
                          ),
                          onPressed: () => _loginController.signOut(),
                        ).addPadding(
                          EdgeInsets.only(
                            right: 12.width,
                            top: 5.height,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cadastre a sua Loja aqui',
                          style: design.h3().copyWith(
                                color: design.secondary100,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 4.height),
                        Text(
                          'Informe os seus dados completo\npara que possamos cria-la aqui.',
                          style: design.h6().copyWith(
                                color: design.secondary300,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                              ),
                        ),
                        SizedBox(height: 8.height),
                        FormStore(
                          onPressed: (form) async => await _onSubmit(form),
                        ),
                      ],
                    ).addPadding(
                      EdgeInsets.symmetric(
                        horizontal: 24.width,
                        vertical: 12.height,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).addPadding(
            EdgeInsets.symmetric(
              vertical: ResponsiveScreen.isMobile(context) ? 0 : 24.height,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit(FormStoreOnPressed form) async {
    await _authController
        .createRestaurant(
          user: form.user,
          userId: form.userId,
          name: form.name,
          url: form.url,
          segment: form.segment,
          cnpj: form.cnpj,
          phoneNumber: form.phoneNumber,
          description: form.description,
          city: form.city,
          complement: form.complement,
          country: form.country,
          neighborhood: form.neighborhood,
          number: form.number,
          stateCountry: form.stateCountry,
          street: form.street,
          zipCode: form.zipCode,
          logoUrl: form.logoUrl,
          backgroundUrl: '',
        )
        .then((value) => Modular.to.pushNamed(PageRoutes.dashboard));
  }
}
