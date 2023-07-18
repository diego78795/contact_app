import 'package:contact_app/domain/usecase/init_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'package:contact_app/adapters/image_adapter.dart';
import 'package:contact_app/domain/model/contact_model.dart';

import 'package:contact_app/domain/usecase/add_contact.dart';
import 'package:contact_app/domain/usecase/get_all_contacts.dart';

class HomeController extends GetxController {
  final InitStorage? initStorageCase;
  final AddContact? addContactCase;
  final GetAllContacts? getAllContactsCase;

  HomeController(
      {@required this.initStorageCase,
      @required this.addContactCase,
      @required this.getAllContactsCase})
      : assert(initStorageCase != null, getAllContactsCase != null);

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
    await initStorageCase!();
  }

  Future<void> getContacts() async {
    contactList = [];
    contactList = await getAllContactsCase!();
  }

  Future<void> addContact(ContactModel contact) async {
    isLoading = true;
    update();
    await addContactCase!(contact);

    contactList.add(contact);
    isLoading = false;
    update();
  }
}
