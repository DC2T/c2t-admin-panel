import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<FinalResponse> fetchMovie(int page, int per_page) async {
  final response = await http.get(
      Uri.parse(
          'http://localhost:5004/api/movie/new?page=$page&per_page=$per_page'),
      headers: {
        "Origin": "http://www.daophim.ru",
      });

  if (response.statusCode == 200) {
    Response res = Response.fromJson(jsonDecode(response.body));
    var jsonData = res.data;

    int pageResult = res.page;
    int totalRowResult = res.totalRow;

    List<Movie> moviesResult = [];
    for (var m in jsonData) {
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

    return FinalResponse(
      page: pageResult,
      totalRow: totalRowResult,
      movies: moviesResult,
    );
  } else {
    throw Exception('Failed to load movie');
  }
}

class FinalResponse {
  final int page;
  final int totalRow;
  final List<Movie> movies;

  FinalResponse({
    this.page,
    this.totalRow,
    this.movies,
  });
}

class Response {
  final int page;
  final int totalRow;
  final data;

  Response({
    this.page,
    this.totalRow,
    this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    return Response(
      page: json["page"],
      totalRow: json["totalRows"],
      data: json["data"],
    );
  }
}

class Movie {
  final String id, title, subtitle, slug, status, photo, runtime, driveId, pId;
  final bool form;
  final int views;
  final double pointVoted;
  Movie({
    this.id,
    this.title,
    this.subtitle,
    this.slug,
    this.status,
    this.photo,
    this.runtime,
    this.driveId,
    this.pId,
    this.views,
    this.form,
    this.pointVoted,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["_id"],
      title: json["title"],
      slug: json["slug"],
      status: json["status"],
      photo: json["photo"],
      runtime: json["runtime"],
      driveId: json["driveId"],
      pId: json["pId"],
      form: json["form"],
      views: json["views"],
      pointVoted: json["pointVoted"],
    );
  }
}
