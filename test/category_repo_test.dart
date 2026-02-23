import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:ezo/core/database/app_database.dart';
import 'package:ezo/core/repositories/category_repository.dart';
import 'package:ezo/core/models/category.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase database;
  late CategoryRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = CategoryRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('CategoryRepository can add and retrieve categories', () async {
    final uuid = const Uuid().v4();
    final newCategory = Category(
      id: 0,
      uuid: uuid,
      name: 'Test Category',
      description: 'Test Description',
      isActive: true,
    );

    await repository.createCategory(newCategory);

    final categories = await repository.getAllCategories();
    expect(categories.length, 1);
    expect(categories.first.name, 'Test Category');
    expect(categories.first.uuid, uuid);
  });
}
