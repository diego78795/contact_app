import 'package:flutter_validator/flutter_validator.dart';

extension ContactValidator on Validator {
  Validator isEmail() {
    return copy()
        .isNotEmpty(
          message: "O campo de email é obrigatorio",
        )
        .matches(
          RegExp(r"^[a-zA-Z]*[@][a-zA-Z]*$"),
          message: "O email digitado é invalido",
        );
  }
}
