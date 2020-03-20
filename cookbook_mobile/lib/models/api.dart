library api;

import 'package:http/http.dart' as http;
import 'dart:convert';

part 'user.dart';
part 'cookbook.dart';
part 'invite.dart';


class HTTPInterface {
  static const _baseUrl = "http://localhost:4000/api";

  static Map<String, String> _headers = {"Content-Type": "Application/JSON"};

  static Future<http.Response> get(url) => http.get(
        _baseUrl + url,
        headers: _headers,
      );

  static Future<T> post<T>(String url, Map body,
      [_DecodableConstructor<T> _decoder]) async {
    final response = await http.post(
      _baseUrl + url,
      body: json.encode(body),
      headers: _headers,
    );

    if (_decoder == null)
      return null;
    else
      return _decoder(parseContent(response));
  }

  static Map parseContent(http.Response response) {
    final body = response.body;

    if ([200, 204].contains(response.statusCode)) {
      final parsed = json.decode(body);
      if (!(parsed is Map)) throw "Bad content";
      return parsed;
    } else if (body is String) {
      throw body;
    } else {
      throw "Request error";
    }
  }
}

typedef T _DecodableConstructor<T>(Map content);

class JsonListMaker {
  static List convert<T>(_DecodableConstructor<T> maker, List content) =>
      content.map<T>((obj) => maker(obj)).toList();
}

class Auth {
  static Future login(String email, String password) async {
    final result = await HTTPInterface.post(
        '/login', {"email": email, "password": password}, _fromJson);

    return result;
  }

  static Auth _fromJson(Map content) {
    final token = content['token'];
    HTTPInterface._headers['Authorization'] = 'Bearer ' + token;
    User._fromJson(content);

    return Auth();
  }
}

DateTime _dateParser(String date) => date == null ? null : DateTime.parse(date);
