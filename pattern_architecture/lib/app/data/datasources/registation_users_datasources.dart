import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pattern_architecture/app/domain/entities/user_model.dart';
import 'dart:convert';

import '../../core_global/error/failure.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/NoParams/usecase.dart';

class RegistrationUsersDataSourceImpl implements Repository {
  final http.Client client;

  RegistrationUsersDataSourceImpl({required this.client});

  @override
  Future<Either<Failure, NoParams>> registrationUsers(
      String email, String password, String name, String city) async {
    Map addUser = {
      'email': email,
      'password': password,
      'name': name,
      'city': city
    };
    final response = await http.post(
        Uri.parse('http://s230619.h1n.ru/registration.php'),
        body: json.encode(addUser));
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
  }

  @override
  Future<Either<Failure, userModel>> autorizationUsers(
      String email, String password) async {
    Map autUser = {
      'email': email,
      'password': password,
    };
    final response = await http.post(
        Uri.parse('http://s230619.h1n.ru/authotization.php'),
        body: json.encode(autUser));
    Map result = {
      'status': response.statusCode,
      'body': json.decode(response.body)
    };
    print(
        "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

    final Map users = result['body']['user'][0];
    final userModel user = userModel(users['email'], users['id_user'],
        users['password'], users['name'], users['city']);
    if (response.body.isNotEmpty) {
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return Right(user);
      } else {
        return Left(Failure(response.body));
      }
    } else {
      return Left(Failure(response.body));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addAd(String title, String car, String data,
      String notes, String departure, String receipt) async {
    var users = await Hive.openBox<userModel>('user');
    Map addAd = {
      'title': title,
      'car': car,
      'data': data,
      'notes': notes,
      'departure': departure,
      'receipt': receipt,
      'idUser': users.get('user')?.id
    };
    final response = await http.post(
        Uri.parse('http://s230619.h1n.ru/addDriverCar.php'),
        body: json.encode(addAd));
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
  }

  @override
  Future<Either<Failure, List>> outputDriverCar() async {
    Map autUser = {};
    var response = (await http.post(
        Uri.parse('http://s230619.h1n.ru/driverCar.php'),
        body: json.encode(autUser)));
    Map result = {'status': response.statusCode, 'body': json.decode(response.body)};
    Map body = result['body'];
   final List output = body['user'];
    print(
        "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

    if (response.body.isNotEmpty) {
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return Right(output);
      } else {
        return Left(Failure(response.body));
      }
    } else {
      return Left(Failure(response.body));
    }
  }

  @override
  Future<Either<Failure, List>> outputCargo() async {
    Map autUser = {};
    var response = (await http.post(
        Uri.parse('http://s230619.h1n.ru/cargo.php'),
        body: json.encode(autUser)));
    Map result = {'status': response.statusCode, 'body': json.decode(response.body)};
    Map body = result['body'];
    final List output = body['user'];
    print(
        "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

    if (response.body.isNotEmpty) {
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        return Right(output);
      } else {
        return Left(Failure(response.body));
      }
    } else {
      return Left(Failure(response.body));
    }
  }

  @override
  Future<Either<Failure, NoParams>> addCargo(String title, String cargo,
      String data, String notes, String departure, String receipt) async {
    var users = await Hive.openBox<userModel>('user');
    Map addCargo = {
      'title': title,
      'cargo': cargo,
      'data': data,
      'notes': notes,
      'departure': departure,
      'receipt': receipt,
      'idUser': users.get('user')?.id
    };
    final response = await http.post(
        Uri.parse('http://s230619.h1n.ru/addCargo.php'),
        body: json.encode(addCargo));
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
  }

  @override
  Future<Either<Failure, List>> adCardOutput(int id) async {
      Map idUser = {'id':id};
      var response = (await http.post(
      Uri.parse('http://s230619.h1n.ru/ad_card_cargo.php'),
          body: json.encode(idUser)));
    Map result = {'status': response.statusCode, 'body': json.decode(response.body)};
    Map body = result['body'];
    final List output = body['user'];
    print(
    "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response.body}");

    if (response.body.isNotEmpty) {
    if (response.statusCode == 200 && response.body.isNotEmpty) {
    return Right(output);
    } else {
    return Left(Failure(response.body));
    }
    } else {
    return Left(Failure(response.body));
    }
  }

  @override
  Future<Either<Failure, NoParams>> adStatusRespond(int idAd, int idUserClient, int statusOrder) async {
    var users = await Hive.openBox<userModel>('user');
    Map add = {
      'idAd': idAd,
      'idUserClient': idUserClient,
      'idUserExecutor': users.get('user')?.id,
      'statusOrder': statusOrder,
    };
    final response = await http.post(
        Uri.parse('http://s230619.h1n.ru/ad_status_respond.php'),
        body: json.encode(add));
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
  }
}
