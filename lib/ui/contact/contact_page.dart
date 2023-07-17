import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:contact_app/data/model/contact_model.dart';
import 'package:contact_app/controller/contact_controller.dart';
import 'package:contact_app/extensions/validator/contact_validator.dart';

import 'package:easy_mask/easy_mask.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_validator/flutter_validator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<ContactController>(builder: (_) {
      List<String> birthdate =
          _.contactData.birthdate.substring(0, 10).split('-');
      return SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: BackButton(),
          ),
          _.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Center(
                      child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blue,
                          ),
                          child: _.contactData.image != ''
                              ? FittedBox(
                                  fit: BoxFit.fill,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: Image.file(
                                          File(_.contactData.image))))
                              : const Icon(
                                  Icons.person,
                                  size: 200,
                                  color: Colors.black54,
                                )),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Informações',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextInfo(
                      label: 'Nome',
                      data: _.contactData.name,
                    ),
                    const SizedBox(height: 10),
                    TextInfo(
                      label: 'Apelido',
                      data: _.contactData.nickname,
                    ),
                    const SizedBox(height: 10),
                    TextInfo(
                      label: 'Email',
                      data: _.contactData.email,
                    ),
                    const SizedBox(height: 10),
                    TextInfo(
                      label: 'Telefone',
                      data: _.contactData.telephone,
                    ),
                    const SizedBox(height: 10),
                    TextInfo(
                      label: 'Gênero',
                      data: _.contactData.gender,
                    ),
                    const SizedBox(height: 10),
                    TextInfo(
                      label: 'Data de nascimento',
                      data: _.contactData.birthdate != '${DateTime(0)}'
                          ? '${birthdate[2]}/${birthdate[1]}/${birthdate[0]}'
                          : '-',
                    ),
                    const SizedBox(height: 40),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditButton(),
                        SizedBox(width: 20),
                        DeleteButton(),
                      ],
                    )
                  ],
                ),
        ],
      ));
    }));
  }
}

class TextInfo extends StatelessWidget {
  const TextInfo({super.key, required this.label, required this.data});

  final String? label;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          "$data",
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}

class BackButton extends GetView<ContactController> {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {Get.back(result: true)},
      style: ButtonStyle(
          side: const MaterialStatePropertyAll<BorderSide>(
              BorderSide(width: 1, color: Color.fromRGBO(250, 250, 250, 1))),
          elevation: const MaterialStatePropertyAll<double>(5),
          backgroundColor: const MaterialStatePropertyAll<Color>(
              Color.fromRGBO(255, 255, 255, 1)),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Color.fromRGBO(250, 250, 250, 1), width: 1),
                  borderRadius: BorderRadius.circular(100)))),
      child: const SizedBox(
        height: 32,
        width: 50,
        child: Row(children: [
          Icon(Icons.arrow_back_ios,
              size: 15, color: Color.fromRGBO(109, 112, 112, 1)),
          Text('Voltar',
              style: TextStyle(
                  color: Color.fromRGBO(109, 112, 112, 1),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 12))
        ]),
      ),
    );
  }
}

class EditButton extends GetView<ContactController> {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        showBarModalBottomSheet(
            context: context, builder: (context) => const FormModal())
      },
      style: ButtonStyle(
        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.blue),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),
      child: const SizedBox(
        width: 100,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.edit, color: Colors.white),
          SizedBox(width: 5),
          Text(
            'Editar',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          )
        ]),
      ),
    );
  }
}

class DeleteButton extends GetView<ContactController> {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(builder: (_) {
      return ElevatedButton(
        onPressed: () {
          _.deleteContact(context);
        },
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll<Color>(Colors.red),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
        ),
        child: const SizedBox(
          width: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.delete, color: Colors.white),
            SizedBox(width: 5),
            Text(
              'Excluir',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            )
          ]),
        ),
      );
    });
  }
}

class FormModal extends GetView<ContactController> {
  const FormModal({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(
      builder: (_) {
        TextEditingController nameController = TextEditingController();
        TextEditingController nicknameController = TextEditingController();
        TextEditingController emailController = TextEditingController();
        TextEditingController telephoneController = TextEditingController();
        final keyForm = GlobalKey<FormState>();

        nameController.text = _.contactData.name;
        nicknameController.text = _.contactData.nickname;
        emailController.text = _.contactData.email;
        telephoneController.text = _.contactData.telephone;

        return Form(
          key: keyForm,
          child: ListView(padding: const EdgeInsets.all(20), children: [
            const Text(
              'Editar Contato',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              validator: const Validator().isNotEmpty(
                  message: 'O campo de nome completo é obrigatorio'),
              decoration: const InputDecoration(labelText: 'Nome Completo *'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: nicknameController,
              decoration: const InputDecoration(labelText: 'Apelido'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: emailController,
              validator: ContactValidator(const Validator()).isEmail(),
              decoration: const InputDecoration(labelText: 'Email *'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: telephoneController,
              inputFormatters: [
                TextInputMask(mask: ['(99) 9999-9999', '(99) 99999-9999'])
              ],
              validator: ContactValidator(const Validator()).isTelephone(),
              decoration: const InputDecoration(
                  labelText: 'Telefone *', hintText: '(DDD) xxxx-xxxx'),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gênero *',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                GetX<ContactController>(
                  builder: (_) {
                    return DropdownButton(
                      hint: const Text('Escolha o gênero'),
                      value: _.gender.isEmpty ? null : _.gender,
                      onChanged: (selected) => {_.gender = selected.toString()},
                      items: ['Masculino', 'Femenino', 'Outros']
                          .map(
                            (option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: _.birthdate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  newDate == null
                      ? _.birthdate = DateTime(0)
                      : _.birthdate = newDate;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Data de nascimento',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    GetX<ContactController>(
                      builder: (_) {
                        return Text(
                          _.birthdate == DateTime(0)
                              ? 'Escolha a data de nascimento'
                              : '${_.birthdate.day}/${_.birthdate.month}/${_.birthdate.year}',
                          style: const TextStyle(fontSize: 16),
                        );
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                _.image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: GetX<ContactController>(
                  builder: (_) {
                    return _.image.path != ''
                        ? Image.file(File(_.image.path))
                        : const Icon(Icons.photo);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              child: const Text('Editar'),
              onPressed: () {
                if (keyForm.currentState!.validate()) {
                  if (_.gender != '') {
                    ContactModel contact = ContactModel(
                        name: nameController.text,
                        nickname: nicknameController.text,
                        email: emailController.text,
                        telephone: telephoneController.text,
                        gender: _.gender,
                        birthdate: '${_.birthdate}',
                        image: _.image.path);
                    _.editContact(contact);
                    Get.back();
                    _.gender = '';
                    _.birthdate = DateTime(0);
                  }
                }
              },
            )
          ]),
        );
      },
    );
  }
}
