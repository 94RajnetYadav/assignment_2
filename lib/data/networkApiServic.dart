import 'dart:developer';

import 'package:http/http.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

getApiServic(int page, int limit) async {
  log("count:--" + page.toString());
  var request = http.Request('GET',
      Uri.parse('https://api.punkapi.com/v2/beers?page=$page&per_page=$limit'));
  request.body = '''''';

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var jasondata = await response.stream.bytesToString();
    return jasondata;
    // log("data13:--" + jasondata);
  } else {
    print(response.reasonPhrase);
  }
}
