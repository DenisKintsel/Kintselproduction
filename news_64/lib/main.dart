import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_64/presentation/pages/tab_bar/widget/tab_bar_widget.dart';

import 'domain/entities/article_model.dart';
import 'domain/entities/important_model.dart';
import 'domain/entities/list_model.dart';
import 'get_injector.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(listModelAdapter());
  Hive.registerAdapter(importantModelAdapter());
  Hive.registerAdapter(articleModelAdapter());
  await sl.initGet();
  runApp(
    GetMaterialApp(home: TabBarWidget()),
  );
}