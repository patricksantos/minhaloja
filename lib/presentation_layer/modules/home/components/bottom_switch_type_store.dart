import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../infra/utils.dart';

class BottomSwitchTypeStore extends StatelessWidget {
  final VoidCallback onTapDelivery;
  final VoidCallback onTapMenu;

  const BottomSwitchTypeStore({
    super.key,
    required this.onTapDelivery,
    required this.onTapMenu,
  });

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.40,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.width,
        vertical: 16.0.height,
      ),
      decoration: BoxDecoration(
        color: design.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.center,
            child: _slider(
              color: design.secondary300,
            ),
          ),
          Text(
            'Escolha qual a sua forma de retirada',
            textAlign: TextAlign.center,
            style: design.h6(color: design.secondary100).copyWith(
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
          ),
          SizedBox(height: 4.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buttonStoreMode(
                color: const Color(0xffED1722),
                design: design,
                iconSize: 48.fontSize,
                icon: PathImages.fastDelivery,
                label: 'Entrega', //Delivery
                onTap: () {
                  onTapDelivery();
                  Modular.to.pop();
                },
              ),
              _buttonStoreMode(
                color: design.terciary200,
                design: design,
                iconSize: 48.fontSize,
                iconColor: Colors.white,
                icon: PathImages.localizacao,
                label: 'Loja',
                onTap: () {
                  onTapMenu();
                  Modular.to.pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttonStoreMode({
    required Color color,
    required String icon,
    double? iconSize,
    Color? iconColor,
    required VoidCallback onTap,
    required FoodAppDesign design,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        width: 150,
        padding: EdgeInsets.symmetric(vertical: 20.height),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  icon,
                  width: iconSize ?? 60.fontSize,
                  color: iconColor,
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: design.labelS(color: design.white).copyWith(
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                ),
              ],
            ),
            SizedBox(height: 8.height),
            PathImages.shared(
              color: design.white,
              height: 20.fontSize,
              width: 20.fontSize,
            ),
          ],
        ),
      ),
    );
  }

  Container _slider({required Color color}) {
    return Container(
      height: 4,
      width: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
