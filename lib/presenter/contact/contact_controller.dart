import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:contact_app/adapters/image_adapter.dart';
import 'package:contact_app/domain/model/contact_model.dart';

import 'package:contact_app/domain/usecase/edit_contact.dart';
import 'package:contact_app/domain/usecase/init_storage.dart';
import 'package:contact_app/domain/usecase/delete_contact.dart';
import 'package:contact_app/domain/usecase/get_single_contact.dart';

class ContactController extends GetxController {
  final InitStorage? initStorageCase;
  final GetSingleContact? getSingleContactCase;
  final EditContact? editContactCase;
  final DeleteContact? deleteContactCase;

  ContactController(
      {@required this.initStorageCase,
      @required this.getSingleContactCase,
      @required this.editContactCase,
      @required this.deleteContactCase})
      : assert(initStorageCase != null, getSingleContactCase != null);

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
    await initStorageCase!();
  }

  Future<void> getSingleContact() async {
    ContactModel? res = await getSingleContactCase!(keyContact);

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

    await editContactCase!(keyContact, contact);

    contactData = contact;
    isLoading = false;
    update();
  }

  Future<void> deleteContact(BuildContext context) async {
    isLoading = true;
    update();

    await deleteContactCase!(keyContact).then((value) {
      Get.back(result: true);
    });
  }
}
