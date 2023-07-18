import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'package:contact_app/adapters/image_adapter.dart';
import 'package:contact_app/domain/model/contact_model.dart';

import 'package:contact_app/domain/usecase/contact_cases.dart';

class HomeController extends GetxController {
  final ContactCases? contactCases;

  HomeController({
    @required this.contactCases,
  }) : assert(contactCases != null);

  bool isLoading = true;
  List<ContactModel> contactList = [];

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
  void onInit() {
    fetchData();
    super.onInit();
  }

  fetchData() async {
    await initStorage();
    await getContacts();
    isLoading = false;
    update();
  }

  Future<void> initStorage() async {
    await contactCases!.initStorage();
  }

  Future<void> getContacts() async {
    contactList = [];
    contactList = await contactCases!.getContacts();
  }

  Future<void> addContact(ContactModel contact) async {
    isLoading = true;
    update();
    await contactCases!.addContact(contact);

    contactList.add(contact);
    isLoading = false;
    update();
  }
}
