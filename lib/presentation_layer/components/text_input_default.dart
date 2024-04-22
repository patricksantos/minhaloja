import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minhaloja/infra/utils.dart';

enum TextInputDefaultType {
  primary,
  secondary,
}

class TextInputDefault extends FormField<String> {
  final BuildContext context;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextInputType formFieldType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final double contentPadding;
  final Color? fillColor;
  final int? maxLines;
  final AutovalidateMode? validateMode;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final bool enable;
  final bool? autofocus;
  final VoidCallback? toggleObscureText;
  final bool required;
  final String? initialText;
  final int? maxLength;
  final bool showLenghtLabel;
  final bool readOnly;
  final FocusNode? focusNode;
  @override
  // ignore: overridden_fields
  final String? Function(String?)? validator;
  final TextInputDefaultType textFormFieldType;
  final Widget? prefix;
  final bool busy;

  TextInputDefault({
    Key? key,
    required this.context,
    this.labelText,
    this.required = false,
    this.formFieldType = TextInputType.text,
    this.labelStyle,
    this.hintText,
    this.maxLines = 1,
    this.contentPadding = 20,
    this.controller,
    this.inputFormatters,
    this.fillColor,
    this.obscureText = false,
    this.validateMode = AutovalidateMode.onUserInteraction,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onEditingComplete,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.floatingLabelBehavior,
    this.toggleObscureText,
    this.enable = true,
    this.autofocus,
    this.initialText,
    this.validator,
    this.maxLength,
    this.showLenghtLabel = false,
    this.readOnly = false,
    this.textFormFieldType = TextInputDefaultType.primary,
    this.prefix,
    this.focusNode,
    this.busy = false,
  }) : super(
          key: key,
          enabled: true,
          autovalidateMode: validateMode,
          builder: (field) {
            final design = DesignSystem.of(context);
            // ignore: no_leading_underscores_for_local_identifiers
            InputBorder _borderStyle({
              required bool isErrorBorder,
              required bool isFocusedBorder,
            }) {
              if (textFormFieldType == TextInputDefaultType.primary) {
                return OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: isErrorBorder
                        ? design.terciary100
                        : isFocusedBorder
                            ? design.secondary300
                            : Colors.transparent,
                    width: 1.0,
                  ),
                );
              }

              return UnderlineInputBorder(
                borderSide: BorderSide(
                  color:
                      isErrorBorder ? design.secondary300 : design.primary300,
                  width: 1.0,
                ),
              );
            }

            final effectiveDecoration = InputDecoration(
              prefix: prefix,
              enabled: enable,
              hintText: hintText,
              hintStyle: design.labelM(
                color: enable ? design.secondary300 : design.secondary100,
              ),
              filled: textFormFieldType == TextInputDefaultType.secondary
                  ? false
                  : true,
              fillColor: getFillColor(
                design: design,
                textFormFieldType: textFormFieldType,
                enable: enable,
                fillColor: fillColor,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: toggleObscureText != null
                  ? suffixIcon ??
                      _hiddenTextIcon(
                        design: design,
                        isObscure: obscureText,
                        onTap: toggleObscureText,
                      )
                  : suffixIcon,
              contentPadding: EdgeInsets.symmetric(
                horizontal: contentPadding,
                vertical: contentPadding,
              ),
              enabledBorder: _borderStyle(
                isErrorBorder: false,
                isFocusedBorder: true,
              ),
              border: null,
              focusedBorder: _borderStyle(
                isErrorBorder: false,
                isFocusedBorder: true,
              ),
              disabledBorder: _borderStyle(
                isErrorBorder: false,
                isFocusedBorder: false,
              ),
              focusedErrorBorder: _borderStyle(
                isErrorBorder: true,
                isFocusedBorder: false,
              ),
              errorBorder: _borderStyle(
                isErrorBorder: enable,
                isFocusedBorder: false,
              ),
              errorStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0.0,
              ),
              errorText: null,
              isDense: false,
            ).applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );
            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            final content = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (labelText != null) ...[
                  Row(
                    children: [
                      Text(
                        labelText,
                        style: labelStyle ??
                            design.labelM(
                              color: !field.hasError
                                  ? design.secondary300
                                  : design.terciary100,
                            ),
                      ),
                      Visibility(
                        visible: required,
                        child: Text(
                          '*',
                          style: labelStyle ??
                              design.labelM(
                                color: design.secondary300,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0.height),
                ],
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: initialText,
                        keyboardType: formFieldType,
                        maxLength: showLenghtLabel ? maxLength : null,
                        autovalidateMode: validateMode,
                        inputFormatters: [
                          ...?inputFormatters,
                          if (!showLenghtLabel)
                            LengthLimitingTextInputFormatter(maxLength)
                        ],
                        controller: controller,
                        onChanged: onChangedHandler,
                        onTap: onTap,
                        validator: validator,
                        textCapitalization: textCapitalization,
                        onEditingComplete: onEditingComplete,
                        textInputAction: textInputAction,
                        readOnly: readOnly,
                        autofocus: autofocus ?? false,
                        focusNode: focusNode,
                        decoration: effectiveDecoration.copyWith(
                          errorText: field.errorText,
                        ),
                        obscureText: obscureText,
                        style:
                            textFormFieldType == TextInputDefaultType.secondary
                                ? design.h3(
                                    color: design.secondary100,
                                  )
                                : design.labelM(
                                    color: design.secondary100,
                                  ),
                        maxLines: maxLines,
                      ),
                    ),
                    if (busy) ...[
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircularProgressIndicator(),
                      )
                    ]
                  ],
                ),
                Visibility(
                  visible: field.hasError,
                  child: Row(
                    children: [
                      RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.info,
                          color: design.secondary300,
                          size: 20.0.fontSize,
                        ),
                      ),
                      SizedBox(width: 5.33.width),
                      Expanded(
                        child: Text(
                          field.errorText ?? '',
                          style: design
                              .caption(color: design.secondary300)
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            return content;
          },
        );

  @override
  // ignore: library_private_types_in_public_api
  _TextInputDefaultState createState() => _TextInputDefaultState();
}

Color? getFillColor({
  required FoodAppDesign design,
  required TextInputDefaultType textFormFieldType,
  required bool enable,
  required Color? fillColor,
}) {
  if (textFormFieldType == TextInputDefaultType.secondary) {
    return null;
  }

  return enable ? fillColor ?? design.white : design.secondary300;
}

InkWell _hiddenTextIcon({
  required bool isObscure,
  required VoidCallback? onTap,
  required FoodAppDesign design,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(50),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 400),
          crossFadeState:
              !isObscure ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Icon(
            Icons.visibility,
            color: design.secondary300,
          ),
          secondChild: Icon(
            Icons.visibility_off,
            color: design.secondary300,
          ),
        ),
      ],
    ),
  );
}

class _TextInputDefaultState extends FormFieldState<String> {
  TextEditingController? get _effectiveController => widget.controller;

  @override
  TextInputDefault get widget => super.widget as TextInputDefault;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleControllerChanged);

    setValue(widget.controller?.text);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(TextInputDefault oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      setValue(widget.controller?.text);
    }
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController?.text != value) {
      _effectiveController?.text = value!;
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController?.text = widget.initialValue!;
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController?.text != value) {
      didChange(_effectiveController?.text);
    }
  }
}
