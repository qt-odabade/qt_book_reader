import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class EncryptService {
  static final EncryptService _encryptService = EncryptService._internal();

  EncryptService._internal();

  static EncryptService get instance => _encryptService;

  late Encrypter encrypter;

  final iv = IV.fromLength(16);

  void init() {
    encrypter =
        Encrypter(AES(Key.fromUtf8("Some Key of length 32...........")));
  }

  /// Gets the Encrypted bytes.
  Uint8List encryptBytes({required List<int> bytes}) {
    return encrypter.encryptBytes(bytes, iv: iv).bytes;
  }

  List<int> decryptBytes({required Uint8List encryptedBytes}) {
    return encrypter.decryptBytes(Encrypted(encryptedBytes), iv: iv);
  }

  String decrypt({required Uint8List encryptedBytes}) {
    return encrypter.decrypt(Encrypted(encryptedBytes), iv: iv);
  }
}
