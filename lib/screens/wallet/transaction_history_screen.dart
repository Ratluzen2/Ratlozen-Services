import 'package:flutter/material.dart';
import 'package:ratlozen_services/services/wallet_service.dart';
import 'package:ratlozen_services/services/auth_service.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  final User currentUser;

  const TransactionHistoryScreen({Key? key, required this.currentUser}) : super(key: key);

  @override
  TransactionHistoryScreenState createState() => TransactionHistoryScreenState();
}

class TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final WalletService _walletService = WalletService();
  late Future<List<Map<String, dynamic>>> _transactions;

  @override
  void initState() {
    super.initState();
    _transactions = _walletService.getTransactions(widget.currentUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _transactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No transactions found.'));
          }

          final transactions = snapshot.data!;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              final date = DateTime.parse(tx['date']);
              final formattedDate = DateFormat.yMd().add_jm().format(date);

              return ListTile(
                leading: Icon(tx['type'] == 'deposit' ? Icons.arrow_downward : Icons.arrow_upward),
                title: Text(tx['description'] ?? 'No description'),
                subtitle: Text(formattedDate),
                trailing: Text(
                  '\$${tx['amount'].toStringAsFixed(2)}',
                  style: TextStyle(
                    color: tx['type'] == 'deposit' ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
