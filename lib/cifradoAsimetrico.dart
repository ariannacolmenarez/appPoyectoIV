// import 'dart:io';
// import 'package:encrypt/encrypt.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:rsa_encrypt/rsa_encrypt.dart';
// import 'package:pointycastle/asymmetric/pkcs1.dart';
// import 'package:pointycastle/api.dart';
// import 'package:pointycastle/asymmetric/api.dart';
// import 'package:pointycastle/asymmetric/rsa.dart';
// import 'package:pointycastle/key_generators/api.dart';
// import 'package:pointycastle/key_generators/rsa_key_generator.dart';
// import 'package:pointycastle/key_derivators/api.dart';
// import 'package:pointycastle/key_derivators/pbkdf2.dart';
// import 'package:pointycastle/digests/sha256.dart';
//
// // Supongamos que privateKeyString y publicKeyString son tus claves en formato de cadena.
//  getKey() async {
//   var url = 'https://joseviveresmarket.000webhostapp.com/login?api';
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     var keys = jsonDecode(response.body);
//     String publicKey = keys['publicKey'];
//     print(publicKey);
//   } else {
//     throw Exception('Failed to load keys');
//   }
// }
// // Crear el codificador/decodificador PKCS1
// // final rsaPKCS1 = new RSAKeyParser();
// //
// // // Parsear la clave privada y pública
// // RSAPrivateKey privateKey = rsaPKCS1.parse(privateKeyString) as RSAPrivateKey;
// // RSAPublicKey publicKey = rsaPKCS1.parse(publicKeyString) as RSAPublicKey;
// //
// void encrypted(data,publicKey) {
//   String encrypted = RsaKeyHelper().encrypt(data, publicKey);
// }
// //
// // void decrypted(List<String> args) {
// //   final privKey = RSAKeyParser().parse(File('private.pem').readAsStringSync());
// //   final encrypted = Encrypted.fromBase64(args[0]);
// //   final encrypter = Encrypter(RSA(privateKey: privKey));
// //   final decrypted = encrypter.decrypt(encrypted);
// //   print(decrypted);
// // }