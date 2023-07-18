import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'package:contact_app/adapters/image_adapter.dart';
import 'package:contact_app/data/model/contact_model.dart';
import 'package:contact_app/data/repository/contact_repository.dart';

class HomeController extends GetxController {
  final ContactRepository? contactRepository;

  HomeController({@required this.contactRepository})
      : assert(contactRepository != null);

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
    await contactRepository?.initStorage();
  }

  Future<void> getContacts() async {
    contactList = [];
    contactList = await contactRepository?.getContacts();
  }

  Future<void> addContact(ContactModel contact) async {
    isLoading = true;
    update();
    await contactRepository?.addContact(contact);

    contactList.add(contact);
    isLoading = false;
    update();
  }
}
