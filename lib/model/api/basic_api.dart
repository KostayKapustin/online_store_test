import 'dart:convert';

import 'package:http/http.dart' as http;

const API_KEY =
    'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
const API_DOMAIN = 'ostest.whitetigersoft.ru';

class BasicApi {

  Future<dynamic> sendGetRequest({
    Map<String, String>? params,
    String? offset,
    required String relativeUrl,
  }) async {
    var url = Uri.http(
        API_DOMAIN, relativeUrl, params);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
  return data['data'];
  }
}
