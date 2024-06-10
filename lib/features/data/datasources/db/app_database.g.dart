// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BlogDao? _blogDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BlogLocalModel` (`id` TEXT NOT NULL, `title` TEXT NOT NULL, `shortDescription` TEXT NOT NULL, `author` TEXT NOT NULL, `content` TEXT NOT NULL, `thumbnail` TEXT NOT NULL, `createdAt` INTEGER NOT NULL, `updatedAt` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BlogDao get blogDao {
    return _blogDaoInstance ??= _$BlogDao(database, changeListener);
  }
}

class _$BlogDao extends BlogDao {
  _$BlogDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _blogLocalModelInsertionAdapter = InsertionAdapter(
            database,
            'BlogLocalModel',
            (BlogLocalModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'shortDescription': item.shortDescription,
                  'author': item.author,
                  'content': item.content,
                  'thumbnail': item.thumbnail,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _blogLocalModelUpdateAdapter = UpdateAdapter(
            database,
            'BlogLocalModel',
            ['id'],
            (BlogLocalModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'shortDescription': item.shortDescription,
                  'author': item.author,
                  'content': item.content,
                  'thumbnail': item.thumbnail,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                }),
        _blogLocalModelDeletionAdapter = DeletionAdapter(
            database,
            'BlogLocalModel',
            ['id'],
            (BlogLocalModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'shortDescription': item.shortDescription,
                  'author': item.author,
                  'content': item.content,
                  'thumbnail': item.thumbnail,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BlogLocalModel> _blogLocalModelInsertionAdapter;

  final UpdateAdapter<BlogLocalModel> _blogLocalModelUpdateAdapter;

  final DeletionAdapter<BlogLocalModel> _blogLocalModelDeletionAdapter;

  @override
  Future<List<BlogLocalModel>> getAllBlogs() async {
    return _queryAdapter.queryList('SELECT * FROM BlogLocalModel',
        mapper: (Map<String, Object?> row) => BlogLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            shortDescription: row['shortDescription'] as String,
            author: row['author'] as String,
            content: row['content'] as String,
            thumbnail: row['thumbnail'] as String,
            createdAt: row['createdAt'] as int,
            updatedAt: row['updatedAt'] as int));
  }

  @override
  Future<BlogLocalModel?> getBlogById(String id) async {
    return _queryAdapter.query('SELECT * FROM BlogLocalModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => BlogLocalModel(
            id: row['id'] as String,
            title: row['title'] as String,
            shortDescription: row['shortDescription'] as String,
            author: row['author'] as String,
            content: row['content'] as String,
            thumbnail: row['thumbnail'] as String,
            createdAt: row['createdAt'] as int,
            updatedAt: row['updatedAt'] as int),
        arguments: [id]);
  }

  @override
  Future<void> insertBlog(BlogLocalModel blog) async {
    await _blogLocalModelInsertionAdapter.insert(
        blog, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBlog(BlogLocalModel blog) async {
    await _blogLocalModelUpdateAdapter.update(blog, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteBlog(BlogLocalModel blog) async {
    await _blogLocalModelDeletionAdapter.delete(blog);
  }
}
