import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ratlozen_services/screens/wallet/add_funds_screen.dart';
import 'package:ratlozen_services/screens/wallet/wallet_screen.dart';
import 'package:ratlozen_services/services/wallet_service.dart';
import 'package:ratlozen_services/widgets/custom_app_bar.dart';
import 'pages/terms_and_conditions_page.dart';

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
      home: MainScreen(),
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
            label: 'السلة',
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

class HomePage extends StatelessWidget {
  final String currency;
  const HomePage({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(balance: 35.20, currency: currency),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Carousel section
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF2A2A3E),
                  ),
                  child: const Center(
                    child: Text(
                      'عرض ترويجي',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Categories section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'كل المنتجات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildCategoryCard('الجميع', Icons.grid_3x3),
                            _buildCategoryCard('الاتصالات', Icons.wifi),
                            _buildCategoryCard('الألعاب', Icons.sports_esports),
                            _buildCategoryCard('متاجر التطبيقات', Icons.shopping_bag),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Products grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildProductCard('PlayStation', 'assets/ps.png'),
                      _buildProductCard('iTunes', 'assets/itunes.png'),
                      _buildProductCard('FIFA 26', 'assets/fifa.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF2A2A3E),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFFFC107)),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF2A2A3E),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
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
          CustomAppBar(balance: 35.20, currency: currency),
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
                      color: const Color(0xFFFFC107),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFC107).withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/empty_cart_icon.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.shopping_cart,
                          size: 80,
                          color: Color(0xFFFF6B35),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'قائمة مشترياتك فارغة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'هو عارف من وين تبدأ؟ شوف صفحتنا الرئيسية',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
                  const SizedBox(height: 20),
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
          CustomAppBar(balance: 35.20, currency: currency),
        Expanded(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'للتواصل أو الاستفسار اختر إحدى الطرق التالية:',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              // Contact options
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildContactCard(
                        context,
                        'واتساب',
                        '+9647763410970',
                        Icons.phone,
                        const Color(0xFF7C4DFF),
                        'افتح واتساب',
                      ),
                      const SizedBox(height: 16),
                      _buildContactCard(
                        context,
                        'تيليجرام',
                        '@Ratluzen',
                        Icons.send,
                        const Color(0xFF7C4DFF),
                        'افتح تيليجرام',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    String title,
    String contact,
    IconData icon,
    Color iconColor,
    String buttonText,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Left side - Button
          TextButton(
            onPressed: () async {
              String url = '';
              if (title == 'واتساب') {
                url = 'https://wa.me/9647763410970';
              } else if (title == 'تيليجرام') {
                url = 'https://t.me/Ratluzen';
              }
              
              if (url.isNotEmpty) {
                try {
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('لم يتم العثور على التطبيق')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('خطأ: \$e')),
                  );
                }
              }
            },
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Color(0xFF7C4DFF),
                fontSize: 14,
              ),
            ),
          ),
          const Spacer(),
          // Right side - Contact info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                contact,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 32,
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
  const ProfilePage({super.key, required this.currency, required this.onCurrencyChanged});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(balance: 35.20, currency: widget.currency),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // User info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'زائر',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xFF2A2A3E),
                        child: Icon(Icons.person, size: 30, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddFundsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                  label: const Text('إضافة رصيد', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WalletScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_balance_wallet, color: Colors.white),
                  label: const Text('المحفظة', style: TextStyle(color: Colors.white)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFFC107)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Menu items
            _buildProfileMenuItem('العملة', Icons.monetization_on_outlined),
            _buildProfileMenuItem('الإشعارات', Icons.notifications_outlined),
            _buildProfileMenuItem('طلباتي', Icons.list_alt_outlined),
            _buildProfileMenuItem('محفظتي', Icons.account_balance_wallet_outlined),
            _buildProfileMenuItem('الأسئلة الشائعة', Icons.help_outline),
            _buildProfileMenuItem('الشروط والأحكام', Icons.description_outlined),
            _buildProfileMenuItem('تقييم التطبيق', Icons.star_outline),
            _buildProfileMenuItem('الدعم الفني', Icons.support_agent_outlined),
            const SizedBox(height: 16),
            _buildProfileMenuItem('تسجيل الخروج', Icons.logout, color: Colors.red),
            _buildProfileMenuItem('حذف الحساب', Icons.delete_outline, color: Colors.red),
              ],
            ),
          ),
        ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem(String title, IconData icon, {Color color = Colors.white}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: () => _handleMenuItemTap(title),
        title: Text(
          title,
          style: TextStyle(color: color),
          textDirection: TextDirection.rtl,
        ),
        trailing: Icon(icon, color: color),
        leading: Icon(Icons.arrow_back_ios, color: color, size: 16),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  void _handleMenuItemTap(String menuItem) {
    switch (menuItem) {
      case 'العملة':
        _showCurrencyDialog();
        break;
      case 'الإشعارات':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('إدارة الإشعارات')),
        );
        break;
      case 'طلباتي':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('عرض طلباتك')),
        );
        break;
      case 'محفظتي':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WalletScreen(),
          ),
        );
        break;
      case 'الأسئلة الشائعة':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('الأسئلة الشائعة')),
        );
        break;
      case 'الشروط والأحكام':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TermsAndConditionsPage(),
          ),
        );
        break;
      case 'تقييم التطبيق':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('شكراً لتقييمك')),
        );
        break;
      case 'الدعم الفني':
        // Navigate to ChatPage (Support)
        if (context.mounted) {
          final mainScreenState = context.findAncestorStateOfType<_MainScreenState>();
          mainScreenState?.setState(() {
            mainScreenState._selectedIndex = 2; // ChatPage index
          });
        }
        break;
      case 'تسجيل الخروج':
        _showLogoutDialog();
        break;
      case 'حذف الحساب':
        _showDeleteAccountDialog();
        break;
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A3E),
          title: const Text(
            'تسجيل الخروج',
            style: TextStyle(color: Colors.white),
            textDirection: TextDirection.rtl,
          ),
          content: const Text(
            'هل تريد تسجيل الخروج من حسابك؟',
            style: TextStyle(color: Colors.grey),
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تسجيل الخروج بنجاح')),
                );
              },
              child: const Text('تسجيل الخروج', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A3E),
          title: const Text(
            'اختر العملة',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'اختر العملة المفضلة لعرض رصيدك:',
            style: TextStyle(color: Colors.grey),
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.onCurrencyChanged('د.ع');
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تغيير العملة إلى الدينار العراقي')),
                );
              },
              child: const Text('🇮🇶 الدينار العراقي (د.ع)', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                widget.onCurrencyChanged('\$');
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تغيير العملة إلى الدولار الأمريكي')),
                );
              },
              child: const Text('🇺🇸 الدولار الأمريكي (\$)', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A3E),
          title: const Text(
            'حذف الحساب',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'هل أنت متأكد من رغبتك في حذف حسابك؟ هذا الإجراء غير قابل للعكس.',
            style: TextStyle(color: Colors.grey),
            textDirection: TextDirection.rtl,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم حذف حسابك بنجاح')),
                );
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
