import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  HomeController();

  bool isLoading = true;
  List<Map> contactList = [];

  final _date = DateTime(0).obs;
  get date => _date.value;
  set date(value) => _date.value = value;

  final _image = XFile('').obs;
  get image => _image.value;
  set image(value) => _image.value = value;

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
    contactList = [];
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

  Future<void> addContact(Map contact) async {
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
