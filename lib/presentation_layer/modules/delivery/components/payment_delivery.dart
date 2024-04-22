import 'package:flutter/widgets.dart';
import '../../../../presentation_layer/components/default_radio_button.dart';

import 'package:minhaloja/infra/infra.dart';

class PaymentDelivery extends StatefulWidget {
  final StoreCubit storeCubit;
  final String character;

  const PaymentDelivery({
    super.key,
    required this.storeCubit,
    required this.character,
  });

  @override
  State<PaymentDelivery> createState() => _PaymentDeliveryState();
}

class _PaymentDeliveryState extends State<PaymentDelivery> {
  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Formas de Pagamento',
          style: design
              .h6(color: design.secondary100)
              .copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15.height),
        ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.storeCubit.state.listFormPayment.length,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.storeCubit.state.listFormPayment.reversed
                .elementAt(index);
            return Padding(
              padding: EdgeInsets.only(top: 8.height),
              child: DefaultRadioButton(
                context: context,
                alignButton: AlignButton.left,
                label: item.name,
                formValue: item.name,
                currentValue: widget.storeCubit.state.formPayment?.name ??
                    widget.character,
                onValue: (value) {
                  setState(() {
                    widget.storeCubit.onChangeFormPayment(formPayment: item);
                  });
                },
              ),
            );
          },
        ),
      ],
    ).addPadding(
      EdgeInsets.symmetric(
        horizontal: 20.width,
      ),
    );
  }
}
