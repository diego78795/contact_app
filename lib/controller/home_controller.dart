import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeController extends GetxController {
  HomeController();

  bool isLoading = true;
  List<Map> contactList = [];

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
    await Hive.initFlutter();

    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? verificationKey = await secureStorage.read(key: 'key');
    if (verificationKey == null) {
      final List<int> key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }

    final String? key = await secureStorage.read(key: 'key');
    final Uint8List decodeKey = base64Url.decode(key!);
    HiveAesCipher cipher = HiveAesCipher(decodeKey);

    final Box<Map> contactBox =
        await Hive.openBox<Map>('contactList', encryptionCipher: cipher);

    for (int i = 0; i < contactBox.length; i++) {
      contactList.add(contactBox.getAt(i)!);
    }
  }

  Future<void> addContact(String name, Map contact) async {
    isLoading = true;
    update();
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final String? key = await secureStorage.read(key: 'key');
    final Uint8List decodeKey = base64Url.decode(key!);
    HiveAesCipher cipher = HiveAesCipher(decodeKey);

    final Box<Map> contactBox =
        await Hive.openBox<Map>('contactList', encryptionCipher: cipher);

    await contactBox.put('${contactBox.length}', contact);

    contactList.add(contact);
    isLoading = false;
    update();
  }
}
