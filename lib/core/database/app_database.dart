import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text()();
  TextColumn get email => text()();
  TextColumn get corridor => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get providerName => text()();
  TextColumn get displayName => text()();
  TextColumn get currency => text()();
  IntColumn get balanceMinor => integer()();
  TextColumn get connectionStatus => text()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text().references(Accounts, #id)();
  TextColumn get merchant => text()();
  TextColumn get category => text()();
  TextColumn get currency => text()();
  IntColumn get amountMinor => integer()();
  TextColumn get direction => text()();
  TextColumn get source => text()();
  RealColumn get parserConfidence => real().withDefault(const Constant(1))();
  DateTimeColumn get bookedAt => dateTime()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Budgets extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get category => text()();
  TextColumn get currency => text()();
  IntColumn get limitMinor => integer()();
  IntColumn get spentMinor => integer().withDefault(const Constant(0))();
  TextColumn get period => text()();
  BoolColumn get rolloverEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get alertThresholdPercent =>
      integer().withDefault(const Constant(80))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get name => text()();
  TextColumn get currency => text()();
  IntColumn get targetMinor => integer()();
  IntColumn get savedMinor => integer().withDefault(const Constant(0))();
  DateTimeColumn get targetDate => dateTime()();
  BoolColumn get shared => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class FamilyMembers extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Users, #id)();
  TextColumn get displayName => text()();
  TextColumn get phoneMasked => text()();
  TextColumn get role => text()();
  BoolColumn get canViewSharedTransactions =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get canEditSharedBudgets =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [Users, Accounts, Transactions, Budgets, Goals, FamilyMembers],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Forward-only migration strategy. When introducing a schema change:
  ///   1. Bump [schemaVersion] above.
  ///   2. Add a `from: N, to: N+1` branch in the switch below using
  ///      `m.addColumn`, `m.createTable`, `m.alterTable`, etc.
  ///   3. Ship a Drift schema dump under `drift_schemas/` for tests.
  ///
  /// Never mutate an existing migration step in place — append a new one.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Example for the next schema bump:
          // for (var v = from + 1; v <= to; v++) {
          //   switch (v) {
          //     case 2:
          //       await m.addColumn(transactions, transactions.receiptUrl);
          //       break;
          //   }
          // }
        },
        beforeOpen: (OpeningDetails details) async {
          // Enforce foreign keys on every connection (SQLite default is off).
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final documentsDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(documentsDir.path, 'felo.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}
