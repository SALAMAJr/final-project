import 'dart:convert';
import 'package:famous_project/models/famous_model.dart';
import 'package:http/http.dart' as http;

import '../models/person_detail.dart';

class ApiService {
  static const String apiKey = '2dfe23358236069710a379edd4c65a6b';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<FamousPerson>> getPopularPersons() async {
    final response =
        await http.get(Uri.parse('$baseUrl/person/popular?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((json) => FamousPerson.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load popular persons');
    }
  }

  static Future<PersonDetail> getPersonDetail(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/person/$id?api_key=$apiKey'));

    if (response.statusCode == 200) {
      return PersonDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load person details');
    }
  }

  static Future<List<String>> getPersonImages(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/person/$id/images?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['profiles'];
      return data.map((json) => json['file_path'] as String).toList();
    } else {
      throw Exception('Failed to load person images');
    }
  }
}
