import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget title,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autoValidate = false})
      : super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    builder: (field) {
      return Checkbox(
        value: field.value,
        onChanged: (value) {
          field.didChange(value);
        },
      );
    },
  );
}