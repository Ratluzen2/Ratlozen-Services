import 'package:flutter/material.dart';
import 'package:ratlozen_services/screens/admin/admin_services_screen.dart';
import 'package:ratlozen_services/screens/admin/admin_products_screen.dart';
import 'package:ratlozen_services/screens/admin/admin_orders_screen.dart';
import 'package:ratlozen_services/screens/admin/admin_wallet_screen.dart';
import 'package:ratlozen_services/screens/admin/admin_notifications_screen.dart';
import 'package:ratlozen_services/services/api_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  bool _isServerConnected = false;
  int _servicesCount = 0;
  int _productsCount = 0;
  int _ordersCount = 0;

  @override
  void initState() {
    super.initState();
    _checkServerStatus();
    _loadDashboardData();
  }

  Future<void> _checkServerStatus() async {
    final isConnected = await ApiService.checkHealth();
    setState(() {
      _isServerConnected = isConnected;
    });
  }

  Future<void> _loadDashboardData() async {
    final services = await ApiService.getServices();
    final products = await ApiService.getProducts();
    final orders = await ApiService.getOrders();

    setState(() {
      _servicesCount = services.length;
      _productsCount = products.length;
      _ordersCount = orders.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'لوحة الإدارة',
          style: TextStyle(
            color: Color(0xFFFFC107),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF1A1A2E),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Server Status Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isServerConnected
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isServerConnected ? Colors.green : Colors.red,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'حالة الخادم',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isServerConnected ? 'متصل' : 'غير متصل',
                          style: TextStyle(
                            color: _isServerConnected
                                ? Colors.green
                                : Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      _isServerConnected
                          ? Icons.check_circle
                          : Icons.error_circle,
                      color: _isServerConnected ? Colors.green : Colors.red,
                      size: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Statistics Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'الخدمات',
                      _servicesCount.toString(),
                      Icons.miscellaneous_services,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'المنتجات',
                      _productsCount.toString(),
                      Icons.shopping_bag,
                      Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'الطلبات',
                      _ordersCount.toString(),
                      Icons.shopping_cart,
                      Colors.purple,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'الإشعارات',
                      '0',
                      Icons.notifications,
                      Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Admin Menu Items
              _buildAdminMenuItem(
                'إدارة الخدمات',
                'إضافة وتعديل وحذف الخدمات',
                Icons.miscellaneous_services,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminServicesScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildAdminMenuItem(
                'إدارة المنتجات',
                'إضافة وتعديل وحذف المنتجات',
                Icons.shopping_bag,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminProductsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildAdminMenuItem(
                'إدارة الطلبات',
                'عرض وتحديث حالة الطلبات',
                Icons.shopping_cart,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminOrdersScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildAdminMenuItem(
                'إدارة المحفظة',
                'عرض معلومات المحفظة والرصيد',
                Icons.account_balance_wallet,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminWalletScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _buildAdminMenuItem(
                'إدارة الإشعارات',
                'إرسال وإدارة الإشعارات',
                Icons.notifications,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminNotificationsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              // Refresh Button
              ElevatedButton.icon(
                onPressed: () {
                  _checkServerStatus();
                  _loadDashboardData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم تحديث البيانات'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('تحديث البيانات'),
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
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String count,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              color: Color(0xFFFFC107),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminMenuItem(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: const Color(0xFFFFC107), size: 28),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ),
    );
  }
}
