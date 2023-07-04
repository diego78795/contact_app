import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:contact_app/routes/app_pages.dart';
import 'package:contact_app/controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(builder: (_) {
      return SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          shrinkWrap: true,
          children: [
            const Align(alignment: Alignment.topRight, child: AddButton()),
            _.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _.contactList.length,
                    itemBuilder: (context, index) {
                      return ContactCard(
                        keyContact: index,
                        contact: _.contactList[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                  )
          ],
        ),
      );
    }));
  }
}

class AddButton extends GetView<HomeController> {
  const AddButton({super.key});

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
        width: 160,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.add, color: Colors.white),
          Text(
            'Adicionar contato',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
          )
        ]),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard(
      {super.key, required this.contact, required this.keyContact});

  final int keyContact;
  final Map contact;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return GestureDetector(
            onTap: () => {
                  Get.toNamed(Routes.contact, arguments: {'key': '$keyContact'})
                },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextInfo(
                          label: 'Nome',
                          data: contact['name'],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextInfo(
                          label: 'Telefone',
                          data: contact['telephone'],
                        )
                      ],
                    )
                  ],
                )));
      },
    );
  }
}

class TextInfo extends StatelessWidget {
  const TextInfo({super.key, required this.label, required this.data});

  final String? label;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$label: $data",
      style: const TextStyle(
        fontSize: 16,
      ),
    );
  }
}

class FormModal extends GetView<HomeController> {
  const FormModal({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        TextEditingController nameController = TextEditingController();
        TextEditingController emailController = TextEditingController();
        TextEditingController telephoneController = TextEditingController();
        TextEditingController birthdateController = TextEditingController();

        return Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Adicionar Contato',
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
                      child: const Text('Adicionar'),
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
                          _.addContact(nameController.text, contact);
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
