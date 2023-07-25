import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:contact_app/adapters/image_adapter.dart';
import 'package:contact_app/data/model/contact_model.dart';
import 'package:contact_app/data/repository/contact_repository.dart';

class ContactController extends GetxController {
  final ContactRepository? contactRepository;
  ContactController({@required this.contactRepository})
      : assert(contactRepository != null);

  final String keyContact = Get.arguments['key'];

  bool isLoading = true;
  ContactModel contactData = ContactModel(
      name: '',
      nickname: '',
      email: '',
      telephone: '',
      gender: '',
      birthdate: '',
      image: '');

  final _gender = ''.obs;
  get gender => _gender.value;
  set gender(value) => _gender.value = value;

  final _birthdate = DateTime(0).obs;
  get birthdate => _birthdate.value;
  set birthdate(value) => _birthdate.value = value;

  final _image = ImageAdapter('').obs;
  get image => _image.value;
  set image(value) => _image.value = value;

  @override
  void onInit() async {
    await fetchData();
    super.onInit();
  }

  fetchData() async {
    await initStorage();
    await getSingleContact();
    isLoading = false;
    update();
  }

  Future<void> initStorage() async {
    await contactRepository?.initStorage();
  }

  Future<void> getSingleContact() async {
    ContactModel? res = await contactRepository?.getSingleContact(keyContact);

    if (res != null) {
      contactData = res;
      gender = contactData.gender;
      birthdate = DateTime.tryParse(contactData.birthdate);
      image = ImageAdapter(contactData.image);
    }
  }

  Future<void> editContact(ContactModel contact) async {
    isLoading = true;
    update();

    await contactRepository?.editContact(keyContact, contact);

    contactData = contact;
    isLoading = false;
    update();
  }

  Future<void> deleteContact(BuildContext context) async {
    isLoading = true;
    update();

    await contactRepository?.deleteContact(keyContact).then((value) {
      Get.back(result: true);
    });
  }
}
