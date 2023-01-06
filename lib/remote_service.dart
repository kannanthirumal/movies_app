import 'dart:convert';

import 'package:movies_app/trending_movies.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Result>> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=598cccd550155392894cf5619a913cfc');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return trendingMoviesFromJson(json);
    } else {
      throw Exception("Failed to fetch trending movies");
    }
  }

}

class RemoteService2 {
  Future<List<Result>> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=598cccd550155392894cf5619a913cfc');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return trendingMoviesFromJson(json);
    } else {
      throw Exception("Failed to fetch trending movies");
    }
  }

}

class RemoteService3 {
  Future<List<Result>> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=598cccd550155392894cf5619a913cfc');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return trendingMoviesFromJson(json);
    } else {
      throw Exception("Failed to fetch trending movies");
    }
  }

}