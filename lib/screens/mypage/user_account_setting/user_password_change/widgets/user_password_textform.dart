import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:honbap_signal_flutter/constants/sizes.dart';

class UserPasswordTextForm extends StatefulWidget {
  final bool isLast;
  final String? hint;
  final FocusNode focusNode;
  final Function(String) onChange;
  final String? Function(String?) validator;
  final bool checkValidOnChange;
  final Function(String) onSubmit;

  const UserPasswordTextForm({
    super.key,
    this.isLast = false,
    this.hint,
    required this.focusNode,
    required this.onChange,
    required this.validator,
    this.checkValidOnChange = false,
    required this.onSubmit,
  });

  @override
  State<UserPasswordTextForm> createState() => _UserPasswordTextFormState();
}

class _UserPasswordTextFormState extends State<UserPasswordTextForm> {
  String _currValue = '';
  bool _obscureText = true;
  bool _isChanged = false;
  final _key = GlobalKey<FormFieldState<String>>();

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _onChange(String value) {
    _isChanged = true;
    _currValue = value;
    widget.onChange(value);

    if (widget.checkValidOnChange) {
      _key.currentState?.validate();
    }
  }

  void _checkValidate({
    bool nextFocus = false,
  }) {
    if (!_isChanged) return;

    // check validate
    _key.currentState?.validate();
    if (widget.validator(_currValue) != null) return;

    // submit value
    widget.onSubmit(_currValue);

    // change focus
    if (nextFocus) {
      FocusScope.of(context).nextFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size80,
      child: TextFormField(
        key: _key,
        focusNode: widget.focusNode,
        autocorrect: false,
        enableSuggestions: false,
        obscureText: _obscureText,
        textInputAction:
            widget.isLast ? TextInputAction.done : TextInputAction.next,
        style: const TextStyle(fontSize: Sizes.size16),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.labelMedium,
          suffixIcon: GestureDetector(
            onTap: _toggleObscureText,
            child: Container(
              width: Sizes.size28,
              height: Sizes.size28,
              alignment: Alignment.center,
              child: FaIcon(
                _obscureText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                color: Colors.grey.shade300,
                size: Sizes.size20,
              ),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        cursorColor: Theme.of(context).primaryColor,
        validator: (value) => widget.validator(value),
        onChanged: _onChange,
        onTap: () => _checkValidate(),
        onEditingComplete: () => _checkValidate(),
        onTapOutside: (_) => _checkValidate(),
        onFieldSubmitted: (_) => _checkValidate(nextFocus: true),
      ),
    );
  }
}
