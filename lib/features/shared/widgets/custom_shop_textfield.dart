import 'package:flutter/material.dart';

class CustomShopTextfield extends StatefulWidget {
  final double height, width;
  final IconData? icon;
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final String? Function(Object?)? validator;
  final void Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;

  const CustomShopTextfield(
      {this.icon,
      required this.textInputAction,
      super.key,
      this.height = 40,
      this.width = 200,
      this.hintText,
      this.isPassword = false,
      this.controller,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.autovalidateMode});

  @override
  State<CustomShopTextfield> createState() => _CustomShopTextfieldState();
}

class _CustomShopTextfieldState extends State<CustomShopTextfield> {
  late FocusNode _focused;
  late Color focusColor;
  late bool showText;

  @override
  void initState() {
    widget;
    showText = false;
    _focused = FocusNode();
    focusColor = Colors.grey.shade300;
    _focused.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange() {
    if (!_focused.hasFocus) {
      focusColor = Colors.grey.shade300;
      setState(() {});
    } else {
      focusColor = Colors.amber;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return FormField(
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      builder: (field) => Stack(
        children: [
          Column(
            children: [
              SizedBox(
                  height: widget.height,
                  width: widget.width,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: TextField(
                      onChanged: widget.onChanged,
                      textInputAction: widget.textInputAction,
                      keyboardType: widget.keyboardType,
                      controller: widget.controller,
                      obscureText: widget.isPassword ? !showText : false,
                      autofocus: false,
                      focusNode: _focused,
                      cursorHeight: widget.height / 2.3,
                      style: Theme.of(context).textTheme.labelLarge,
                      decoration: InputDecoration(
                        suffixIcon: widget.isPassword
                            ? GestureDetector(
                                onTap: () {
                                  showText = !showText;
                                  setState(() {});
                                },
                                child: Icon(showText ? Icons.remove_red_eye : Icons.remove_red_eye_outlined))
                            : null,
                        hintText: widget.hintText,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.grey.shade400, fontWeight: FontWeight.w700),
                        prefixIcon: Icon(
                          widget.icon,
                          size: 20,
                          color: focusColor,
                        ),
                        filled: true,
                        contentPadding: const EdgeInsets.only(top: 24.5, left: 0),
                        fillColor:
                            isDarkMode ? Colors.amber.shade200.withOpacity(.1) : Colors.grey.shade200.withOpacity(.9),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isDarkMode
                                ? Colors.amber.shade200.withOpacity(.1)
                                : Colors.grey.shade200.withOpacity(.9),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.amber.shade200, width: 1.5),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 5,
              )
            ],
          ),
          field.hasError
              ? Positioned(
                  bottom: 0,
                  left: 5,
                  child: SizedBox(height: 12, child: Text(field.errorText ?? "", style: const TextStyle(fontSize: 10))))
              : const SizedBox(
                  height: 10,
                ),

          // const SizedBox(
          //   height: 7,
          // ),
        ],
      ),
    );
  }
}
