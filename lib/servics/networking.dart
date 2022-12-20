// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final url;

  NetworkHelper(this.url);

  Future getData() async {
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    // print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;
      print('');
      var decodedDAta = jsonDecode(data);
      print('decode data' + decodedDAta.toString());
      return decodedDAta;
    } else {
      print(response.statusCode);
    }
  }
}
