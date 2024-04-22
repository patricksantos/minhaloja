import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaloja/infra/infra.dart';
import 'package:minhaloja/presentation_layer/components/loading_manager.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/components/components.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/constants.dart';
import 'package:minhaloja/presentation_layer/modules/dashboard/cubit/dashboard_cubit.dart';

class ConfigurationStore extends StatefulWidget {
  const ConfigurationStore({
    super.key,
  });

  @override
  State<ConfigurationStore> createState() => _ConfigurationStoreState();
}

class _ConfigurationStoreState extends State<ConfigurationStore>
    with LoadingManager {
  late AuthCubit _authController;
  late DashboardCubit _controller;

  @override
  void initState() {
    super.initState();
    _authController = Modular.get<AuthCubit>();
    _controller = Modular.get<DashboardCubit>();
    Future.delayed(Duration.zero, () => executeStreams(context));
  }

  void executeStreams(BuildContext context) {
    handleLoadingOverlay(_controller.loadingStream.stream, context);
  }

  Future<void> _onSubmit(FormStoreOnPressed form) async {
    await _authController.updateRestaurant(
      id: form.id,
      addressId: form.addressId,
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
      backgroundUrl: form.backgroundUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: FormStore(
        labelStyle: design.h6(color: design.white),
        onPressed: (form) async => await _onSubmit(form),
      ),
    );
  }
}
