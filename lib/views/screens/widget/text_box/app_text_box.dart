// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/input_decoration.dart';
import 'package:lekra/services/theme.dart';

class AppTextFieldWithHeading extends StatefulWidget {
  final TextEditingController controller;
  final String? heading;
  final String hindText;
  final TextStyle? hintStyle;
  final String? prefixText;
  TextStyle? prefixStyle;
  final Widget? preFixWidget;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final FormFieldValidator<String>? validator; // made nullable for flexibility
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool isRequired;
  final bool readOnly;
  final Color? borderColor;
  final Color? bgColor;
  final Function()? onTap;
  final double borderRadius;
  final double hight;
  final Function(String)? onChanged;

  AppTextFieldWithHeading({
    super.key,
    required this.controller,
    required this.hindText,
    this.hintStyle,
    this.validator,
    this.heading,
    this.keyboardType,
    this.suffix,
    this.prefixText,
    this.prefixStyle,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLines,
    this.preFixWidget,
    this.isRequired = false,
    this.readOnly = false,
    this.borderColor,
    this.bgColor,
    this.onTap,
    this.onChanged,
    this.borderRadius = 12.0,
    this.hight = 48,
  });

  Color get borderColorLocal => borderColor ?? grey.withValues(alpha: 0.5);
  Color get bgColorLocal => bgColor ?? grey.withValues(alpha: 0.1);

  @override
  State<AppTextFieldWithHeading> createState() =>
      _AppTextFieldWithHeadingState();
}

class _AppTextFieldWithHeadingState extends State<AppTextFieldWithHeading> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final hintStyleLocal = widget.hintStyle ??
        Helper(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: greyText,
            );

    // Ensure single-line when obscured. If caller passed >1, we override.
    final int effectiveMaxLines = _obscure ? 1 : (widget.maxLines ?? 1);

    // If caller provided a suffix, use it; otherwise if field is obscured show a toggle eye.
    final Widget? suffixWidget = widget.suffix ??
        (widget.obscureText
            ? IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.heading != null) ...[
          Row(
            children: [
              Text(
                widget.heading!,
                style: Helper(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 4),
              if (widget.isRequired)
                Text(
                  "*",
                  style: Helper(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 7),
        ],
        SizedBox(
          height: widget.hight,
          child: TextFormField(
            onTap: widget.onTap,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: _obscure,
            inputFormatters: widget.inputFormatters,
            maxLines: effectiveMaxLines,
            readOnly: widget.readOnly,
            onChanged: widget.onChanged,
            decoration: CustomDecoration.inputDecoration(
              borderRadius: widget.borderRadius,
              suffix: suffixWidget,
              icon: widget.preFixWidget,
              prefixText: widget.prefixText,
              prefixStyle: widget.prefixStyle,
              bgColor: widget.bgColorLocal,
              hint: widget.hindText,
              hintStyle: hintStyleLocal,
              borderColor: widget.borderColorLocal,
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
