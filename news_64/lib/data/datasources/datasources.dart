import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_64/core_global/models/news_model/news_model.dart';
import '../../core_global/error/failure.dart';
import '../../core_global/models/news_detailed_model/news_detailed_model.dart';
import '../../domain/entities/list_model.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/NoParams/usecase.dart';

class RegistrationUsersDataSourceImpl implements Repository {
  final http.Client client;

  RegistrationUsersDataSourceImpl({required this.client});

  Future<Either<Failure, List<NewsModel>>> newNews(
      String category, String date) async {
    final response = await http.get(Uri.parse(
        'https://sarnovosti.ru/api/list.php?from=$date&catId=$category'));
    Map result = {
      'status': response.statusCode,
      'body': json.decode(response.body)
    };
    final List<NewsModel> listNews = List<NewsModel>.from(
        result['body'].map((data) => NewsModel.fromJson(data)));
    if (response.body.isNotEmpty) {
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return Right(listNews);
      } else {
        return Left(Failure(response.body));
      }
    } else {
      return Left(Failure(response.body));
    }
  }

  Future<Either<Failure, NewsDetailedModel>> detailedNews(String id) async {
    final response =
        await http.get(Uri.parse('https://sarnovosti.ru/api/news.php?id=$id'));
    Map result = {
      'status': response.statusCode,
      'body': json.decode(response.body)
    };
    final NewsDetailedModel newsDetailedModel =
        NewsDetailedModel.fromJson(result['body']['data']);
    if (response.body.isNotEmpty) {
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return Right(newsDetailedModel);
      } else {
        return Left(Failure(response.body));
      }
    } else {
      return Left(Failure(response.body));
    }
  }
}
