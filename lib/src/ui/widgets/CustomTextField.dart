import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokdex/src/cubit/utility/Validations.dart';
import 'package:pokdex/src/ui/ui_constant/theme/AppColors.dart';
import 'package:pokdex/src/ui/ui_constant/theme/string.dart';

import '../../AppLocalizations.dart';

class CustomTextField extends StatelessWidget {
  String? labelText;
  TextInputType textInputType;
  VALIDATION_TYPE validationType;
  IconData icon;
  TextEditingController controller;
  bool obscureText, isEnabled, isAppColorEnable;
  VoidCallback onPasswordVisiblityChange;
  Function onKeyPressed;
  double width;

  CustomTextField(
      this.labelText,
      this.textInputType,
      this.validationType,
      this.icon,
      this.controller,
      this.obscureText,
      this.onPasswordVisiblityChange,
      {required this.isEnabled,
      required this.isAppColorEnable,
      required this.width,
      required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: isAppColorEnable
            ? AppColors.dropDownItems.withOpacity(0.6)
            : Colors.grey[500]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: FormBuilderTextField(
          name: labelText!,
          enabled: (isEnabled != false ? isEnabled : true),
          controller: controller,
          enableInteractiveSelection: true,
          obscureText: obscureText,
          style: isAppColorEnable
              ? Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: AppColors.black.withOpacity(0.6))
              : Theme.of(context).textTheme.headline2,
          keyboardType: textInputType,
          decoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(
              icon,
              color: isAppColorEnable ? AppColors.black : AppColors.timberWolf,
            ),
            suffixIcon: IconButton(
              icon: checkForVisiblityIcon(),
              onPressed: onPasswordVisiblityChange,
            ),
            labelText: labelText,
            labelStyle: isAppColorEnable
                ? Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: AppColors.black.withOpacity(0.6))
                : Theme.of(context).textTheme.headline2,
            contentPadding: EdgeInsets.fromLTRB(15.0, 16.0, 15.0, 16.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isAppColorEnable ? Colors.grey : AppColors.timberWolf,
                  width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          // validator: (value) => checkFieldValidation(
          //     val: value,
          //     password: '',
          //     fieldName:
          //         "${AppLocalizations.of(context)!.translate(Strings.PLEASE_ENTER_TEXT)} $labelText ",
          //     fieldType: validationType,
          //     context: context),
          inputFormatters: [
            if (validationType == VALIDATION_TYPE.NAME)
              FilteringTextInputFormatter(RegExp("[a-zA-Z]"), allow: true),
          ],
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
            if (validationType == VALIDATION_TYPE.EMAIL)
              FormBuilderValidators.email(context),
          ]),
          // onFieldSubmitted: (value) => {onKeyPressed()},
        ),
      ),
    );
  }

  Widget checkForVisiblityIcon() {
    if (validationType == VALIDATION_TYPE.PASSWORD) {
      if (obscureText) {
        return Icon(
          Icons.visibility_off,
          color: isAppColorEnable ? AppColors.black : AppColors.timberWolf,
        );
      } else {
        return Icon(
          Icons.visibility,
          color: isAppColorEnable ? AppColors.black : AppColors.timberWolf,
        );
      }
    } else {
      return Container();
    }
  }
}
