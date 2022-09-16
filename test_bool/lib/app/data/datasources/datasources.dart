import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:test_bool/app/domain/entities/list_bool_model.dart';
import 'dart:convert';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../core_global/error/failure.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/NoParams/usecase.dart';

class RegistrationUsersDataSourceImpl implements Repository {
  final http.Client client;

  RegistrationUsersDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, listBoolModel>> outBool() async {
    Map putBool = {};
    var response = (await http.post(
        Uri.parse('http://s230619.h1n.ru/testBool.php'),
        body: json.encode(putBool)));
    Map result = {
      'status': response.statusCode,
      'body': json.decode(response.body)
    };
    Map body = result['body'];
    final List output = body['bool'];
    print(
        "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");
    print(output);
    var box = await Hive.openBox<listBoolModel>('List');
    final listBoolModel listMod = listBoolModel(output);
    await box.delete('List');
    await box.put('List', listMod);
    if (response.body.isNotEmpty) {
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return Right(listMod);
      } else {
        return Left(Failure(response.body));
      }
    } else {
      return Left(Failure(response.body));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addBool(
      int id,
      int switchQ,
      int radio,
      int check,
      int id2,
      int switchQ2,
      int radio2,
      int check2,
      int id3,
      int switchQ3,
      int radio3,
      int check3) async {
    Map addBool = {
      'id': id,
      'switchQ': switchQ,
      'radio': radio,
      'check': check,
      'id2': id2,
      'switchQ2': switchQ2,
      'radio2': radio2,
      'check2': check2,
      'id3': id3,
      'switchQ3': switchQ3,
      'radio3': radio3,
      'check3': check3
    };
    if (await InternetConnectionChecker().hasConnection == true) {
      final response = await http.post(
          Uri.parse('http://s230619.h1n.ru/addBool.php'),
          body: json.encode(addBool));
      print(
          "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");
      if (response.body.isNotEmpty) {
        if (response.statusCode == 200 && response.body == 'true') {
          return Right(NoParams());
        } else {
          return Left(Failure(response.body));
        }
      } else {
        return Left(Failure(response.body));
      }
    } else {
      return const Left(Failure("Ошибка"));
    }
  }
}
