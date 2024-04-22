import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:quickfood/infra/infra.dart';

class DefaultFileImage extends StatefulWidget {
  final BuildContext context;
  final String label;
  final double? width;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? height;
  final void Function(XFile?)? onPressed;
  final EdgeInsets? containerMargin;
  final bool border;

  const DefaultFileImage({
    super.key,
    required this.context,
    required this.label,
    required this.onPressed,
    this.width,
    this.height = 56,
    this.backgroundColor,
    this.fontColor,
    this.containerMargin,
    this.border = true,
  });

  @override
  State<DefaultFileImage> createState() => _DefaultFileImageState();
}

class _DefaultFileImageState extends State<DefaultFileImage> {
  XFile? file;

  FoodAppDesign _getDesign() {
    return DesignSystem.of(widget.context);
  }

  Color _getBorderColor() {
    final design = _getDesign();
    return design.secondary300;
  }

  Expanded _buildLabel(EdgeInsets margin) {
    final design = DesignSystem.of(widget.context);
    return Expanded(
      child: Container(
        margin: margin,
        child: Text(
          file != null ? file!.name.toString() : widget.label,
          style: design
              .h6(color: widget.fontColor ?? design.secondary100)
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Container _buildIcon(EdgeInsets margin) {
    return Container(
      width: 20,
      height: 20,
      margin: margin,
      child: const Icon(Icons.upload),
    );
  }

  Row _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIcon(EdgeInsets.only(left: 18.width, right: 0.width)),
        _buildLabel(EdgeInsets.only(left: 16.width)),
      ],
    );
  }

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = pickerFile;
    });
    return pickerFile;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await getImage().then(
          (value) => widget.onPressed?.call(value),
        );
      },
      child: Container(
        margin: widget.containerMargin,
        width: widget.width,
        height: widget.height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? _getDesign().white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _getBorderColor()),
          ),
          child: _buildButton(),
        ),
      ),
    );
  }
}
