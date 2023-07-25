import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:contact_app/adapters/image_adapter.dart';
import 'package:contact_app/domain/entity/contact_entity.dart';

import 'package:contact_app/domain/usecase/edit_contact_use_case.dart';
import 'package:contact_app/domain/usecase/delete_contact_use_case.dart';
import 'package:contact_app/domain/usecase/get_single_contact_use_case.dart';

import 'package:contact_app/domain/usecase/init_storage_use_case.dart';

class ContactController extends GetxController {
  final InitStorageUseCase? initStorageUseCase;
  final GetSingleContactUseCase? getSingleContactUseCases;
  final EditContactUseCase? editContactUseCases;
  final DeleteContactUseCase? deleteContactUseCases;

  ContactController(
      {@required this.initStorageUseCase,
      @required this.getSingleContactUseCases,
      @required this.editContactUseCases,
      @required this.deleteContactUseCases})
      : assert(initStorageUseCase != null, deleteContactUseCases != null);

  final String keyContact = Get.arguments['key'];

  bool isLoading = true;
  ContactEntity contactData =
      ContactEntity('', '', '', '', '', 'xx-xx-xxxx', '');

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
    await initStorageUseCase!.initStorage();
  }

  Future<void> getSingleContact() async {
    ContactEntity? res =
        await getSingleContactUseCases!.getSingleContact(keyContact);

    if (res != null) {
      contactData = res;
      gender = contactData.gender;
      birthdate = DateTime.tryParse(contactData.birthdate);
      image = ImageAdapter(contactData.image);
    }
  }

  Future<void> editContact(ContactEntity contact) async {
    isLoading = true;
    update();

    await editContactUseCases!.editContact(keyContact, contact);

    contactData = contact;
    isLoading = false;
    update();
  }

  Future<void> deleteContact(BuildContext context) async {
    isLoading = true;
    update();

    await deleteContactUseCases!.deleteContact(keyContact).then((value) {
      Get.back(result: true);
    });
  }
}
