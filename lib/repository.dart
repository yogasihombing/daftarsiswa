// import 'dart:convert';
// import 'dart:math';

// import 'package:daftar_siswa2/model.dart';
import 'dart:convert';
import 'dart:math';

import 'package:daftar_siswa2/model.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'https://nabasa.co.id/topan/index.php/';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/getSiswa'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body)['data'];
        List<Blog> blog = it.map((e) => Blog.fromJson(e)).toList();
        return blog;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String nis, String nama, String jenis_kelamin, String telp,
      String alamat) async {
    try {
      final response =
          await http.post(Uri.parse(_baseUrl + '/insertSiswa'), body: {
        "nis": nis,
        "nama": nama,
        "jenis_kelamin": jenis_kelamin,
        "telp": telp,
        "alamat": alamat,
      });
      print(response);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String nis) async {
    //kalo disini async berarti di main.dart juga harus
    try {
      final response =
          await http.post(Uri.parse(_baseUrl + '/deleteSiswa'), body: {
        "nis": nis,
      });
      print(response);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateData(String nis, String nama, String jenis_kelamin, String telp,
      String alamat) async {
    try {
      final response =
          await http.post(Uri.parse('$_baseUrl/updateSiswa'), body: {
        "nis": nis,
        "nama": nama,
        "jenis_kelamin": jenis_kelamin,
        "telp": telp,
        "alamat": alamat,
      });
      print(response);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
