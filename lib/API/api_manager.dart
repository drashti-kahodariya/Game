import 'package:game/API/custom_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';


class APIManager {

  Future<dynamic> getAPICall(String url) async {
    print("Calling API: $url");

    var responseJson;
    try {
      final response =  await http.get(Uri.parse(url));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postAPICall(String url, Map param) async {
    print("Calling API: $url");
    print("Calling parameters: $param");
    var responseJson;
    try {
      final response =  await http.post(Uri.parse(url),
          body: param);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}