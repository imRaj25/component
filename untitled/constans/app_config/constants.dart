import 'dart:math';

String googleApiKey = "";

String getRandomString({int length = 5}) {
  var chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  var random = Random();
  var randomString = String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  return randomString;
}
