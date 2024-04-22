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
          SizedBox(height: 25.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buttonStoreMode(
                color: const Color(0xffED1722),
                design: design,
                icon: PathImages.motorbike,
                label: 'Delivery',
                onTap: () {
                  onTapDelivery();
                  Modular.to.pop();
                },
              ),
              _buttonStoreMode(
                color: design.primary200,
                design: design,
                icon: PathImages.restaurant,
                label: 'Cardápio',
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  icon,
                  width: 60.fontSize,
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
