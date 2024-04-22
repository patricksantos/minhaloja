import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../components/default_button.dart';
import '../../../components/default_text_form_field.dart';
import '../../../components/keyboard_dismiss_on_tap.dart';

import 'package:minhaloja/data_layer/data_layer.dart';

import '../../../../../../infra/infra.dart';

class AddressStep extends StatefulWidget {
  final PageController pageController;

  const AddressStep({
    super.key,
    required this.pageController,
  });

  @override
  State<AddressStep> createState() => _AddressStepState();
}

class _AddressStepState extends State<AddressStep> {
  late AuthCubit _cubit;

  late TextEditingController _city;
  late TextEditingController _state;
  late TextEditingController _zipCode;
  late TextEditingController _neighborhood;
  late TextEditingController _number;
  late TextEditingController _complement;
  late TextEditingController _street;
  late GlobalKey<FormState> _formKey;

  late ScrollPhysics? physics;
  late ScrollController? controller;

  final MaskTextInputFormatter _cpfFormatter = maskFormatterCep();

  @override
  void initState() {
    super.initState();
    _cubit = Modular.get();
    physics = const ScrollPhysics();
    controller = ScrollController();
    _formKey = GlobalKey<FormState>();

    if (_cubit.state.userAddress != null &&
        _cubit.state.userAddress?.zipCode != '') {
      _cubit.setShowAddressInput(_cubit.state.userAddress?.zipCode ?? '');
      _cubit.update(actions: {AuthAction.cepSuccessfully});
    }

    _city = TextEditingController(text: _cubit.state.userAddress?.city);
    _state = TextEditingController(
        text: _cubit.state.userAddress?.state.toUpperCase());
    _zipCode = TextEditingController(
      text: _cpfFormatter.maskText(_cubit.state.userAddress?.zipCode ?? ''),
    );
    _neighborhood =
        TextEditingController(text: _cubit.state.userAddress?.neighborhood);
    _number = TextEditingController(text: _cubit.state.userAddress?.number);
    _complement =
        TextEditingController(text: _cubit.state.userAddress?.complement);
    _street = TextEditingController(text: _cubit.state.userAddress?.street);
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: _cubit,
      listener: (context, state) async {
        final addressConsultSuccessfully = state.actions.contains(
          AuthAction.cepSuccessfully,
        );
        if (addressConsultSuccessfully) {
          _city.text = state.address?.city ?? '';
          _state.text = state.address?.state ?? '';
          _street.text = state.address?.street ?? '';
          _neighborhood.text = state.address?.neighborhood ?? '';
          _complement.text = state.address?.complement ?? '';
        }
      },
      builder: (_, authState) {
        return Container(
          decoration: BoxDecoration(
            color: design.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          height: MediaQuery.of(context).size.height * .95,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 70.height,
              centerTitle: true,
              title: Text(
                'Entrega',
                style: design
                    .h5(
                      color: design.secondary100,
                    )
                    .copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              leading: Container(
                padding: EdgeInsets.only(left: 10.width),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: Modular.to.pop,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.height),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: design.secondary100,
                              textDirection: TextDirection.rtl,
                              size: 26.fontSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: DefaultButton(
              disable: !authState.actions.contains(AuthAction.cepSuccessfully),
              // loading: authState.actions.contains(AuthAction.creating),
              label: 'Salvar',
              onPressed: _onSubmit,
            ).addMargin(
              EdgeInsets.symmetric(
                horizontal: 24.width,
                vertical: 20.0.height,
              ),
            ),
            body: KeyboardDismissOnTap(
              dismissOnCapturedTaps: true,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Endereço',
                          style: design
                              .h5(color: design.secondary100)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 5.height),
                        Text(
                          'Informe os dados completo\ndo seu endereço de entrega',
                          style: design
                              .labelS(
                                color: design.secondary300,
                              )
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none,
                              ),
                        ),
                        SizedBox(height: 15.height),
                        DefaultTextFormField(
                          controller: _zipCode,
                          context: context,
                          required: true,
                          labelText: 'CEP',
                          hintText: 'CEP',
                          maxLength: 9,
                          onChanged: _cubit.setShowAddressInput,
                          validator: Validators.multiple(
                            [
                              Validators.required(),
                              Validators.min(9),
                            ],
                          ),
                          formFieldType: TextInputType.number,
                          inputFormatters: [_cpfFormatter],
                        ),
                        SizedBox(height: 16.height),
                        _buildForm(authState, context, design),
                      ],
                    ).addPadding(
                      EdgeInsets.symmetric(
                        horizontal: 24.width,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildForm(
    AuthState state,
    BuildContext context,
    FoodAppDesign design,
  ) {
    return Visibility(
      // visible: state.actions.contains(AuthAction.cepSuccessfully),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: DefaultTextFormField(
                  textCapitalization: TextCapitalization.words,
                  enable: false,
                  controller: _city,
                  context: context,
                  required: true,
                  labelText: 'Cidade',
                  hintText: 'Cidade',
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  validator: Validators.required(),
                  inputFormatters: [makeOnlyCharactersFormatter()],
                ),
              ),
              SizedBox(width: 10.width),
              Expanded(
                flex: 2,
                child: DefaultTextFormField(
                  controller: _state,
                  enable: false,
                  context: context,
                  textCapitalization: TextCapitalization.characters,
                  required: true,
                  labelText: 'Estado',
                  hintText: 'Estado',
                  textInputAction: TextInputAction.next,
                  validator: Validators.multiple(
                    [
                      Validators.required(),
                      Validators.uf(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.height),
          DefaultTextFormField(
            controller: _neighborhood,
            enable: state.actions.contains(AuthAction.cepSuccessfully),
            context: context,
            textCapitalization: TextCapitalization.words,
            required: true,
            labelText: 'Bairro',
            hintText: 'Bairro',
            inputFormatters: [makeOnlyCharactersFormatter()],
            textInputAction: TextInputAction.next,
            maxLength: 40,
            validator: Validators.required(),
          ),
          SizedBox(height: 16.width),
          DefaultTextFormField(
            controller: _street,
            context: context,
            enable: state.actions.contains(AuthAction.cepSuccessfully),
            textCapitalization: TextCapitalization.words,
            required: true,
            labelText: 'Rua',
            hintText: 'Rua',
            inputFormatters: [makeOnlyCharactersFormatter()],
            textInputAction: TextInputAction.next,
            validator: Validators.required(),
          ),
          SizedBox(height: 16.width),
          DefaultTextFormField(
            controller: _number,
            enable: state.actions.contains(AuthAction.cepSuccessfully),
            context: context,
            formFieldType: TextInputType.number,
            required: true,
            labelText: 'Número',
            hintText: 'Número',
            textInputAction: TextInputAction.next,
            validator: Validators.multiple(
              [Validators.required()],
            ),
          ),
          SizedBox(height: 16.height),
          DefaultTextFormField(
            controller: _complement,
            enable: state.actions.contains(AuthAction.cepSuccessfully),
            context: context,
            maxLength: 50,
            labelText: 'Complemento',
            hintText: 'Complemento',
          ),
        ],
      ),
    );
  }

  void _onSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final address = AddressDTO(
        city: _city.text.trim(),
        zipCode: _zipCode.text.extractNumbers(),
        neighborhood: _neighborhood.text.trim(),
        number: _number.text.trim(),
        complement: _complement.text.trim(),
        country: 'Brasil',
        street: _street.text.trim(),
        state: _state.text.trim(),
      );
      if (_cubit.state.userAddress == null) {
        await _cubit.createAddress(address: address);
      } else {
        await _cubit.updateAddress(address: address);
      }
      Modular.to.pop();
    }
  }
}
