//class to implement asynchronous function for http requests, using http package.

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    try{http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }else {
      print('statusCode: ${response.statusCode}');
      return response.statusCode;
    }}
    catch(e){
      print('getData: ${e}');
    }
  }
}