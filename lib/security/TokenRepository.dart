import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

Future<void> saveToken(String token) async {
    var containsEncryptionKey = await secureStorage.containsKey(key: 'key');

    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(
          key: 'key',
          value: base64UrlEncode(key));
    }

    var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));

    var encryptedBox = await Hive.openBox(
        'tokenBox',
        encryptionCipher: HiveAesCipher(encryptionKey));
    encryptedBox.put('token', token);
}

Future<String> getToken() async {
  
  var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));

  var encryptedBox = await Hive.openBox(
      'tokenBox',
      encryptionCipher: HiveAesCipher(encryptionKey));

  return encryptedBox.get('token');
}

Future<void> deleteToken() async {

  var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key'));

  var encryptedBox = await Hive.openBox(
      'tokenBox',
      encryptionCipher: HiveAesCipher(encryptionKey));

  encryptedBox.delete('token');
}