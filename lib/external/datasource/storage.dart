import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:contact_app/infra/datasource/storage_abs.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageClient implements StorageClientAbs {
  StorageClient();

  Box<String>? contactBox;

  @override
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
    contactBox =
        await Hive.openBox<String>('contactList', encryptionCipher: cipher);
  }

  @override
  Future<List<String>> storageGetContacts() async {
    List<String> contactList = [];

    for (int i = 0; i < contactBox!.length; i++) {
      contactList.add(contactBox!.getAt(i)!);
    }

    return contactList;
  }

  @override
  Future storageAddContact(String contact) async {
    await contactBox!.put('${contactBox!.length}', contact);
  }

  @override
  Future<String?> storageGetSingleContact(String key) async {
    return contactBox!.get(key);
  }

  @override
  Future storageEditContact(String key, String contact) async {
    return await contactBox!.put(key, contact);
  }

  @override
  Future storageDeleteContact(String key) async {
    return await contactBox!.delete(key);
  }
}
