import 'package:flutter/material.dart';
import 'package:minhaloja/domain_layer/entities/combo/combo_entity.dart';
import 'package:minhaloja/infra/utils.dart';

class ListCombos extends StatefulWidget {
  final List<ComboEntity> combos;
  final ComboEntity? comboSelected;
  final void Function(ComboEntity) value;

  const ListCombos({
    super.key,
    required this.combos,
    required this.comboSelected,
    required this.value,
  });

  @override
  State<ListCombos> createState() => _ListCombosState();
}

class _ListCombosState extends State<ListCombos> {
  List<ComboEntity> list = [];
  List<bool> listSelected = [];

  @override
  void initState() {
    super.initState();
    list.addAll(widget.combos);
    listSelected.addAll(widget.combos.map((item) {
      if (item.name == widget.comboSelected?.name) {
        return true;
      } else {
        return item.isSelected;
      }
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: ToggleButtons(
        direction: Axis.horizontal,
        onPressed: (index) {
          setState(() {
            for (var i = 0; i < listSelected.length; i++) {
              listSelected[i] = false;
            }

            if (listSelected[index] == true) {
              listSelected[index] = false;
            } else if (listSelected[index] == false) {
              listSelected[index] = true;
            }
            widget.value(list[index]);
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        borderColor: design.primary100,
        selectedBorderColor: design.primary100,
        selectedColor: design.white,
        fillColor: design.primary100,
        color: design.primary100,
        textStyle: design
            .labelM(color: design.white)
            .copyWith(fontWeight: FontWeight.w700),
        constraints: BoxConstraints(
          minHeight: 42.height,
          minWidth: 42.width,
        ),
        isSelected: listSelected,
        children: list.map((combo) => Text(combo.name.toUpperCase())).toList(),
      ),
    );
  }
}
