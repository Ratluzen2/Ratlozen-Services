import 'package:flutter/material.dart';
import 'package:ratlozen_services/services/api_service.dart';

class AdminWalletScreen extends StatefulWidget {
  const AdminWalletScreen({super.key});

  @override
  State<AdminWalletScreen> createState() => _AdminWalletScreenState();
}

class _AdminWalletScreenState extends State<AdminWalletScreen> {
  Map<String, dynamic>? wallet;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWallet();
  }

  Future<void> _loadWallet() async {
    setState(() => isLoading = true);
    final data = await ApiService.getWallet();
    setState(() {
      wallet = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المحفظة'),
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF1A1A2E),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFC107),
              ),
            )
          : wallet == null
              ? const Center(
                  child: Text(
                    'لم يتم تحميل بيانات المحفظة',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A3E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFFC107),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'الرصيد الحالي',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '${wallet?['balance'] ?? 0} ${wallet?['currency'] ?? 'SAR'}',
                              style: const TextStyle(
                                color: Color(0xFFFFC107),
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _loadWallet,
                        icon: const Icon(Icons.refresh),
                        label: const Text('تحديث الرصيد'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          foregroundColor: const Color(0xFF1A1A2E),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
