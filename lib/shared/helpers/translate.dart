import 'dart:convert';

import 'package:smart_city/main.dart';

Future<String> translate(String text, {String lang = 'ro'}) async {
  final response = await supabase.functions
      .invoke('translate', body: {'text': text, 'lang': lang});

  return utf8.decode(base64.decode(response.data));
}
