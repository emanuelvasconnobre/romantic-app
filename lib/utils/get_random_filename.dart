import 'dart:convert';
import 'dart:math';

String getRandomFileName() {
  var randomSerure = Random.secure();
  var random = List<int>.generate(32, (i) => randomSerure.nextInt(256));

  var verificador = base64Url.encode(random);
  verificador = verificador.replaceAll('+', '-')
      .replaceAll('/', '_')
      .replaceAll('=', '');

  var base64ToSha256 = utf8.encode(verificador);
  var desafio = base64Url.encode(base64ToSha256);

  return desafio;
}