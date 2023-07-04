import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            )
          ],
        ),
      );
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
      onPressed: () => {Get.back()},
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
