import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:news_64/core_global/models/news_model/news_model.dart';
import '../../core_global/error/failure.dart';
import '../../core_global/models/news_detailed_model/news_detailed_model.dart';
import '../../domain/entities/article_model.dart';
import '../../domain/entities/important_model.dart';
import '../../domain/entities/list_model.dart';
import '../../domain/repositories/repository.dart';

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
        if(category == ''){
        var box = await Hive.openBox<listModel>('News');
        final listModel listMod = listModel(result['body']);
        final qqq = box.get('News')?.newsBD;
        List list = [];
        list = [...list, ...?qqq, ...listMod.newsBD];
        print(list.length);
        final listModel listMod2 = listModel(list);
        await box.put('News', listMod2);
        }
        else if(category == 'top'){
          var box = await Hive.openBox<importantModel>('top');
          final importantModel listMod = importantModel(result['body']);
          final qqq = box.get('top')?.newsImportantBD;
          List list = [];
          list = [...list, ...?qqq, ...listMod.newsImportantBD];
          print(list.length);
          final importantModel listMod2 = importantModel(list);
          await box.put('top', listMod2);
        }
        else if(category == 'article'){
          var box = await Hive.openBox<articleModel>('article');
          final articleModel listMod = articleModel(result['body']);
          final qqq = box.get('article')?.newsArticleBD;
          List list = [];
          list = [...list, ...?qqq, ...listMod.newsArticleBD];
          print(list.length);
          final articleModel listMod2 = articleModel(list);
          await box.put('article', listMod2);
        }
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
