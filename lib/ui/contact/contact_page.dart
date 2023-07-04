import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:contact_app/controller/contact_controller.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<ContactController>(builder: (_) {
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
                      ),
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
                      data: _.contactData['name'],
                    ),
                    const SizedBox(height: 10),
                    TextInfo(
                      label: 'Email',
                      data: _.contactData['email'],
                    ),
                    const SizedBox(height: 10),
                    TextInfo(
                      label: 'Telefone',
                      data: _.contactData['telephone'],
                    ),
                    const SizedBox(height: 10),
                    TextInfo(
                      label: 'Data de nascimento',
                      data: _.contactData['birthdate'] != ''
                          ? _.contactData['birthdate']
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
      onPressed: () => {Navigator.pop(context, true)},
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
        TextEditingController emailController = TextEditingController();
        TextEditingController telephoneController = TextEditingController();
        TextEditingController birthdateController = TextEditingController();

        nameController.text = _.contactData['name'];
        emailController.text = _.contactData['email'];
        telephoneController.text = _.contactData['telephone'];
        birthdateController.text = _.contactData['birthdate'];

        return Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Editar Contato',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(labelText: 'Nome Completo *'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email *'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: telephoneController,
                      decoration: const InputDecoration(
                          labelText: 'Telefone *', hintText: '(DDD) xxxx-xxxx'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: birthdateController,
                      decoration: const InputDecoration(
                          labelText: 'Data de nascimento',
                          hintText: 'dd/mm/aaaa'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      child: const Text('Editar'),
                      onPressed: () {
                        if (nameController.text != '' ||
                            emailController.text != '' ||
                            telephoneController.text != '') {
                          Map<String, String> contact = {
                            'name': nameController.text,
                            'email': emailController.text,
                            'telephone': telephoneController.text,
                            'birthdate': birthdateController.text,
                          };
                          _.editContact(contact);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ]),
            ));
      },
    );
  }
}
