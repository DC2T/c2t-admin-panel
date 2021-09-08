import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<FinalResponseGetMovie> fetchMovie(int page, int per_page) async {
  final response = await http.get(
      Uri.parse(
          'http://localhost:5004/api/v1/movie/show/ ?page=$page&per_page=$per_page'),
      headers: {
        "Origin": "http://www.daophim.ru",
      });

  if (response.statusCode == 200) {
    ResponseGetMovie res = ResponseGetMovie.fromJson(jsonDecode(response.body));
    final jsonData = res.data;
    String message = res.message;

    if (message == 'success') {
      DataMovie dataMovie = DataMovie.fromJson(jsonData);
      var jsonMovie = dataMovie.data;
      int pageResult = dataMovie.page;
      int totalRowResult = dataMovie.totalRow;
      List<Movie> moviesResult = [];

      for (var m in jsonMovie) {
        moviesResult.add(Movie(
          id: m["_id"],
          title: m["title"],
          slug: m["slug"],
          status: m["status"],
          photo: m["photo"],
          runtime: m["runtime"],
          driveId: m["driveId"],
          pId: m["pId"],
          form: m["form"],
          views: m["views"],
          pointVoted: m["pointVoted"],
        ));
      }

      return FinalResponseGetMovie(
        page: pageResult,
        totalRow: totalRowResult,
        movies: moviesResult,
      );
    }
  } else {
    throw Exception('Failed to load movie');
  }
}

Future<ResponseDelMovie> deleteMovie(String id) async {
  final url = Uri.parse('http://localhost:5004/api/v1/movie/delete/$id');
  final http.Response response = await http.delete(
    url,
    headers: <String, String>{
      "Method":"DELETE",
      "Origin": "http://localhost:9000",
      "Accept": "application/json",
      "Access-Control_Allow_Origin" : "*",
    },
  );

  print(response.body);
  if (response.statusCode == 200) {
    return ResponseDelMovie.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete movie.');
  }
}

class FinalResponseGetMovie {
  final int page;
  final int totalRow;
  final List<Movie> movies;

  FinalResponseGetMovie({
    this.page,
    this.totalRow,
    this.movies,
  });
}

class ResponseGetMovie {
  final String message;
  final data;

  ResponseGetMovie({
    this.message,
    this.data,
  });

  factory ResponseGetMovie.fromJson(Map<String, dynamic> json) {
    return ResponseGetMovie(
      message: json["message"],
      data: json["data"],
    );
  }
}

class ResponseDelMovie {
  final String message;

  ResponseDelMovie({
    this.message,
  });

  factory ResponseDelMovie.fromJson(Map<String, dynamic> json) {
    return ResponseDelMovie(message: json['message']);
  }
}

class DataMovie {
  final int page;
  final int totalRow;
  final data;

  DataMovie({
    this.page,
    this.totalRow,
    this.data,
  });

  factory DataMovie.fromJson(Map<String, dynamic> json) {
    return DataMovie(
      page: json["page"],
      totalRow: json["totalRows"],
      data: json["data"],
    );
  }
}

class Movie {
  final String id,
      title,
      subtitle,
      slug,
      status,
      photo,
      runtime,
      driveId,
      pId,
      releaseDate,
      releaseYear,
      from,
      trailer,
      nEpisodes,
      storyLine,
      createAt,
      updateAt;
  final bool form;
  final int views;
  final double pointVoted;
  final List stars, directors, keywords, categories, countries, languages, fIds;
  Movie({
    this.id,
    this.title,
    this.slug,
    this.form,
    this.status,
    this.photo,
    this.subtitle,
    this.from,
    this.trailer,
    this.nEpisodes,
    this.views,
    this.pointVoted,
    this.releaseDate,
    this.releaseYear,
    this.storyLine,
    this.stars,
    this.directors,
    this.keywords,
    this.categories,
    this.countries,
    this.languages,
    this.pId,
    this.fIds,
    this.driveId,
    this.runtime,
    this.createAt,
    this.updateAt,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["_id"],
      title: json["title"],
      slug: json["slug"],
      form: json["form"],
      status: json["status"],
      photo: json["photo"],
      subtitle: json["subTitle"],
      from: json["from"],
      trailer: json["trailer"],
      nEpisodes: json["nEpisodes"],
      views: json["views"],
      pointVoted: json["pointVoted"],
      releaseDate: json["releaseDate"],
      releaseYear: json["releaseYear"],
      storyLine: json["storyLine"],
      stars: json["stars"],
      directors: json["directors"],
      keywords: json["keywords"],
      categories: json["categories"],
      countries: json["countries"],
      languages: json["languages"],
      pId: json["pId"],
      driveId: json["driveId"],
      runtime: json["runtime"],
      createAt: json["createAt"],
      updateAt: json["updateAt"],
    );
  }
}
