import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:contact_app/controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(builder: (_) {
      return SafeArea(
          child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shrinkWrap: true,
        children: [
          _.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _.contactList.length,
                  itemBuilder: (context, index) {
                    return ContactCard(
                      contact: _.contactList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                )
        ],
      ));
    }));
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});

  final Map<String, String> contact;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
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
            ));
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
    return GetBuilder<HomeController>(
      builder: (_) {
        return Text(
          "$label: $data",
          style: const TextStyle(
            fontSize: 16,
          ),
        );
      },
    );
  }
}
