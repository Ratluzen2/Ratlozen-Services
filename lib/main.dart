import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';
import 'package:ratlozen_services/screens/wallet/add_funds_screen.dart';
import 'package:ratlozen_services/screens/wallet/wallet_screen.dart';
import 'package:ratlozen_services/services/wallet_service.dart';
import 'package:ratlozen_services/widgets/custom_app_bar.dart';
import 'package:ratlozen_services/screens/notifications_screen.dart';
import 'pages/terms_and_conditions_page.dart';
import 'package:ratlozen_services/screens/admin/admin_dashboard_screen.dart';
import 'package:ratlozen_services/screens/products_screen.dart';

void main() {
  runApp(const RatlozenApp());
}

class RatlozenApp extends StatelessWidget {
  const RatlozenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'خدمات راتلوزن',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A2E),
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _selectedCurrency = 'د.ع'; // Default to IQD
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
	      HomePage(currency: _selectedCurrency),
	      CartPage(currency: _selectedCurrency),
	      ChatPage(currency: _selectedCurrency),
	      ProfilePage(
	        currency: _selectedCurrency,
	        onCurrencyChanged: (newCurrency) {
	          setState(() {
	            _selectedCurrency = newCurrency;
	          });
	        },
	        onNavigateToTab: (index) {
	          setState(() {
	            _selectedIndex = index;
	          });
	        },
	      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: const Color(0xFF1A1A2E),
        selectedItemColor: const Color(0xFFFFC107),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
	            label: 'الرئيسية',
	          ),
	          BottomNavigationBarItem(
	            icon: Icon(Icons.shopping_cart),
	            label: 'طلباتي',
	          ),
	          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'الدعم',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الملف',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String currency;
  const HomePage({super.key, required this.currency});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            balance: 35.20,
            currency: widget.currency,
            onNotificationPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Carousel section
                Column(
                  children: [
                    SizedBox(
                      height: 165,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return _buildCarouselItem(index);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: _currentPage == index
                                ? const Color(0xFFFFC107)
                                : Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
                // Categories section

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
	                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'كل المنتجات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          reverse: true, // لضمان الترتيب من اليمين لليسار
                          children: [
                            _buildCategoryCard('الجميع', Icons.apps_outlined),
                            _buildCategoryCard('خدمات واشتراكات', Icons.subscriptions_outlined),
                            _buildCategoryCard('التسوق', Icons.shopping_cart_outlined),
                            _buildCategoryCard('الاتصالات', Icons.wifi_outlined),
                            _buildCategoryCard('الألعاب', Icons.gamepad_outlined),
                            _buildCategoryCard('متاجر التطبيقات', Icons.store_outlined),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // عرض الخدمات
                      const Text(
                        'الخدمات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: _getServices().length,
                          itemBuilder: (context, index) {
                            final service = _getServices()[index];
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF2A2A3E),
                                    const Color(0xFF1A1A2E),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    service['name'] ?? 'خدمة',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getServices() {
    return [
      {'id': 1, 'name': 'كوين فيفا 26', 'price': 5000},
      {'id': 2, 'name': 'بطاقات ايتونز', 'price': 3000},
      {'id': 3, 'name': 'بلايستيشن ستور', 'price': 4000},
    ];
  }

  Widget _buildCarouselItem(int index) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2A2A3E),
            const Color(0xFF1A1A2E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Content
	          // Content removed as requested
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
	            width: 50,
	            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
              color: const Color(0xFF2A2A3E),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFFC107),
	              size: 24,
            ),
          ),
	          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final String currency;
  const CartPage({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            balance: 35.20,
            currency: currency,
            onNotificationPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.grey.withOpacity(0.5),
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 20),
	                  const Text(
	                    'لا توجد طلبات حاليًا',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
	                    'ستظهر طلباتك هنا',
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'ابدأ التسوق',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  final String currency;
  const ChatPage({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            balance: 35.20,
            currency: currency,
            onNotificationPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.grey.withOpacity(0.5),
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'لا توجد رسائل',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'تواصل معنا عند الحاجة',
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String currency;
  final Function(String) onCurrencyChanged;
  final Function(int) onNavigateToTab;

  const ProfilePage({
    super.key,
    required this.currency,
    required this.onCurrencyChanged,
    required this.onNavigateToTab,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            balance: 35.20,
            currency: widget.currency,
            onNotificationPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Avatar
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFC107),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFFFFC107),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'المستخدم',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'user@example.com',
                      style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Currency Selection
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A3E),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'اختر العملة',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildCurrencyButton('د.ع', 'د.ع'),
                              _buildCurrencyButton('\$', '\$'),
                              _buildCurrencyButton('€', '€'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Admin Panel Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AdminDashboardScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37), // Golden color
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'لوحة التحكم',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Menu Items
                    _buildMenuItem(Icons.history, 'السجل', () {}),
                    _buildMenuItem(Icons.help_outline, 'المساعدة', () {}),
                    _buildMenuItem(Icons.description, 'الشروط والأحكام', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TermsAndConditionsPage(),
                        ),
                      );
                    }),
                    _buildMenuItem(Icons.logout, 'تسجيل الخروج', () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyButton(String label, String value) {
    bool isSelected = widget.currency == value;
    return GestureDetector(
      onTap: () {
        widget.onCurrencyChanged(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFC107) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFC107) : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFFFC107),
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
