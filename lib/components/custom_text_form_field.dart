import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final bool isPassword, enable;
  final TextInputType textInputType;
  final hint, onSave, validate;
  final TextEditingController? controller;
  final IconData? icon;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  CustomTextFormField(
      {this.isPassword = false,
      required this.hint,
      required this.onSave,
      this.icon,
      this.onChange,
      this.onFieldSubmitted,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.enable = true,
      this.controller,
      required this.validate});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  var secureText;

  @override
  void initState() {
    secureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontFamily: 'OpenSans',
          color: Color(0xff4a4749),
          fontSize: 14,
          letterSpacing: 0.8),
      controller: widget.controller,
      onSaved: widget.onSave,
      textInputAction: widget.textInputAction,
      enabled: widget.enable,
      validator: widget.validate,
      obscureText: secureText,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.textInputType,
      onChanged: widget.onChange,
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
          focusColor: Theme.of(context).colorScheme.secondary,
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffe9e9e9))),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color(0xffe9e9e9),
          )),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
          ),
          labelText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: widget.hint,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      secureText = !secureText;
                    });
                  },
                  icon: Icon(
                    secureText
                        ? CupertinoIcons.eye_slash_fill
                        : CupertinoIcons.eye_fill,
                    color: Colors.grey,
                  ))
              : Icon(widget.icon)),
    );
  }
}
