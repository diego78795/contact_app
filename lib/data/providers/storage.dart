import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:contact_app/data/model/contact_model.dart';
import 'package:contact_app/adapters/contact_hive_adapter.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageClient {
  StorageClient() {
    initStorage();
  }

  Box<ContactModel>? contactBox;

  Future initStorage() async {
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

    Hive.registerAdapter(ContactHiveAdapter());
    contactBox = await Hive.openBox<ContactModel>('contactList',
        encryptionCipher: cipher);
  }

  Future<List<ContactModel>> storageGetContacts() async {
    List<ContactModel> contactList = [];

    for (int i = 0; i < contactBox!.length; i++) {
      contactList.add(contactBox!.getAt(i)!);
    }

    return contactList;
  }

  Future storageAddContact(ContactModel contact) async {
    await contactBox!.put('${contactBox!.length}', contact);
  }
}
