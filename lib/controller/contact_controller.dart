import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContactController extends GetxController {
  ContactController();

  bool isLoading = true;
  Map contactData = {};

  final _gender = ''.obs;
  get gender => _gender.value;
  set gender(value) => _gender.value = value;

  final _birthdate = DateTime(0).obs;
  get birthdate => _birthdate.value;
  set birthdate(value) => _birthdate.value = value;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  fetchData() async {
    await initStorage();
    isLoading = false;
    update();
  }

  Future<void> initStorage() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final String? key = await secureStorage.read(key: 'key');
    final Uint8List decodeKey = base64Url.decode(key!);
    HiveAesCipher cipher = HiveAesCipher(decodeKey);

    final Box<Map> contactBox =
        await Hive.openBox<Map>('contactList', encryptionCipher: cipher);

    Map? res = contactBox.get(Get.arguments['key']);
    if (res != null) {
      contactData = res;
      gender = contactData['gender'];
      birthdate = DateTime.tryParse(contactData['birthdate']);
    }
  }

  Future<void> editContact(Map contact) async {
    isLoading = true;
    update();
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final String? key = await secureStorage.read(key: 'key');
    final Uint8List decodeKey = base64Url.decode(key!);
    HiveAesCipher cipher = HiveAesCipher(decodeKey);

    final Box<Map> contactBox =
        await Hive.openBox<Map>('contactList', encryptionCipher: cipher);

    await contactBox.put(Get.arguments['key'], contact);

    contactData = contact;
    isLoading = false;
    update();
  }

  Future<void> deleteContact(BuildContext context) async {
    isLoading = true;
    update();
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final String? key = await secureStorage.read(key: 'key');
    final Uint8List decodeKey = base64Url.decode(key!);
    HiveAesCipher cipher = HiveAesCipher(decodeKey);

    final Box<Map> contactBox =
        await Hive.openBox<Map>('contactList', encryptionCipher: cipher);

    await contactBox.delete(Get.arguments['key']).then((value) {
      Navigator.pop(context, true);
    });
  }
}
