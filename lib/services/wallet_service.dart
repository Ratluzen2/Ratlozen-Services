import 'package:ratlozen_services/database/database_helper.dart';

class WalletService {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<double> getBalance(String userId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'wallet',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) {
      return maps.first['balance'];
    }
    return 0.0;
  }

  Future<void> updateBalance(String userId, double amount) async {
    final db = await _dbHelper.database;
    await db.update(
      'wallet',
      {'balance': amount},
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> addTransaction(String userId, String type, double amount, String description) async {
    final db = await _dbHelper.database;
    await db.insert('transactions', {
      'user_id': userId,
      'type': type,
      'amount': amount,
      'date': DateTime.now().toIso8601String(),
      'description': description,
    });
  }

  Future<List<Map<String, dynamic>>> getTransactions(String userId) async {
    final db = await _dbHelper.database;
    return await db.query(
      'transactions',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );
  }
}
