import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../models/blog_local.dart';
import '../local/blog_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [BlogLocalModel])
abstract class AppDatabase extends FloorDatabase {
  BlogDao get blogDao;
}
