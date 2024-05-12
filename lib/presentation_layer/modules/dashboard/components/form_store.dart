import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:minhaloja/domain_layer/domain_layer.dart';
import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/presentation_layer/components/components.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../cubit/dashboard_cubit.dart';

class FormStore extends StatefulWidget {
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Future<void> Function(FormStoreOnPressed form)? onPressed;

  const FormStore({
    super.key,
    this.labelStyle,
    this.hintStyle,
    this.fillColor,
    required this.onPressed,
  });

  @override
  State<FormStore> createState() => _RegisterStoreState();
}

class _RegisterStoreState extends State<FormStore> {
  late AuthCubit _authController;
  late DashboardCubit _dashboardCubit;

  late GlobalKey<FormState> _formKey;
  late ScrollPhysics? physics;

  final MaskTextInputFormatter _cepFormatter = maskFormatterCep();
  final MaskTextInputFormatter _cpfFormatter = maskFormatterCpf();
  final MaskTextInputFormatter _cnpjFormatter = maskFormatterCnpj();
  final MaskTextInputFormatter _phoneNumberFormatter =
      maskFormatterPhoneNumber();

  late TextEditingController _name;
  // late TextEditingController _nameLink;
  late TextEditingController _segment;
  late TextEditingController _cnpjOrCpf;
  late TextEditingController _phoneNumber;
  late TextEditingController _description;

  late TextEditingController _city;
  late TextEditingController _state;
  late TextEditingController _zipCode;
  late TextEditingController _neighborhood;
  late TextEditingController _number;
  late TextEditingController _complement;
  late TextEditingController _street;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _authController = Modular.get<AuthCubit>();
    _dashboardCubit = Modular.get<DashboardCubit>();

    physics = const ScrollPhysics();
    _formKey = GlobalKey<FormState>();

    _name = TextEditingController(
        text: _dashboardCubit.state.restaurant?.name ?? '');
    // _nameLink = TextEditingController(
    //     text: _dashboardCubit.state.restaurant?.url ?? '');
    _segment = TextEditingController(
        text: _dashboardCubit.state.restaurant?.segment ?? '');
    _cnpjOrCpf = TextEditingController(
      text:
          _cpfFormatter.maskText(_dashboardCubit.state.restaurant?.cnpj ?? ''),
    );
    _phoneNumber = TextEditingController(
      text: _phoneNumberFormatter
          .maskText(_dashboardCubit.state.restaurant?.phoneNumber ?? ''),
    );
    _description = TextEditingController(
        text: _dashboardCubit.state.restaurant?.description ?? '');

    _zipCode = TextEditingController(
        text: _cepFormatter.maskText(
      _dashboardCubit.state.restaurant?.address?.zipCode ?? '',
    ));
    _city = TextEditingController(
        text: _dashboardCubit.state.restaurant?.address?.city ?? '');
    _state = TextEditingController(
        text: _dashboardCubit.state.restaurant?.address?.state ??
            ''.toUpperCase());
    _neighborhood = TextEditingController(
        text: _dashboardCubit.state.restaurant?.address?.neighborhood ?? '');
    _number = TextEditingController(
        text: _dashboardCubit.state.restaurant?.address?.number ?? '');
    _complement = TextEditingController(
        text: _dashboardCubit.state.restaurant?.address?.complement ?? '');
    _street = TextEditingController(
        text: _dashboardCubit.state.restaurant?.address?.street ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: _authController,
      builder: (context, state) {
        return KeyboardDismissOnTap(
          child: Skeletonizer(
            enabled: loading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dados da Loja',
                  style: design.h2(color: Colors.white),
                ),
                SizedBox(height: 10.height),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextFormField(
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        controller: _name,
                        required: true,
                        labelText: 'Nome',
                        hintText: 'Nome',
                        maxLength: 32,
                        validator: Validators.multiple(
                          [
                            Validators.required(),
                            Validators.min(4),
                          ],
                        ),
                      ),
                      // SizedBox(height: 8.height),
                      // DefaultTextFormField(
                      //   context: context,
                      //   labelStyle: widget.labelStyle,
                      //   hintStyle: widget.hintStyle,
                      //   fillColor: widget.fillColor,
                      //   borderColor: widget.labelStyle?.color,
                      //   controller: _nameLink,
                      //   required: true,
                      //   labelText: 'Nome do Link',
                      //   hintText: 'Nome do Link',
                      //   maxLength: 32,
                      //   validator: Validators.multiple(
                      //     [Validators.required(), Validators.min(4)],
                      //   ),
                      // ),
                      SizedBox(height: 8.height),
                      DefaultTextFormField(
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        controller: _segment,
                        required: true,
                        labelText: 'Segmento da Loja',
                        hintText: 'Segmento da Loja',
                        maxLength: 32,
                        validator: Validators.min(4),
                      ),
                      SizedBox(height: 8.height),
                      DefaultTextFormField(
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        controller: _cnpjOrCpf,
                        required: true,
                        labelText: 'CNPJ ou CPF',
                        hintText: 'CNPJ ou CPF',
                        maxLength: 18,
                        validator: Validators.multiple(
                            _cnpjOrCpf.text.length > 14
                                ? [Validators.cnpj()]
                                : [Validators.cpf()]),
                        formFieldType: TextInputType.number,
                        inputFormatters: _cnpjOrCpf.text.length > 14
                            ? [_cnpjFormatter]
                            : [_cpfFormatter],
                      ),
                      SizedBox(height: 8.height),
                      DefaultTextFormField(
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        controller: _phoneNumber,
                        required: true,
                        labelText: 'Numero de Telefone',
                        hintText: 'Numero de Telefone',
                        maxLength: 18,
                        validator: Validators.multiple([
                          Validators.min(16),
                          Validators.max(16),
                        ]),
                        formFieldType: TextInputType.number,
                        inputFormatters: [_phoneNumberFormatter],
                      ),
                      SizedBox(height: 8.height),
                      DefaultTextFormField(
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        controller: _description,
                        labelText: 'Descriçāo da Loja (Opcional)',
                        hintText: 'Descriçāo da Loja (Opcional)',
                        maxLength: 18,
                        validator: Validators.max(32),
                        inputFormatters: [onlyAlphabeticalFormatter],
                      ),
                      SizedBox(height: 8.height),
                      Text(
                        'Endereço',
                        style: design.h4().copyWith(
                              color: widget.labelStyle?.color ??
                                  design.secondary100,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: 8.height),
                      DefaultTextFormField(
                        controller: _zipCode,
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        required: true,
                        labelText: 'CEP',
                        hintText: 'CEP',
                        maxLength: 9,
                        // onChanged: _authController.setShowAddressInput,
                        validator: Validators.multiple(
                          [
                            Validators.required(),
                            Validators.min(9),
                          ],
                        ),
                        formFieldType: TextInputType.number,
                        inputFormatters: [_cepFormatter],
                      ),
                      SizedBox(height: 8.height),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: DefaultTextFormField(
                              textCapitalization: TextCapitalization.words,
                              // enable: false,
                              controller: _city,
                              context: context,
                              labelStyle: widget.labelStyle,
                              hintStyle: widget.hintStyle,
                              fillColor: widget.fillColor,
                              borderColor: widget.labelStyle?.color,
                              required: true,
                              labelText: 'Cidade',
                              hintText: 'Cidade',
                              textInputAction: TextInputAction.next,
                              maxLength: 30,
                              inputFormatters: [makeOnlyCharactersFormatter()],
                              validator: Validators.required(),
                            ),
                          ),
                          SizedBox(width: 8.width),
                          Expanded(
                            flex: 2,
                            child: DefaultTextFormField(
                                controller: _state,
                                // enable: false,
                                context: context,
                                labelStyle: widget.labelStyle,
                                hintStyle: widget.hintStyle,
                                fillColor: widget.fillColor,
                                borderColor: widget.labelStyle?.color,
                                textCapitalization:
                                    TextCapitalization.characters,
                                labelText: 'Estado',
                                hintText: 'Estado',
                                textInputAction: TextInputAction.next,
                                validator: Validators.required()
                                // Validators.multiple(
                                // [Validators.uf()],
                                // ),
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.height),
                      DefaultTextFormField(
                        controller: _neighborhood,
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        textCapitalization: TextCapitalization.words,
                        // enable:
                        //     state.actions.contains(AuthAction.cepSuccessfully) ||
                        //         _dashboardCubit.state.restaurant != null,
                        required: true,
                        labelText: 'Bairro',
                        hintText: 'Bairro',
                        inputFormatters: [makeOnlyCharactersFormatter()],
                        textInputAction: TextInputAction.next,
                        maxLength: 40,
                      ),
                      SizedBox(height: 8.width),
                      DefaultTextFormField(
                        controller: _street,
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        textCapitalization: TextCapitalization.words,
                        // enable:
                        //     state.actions.contains(AuthAction.cepSuccessfully) ||
                        //         _dashboardCubit.state.restaurant != null,
                        required: true,
                        labelText: 'Rua',
                        hintText: 'Rua',
                        inputFormatters: [makeOnlyCharactersFormatter()],
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 8.width),
                      DefaultTextFormField(
                        controller: _number,
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        formFieldType: TextInputType.number,
                        // enable:
                        //     state.actions.contains(AuthAction.cepSuccessfully) ||
                        //         _dashboardCubit.state.restaurant != null,
                        required: true,
                        labelText: 'Número',
                        hintText: 'Número',
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 8.height),
                      DefaultTextFormField(
                        controller: _complement,
                        // enable:
                        //     state.actions.contains(AuthAction.cepSuccessfully) ||
                        //         _dashboardCubit.state.restaurant != null,
                        context: context,
                        labelStyle: widget.labelStyle,
                        hintStyle: widget.hintStyle,
                        fillColor: widget.fillColor,
                        borderColor: widget.labelStyle?.color,
                        maxLength: 50,
                        labelText: 'Complemento',
                        hintText: 'Complemento',
                      ),
                      DefaultButton(
                        // disable: _formKey.currentState?.validate() ?? true,
                        label: _dashboardCubit.state.page == 3
                            ? 'Atualizar'
                            : 'Salvar',
                        onPressed: _onSubmit,
                      ).addMargin(
                        EdgeInsets.symmetric(
                          vertical: 12.0.height,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        loading = true;
      });
      // _dashboardCubit.update(loading: true);

      await widget.onPressed?.call(
        FormStoreOnPressed(
          id: _dashboardCubit.state.restaurant?.id ?? '',
          addressId: _dashboardCubit.state.restaurant?.addressId ?? '',
          // user: _dashboardCubit.state.currentUser!,
          // userId: _dashboardCubit.state.currentUser!.id!,
          name: _name.text,
          url: _dashboardCubit.state.restaurant?.url ?? '',
          segment: _segment.text,
          cnpj: _cnpjOrCpf.text.replaceAll('-', '').replaceAll('.', ''),
          phoneNumber: _phoneNumber.text
              .replaceAll('-', '')
              .replaceAll('(', '')
              .replaceAll(')', '')
              .replaceAll(' ', ''),
          description: _description.text,
          city: _city.text,
          complement: _complement.text,
          country: 'Brazil',
          neighborhood: _neighborhood.text,
          number: _number.text,
          stateCountry: _state.text,
          street: _street.text,
          zipCode: _zipCode.text.replaceAll('-', ''),
          logoUrl: _dashboardCubit.state.restaurant?.logoUrl ?? '',
          backgroundUrl: _dashboardCubit.state.restaurant?.backgroundUrl ?? '',
          banner: _dashboardCubit.state.restaurant?.banner ?? [],
        ),
      );

      // _dashboardCubit.update(loading: false);
      setState(() {
        loading = false;
      });
    }
  }
}

class FormStoreOnPressed {
  // UserEntity user;
  String id;
  // String userId;
  String addressId;
  String cnpj;
  String phoneNumber;
  String url;
  String logoUrl;
  String backgroundUrl;
  String name;
  String description;
  String segment;
  String city;
  String complement;
  String country;
  String neighborhood;
  String number;
  String street;
  String zipCode;
  String stateCountry;
  List<BannerEntity> banner;

  FormStoreOnPressed({
    required this.id,
    // required this.user,
    // required this.userId,
    required this.addressId,
    required this.cnpj,
    required this.phoneNumber,
    required this.url,
    required this.logoUrl,
    required this.backgroundUrl,
    required this.name,
    required this.description,
    required this.segment,
    required this.city,
    required this.complement,
    required this.country,
    required this.neighborhood,
    required this.number,
    required this.street,
    required this.zipCode,
    required this.stateCountry,
    required this.banner,
  });
}
