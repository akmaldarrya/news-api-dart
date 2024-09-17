import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class HttpService {
  final String postsUrl = "https://api-berita-indonesia.vercel.app/antara/terbaru";

  Future<ApiResponse> getPosts() async {
    final response = await http.get(Uri.parse(postsUrl));

    if (response.statusCode == 200) {
      // Pastikan parsing JSON mengembalikan ApiResponse
      return ApiResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable to retrieve posts.");
    }
  }
}
