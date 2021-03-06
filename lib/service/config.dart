import 'dart:io';
import 'package:http/http.dart' as http;

class connect {
    String url = "http://192.168.20.88:3000/";
    var header = {HttpHeaders.contentTypeHeader: "application/json"};

  Future<http.Response> get(route) async {
    return  http.get(Uri.parse(url + route), headers: header);
  }

    Future<http.Response> post(route,data) async {
      return  http.post(Uri.parse(url + route), headers: header,body: data);
    }

    Future<http.Response> put(route,data) async {
      return  http.put(Uri.parse(url + route), headers: header,body: data);
    }

    Future<http.Response> delete(route) async {
      return  http.delete(Uri.parse(url + route), headers: header);
    }
}
