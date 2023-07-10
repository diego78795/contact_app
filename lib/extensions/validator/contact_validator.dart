import 'package:flutter_validator/flutter_validator.dart';

extension ContactValidator on Validator {
  Validator isEmail() {
    return copy()
        .isNotEmpty(
          message: "O campo de email é obrigatorio",
        )
        .matches(
          RegExp(r"^[[:ascii:]]*[@][[:ascii:]]*$"),
          message: "O email digitado é invalido",
        );
  }

  Validator isTelephone() {
    return copy()
        .isNotEmpty(
          message: "O campo de telefone é obrigatorio",
        )
        .matches(
          RegExp(r"^[(][0-9]{2}[)]\s9?[0-9]{4}[-][0-9]{4}$"),
          message: "O telefone digitado é invalido",
        );
  }
}
