import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pattern_architecture/app/domain/entities/user_model.dart';
import 'dart:convert';

import '../../core_global/error/failure.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/NoParams/usecase.dart';

abstract class RegistrationUsersDataSource {
  Future registrationUsers(
      String email, String password, String name, String city);
}

class RegistrationUsersDataSourceImpl implements RegistrationsRepository {
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
          // .then((response) => Right(response).fold((failure) => Left(failure),
          //     (response) async{
          //   if(response.statusCode == 200){
          //     print(
          //           "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response
          //               .body}");
          //     return Right(NoParams());
          //   } else{
          //     return Left(Failure(response.body));
          //   }
          //     }));
      print(
          "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response
              .body}");
      //return Right(NoParams());


    // Map result = {
    //   'status': response.statusCode,
    //   'body': json.decode(response.body)
    // };

      // if(response.statusCode == 200) {
      //   print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      //   return Right(NoParams());
      // }
     //return Left(Failure("ХХхХХХХХХХХХХХ"));
            if(response.body.isNotEmpty){
              if(response.statusCode == 200 && response.body == 'true'){
            return Right(NoParams());
              } else{
                return Left(Failure(response.body));
              }
          } else{
            return Left(Failure(response.body));
            }

  }

  @override
  Future<Either<Failure, userModel>> autorizationUsers(String email, String password) async {
    Map autUser = {
      'email': email,
      'password': password,
    };
    final  response = await http.post(
        Uri.parse('http://s230619.h1n.ru/authotization.php'),
        body: json.encode(autUser));
    // .then((response) => Right(response).fold((failure) => Left(failure),
    //     (response) async{
    //   if(response.statusCode == 200){
    //     print(
    //           "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response
    //               .body}");
    //     return Right(NoParams());
    //   } else{
    //     return Left(Failure(response.body));
    //   }
    //     }));
    Map result = {'status': response.statusCode, 'body': json.decode(response.body)};
    print(
        "RESPONSE: \n STATUS: ${response.statusCode} \n BODY: ${response
            .body}");

     final Map users = result['body']['user'][0];
     final userModel user = userModel(users['email'], users['id_user'], users['password'], users['name'], users['city']);
    //return Right(NoParams());


    // Map result = {
    //   'status': response.statusCode,
    //   'body': json.decode(response.body)
    // };

    // if(response.statusCode == 200) {
    //   print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    //   return Right(NoParams());
    // }
    //return Left(Failure("ХХхХХХХХХХХХХХ"));
    if(response.body.isNotEmpty){
      if(response.statusCode == 200 && response.body.isNotEmpty){
        return Right(user);
      } else{
        return Left(Failure(response.body));
      }
    } else{
      return Left(Failure(response.body));
    }
  }
}
