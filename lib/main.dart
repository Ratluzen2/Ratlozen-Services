import 'package:flutter/material.dart';
import 'dart:ui' as ui;
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
          CustomAppBar(balance: 35.20, currency: widget.currency),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Carousel section
                Column(
                  children: [
                    SizedBox(
                      height: 200,
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

  Widget _buildCarouselItem(int index) {
    final List<String> titles = [
      'أشحن الآن',
      'عروض خاصة',
      'منتجات جديدة',
      'خصومات حصرية',
    ];
    
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Text(
                  titles[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                // Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'اشتري الآن',
                    style: TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
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

  Widget _buildCategoryCard(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
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
              size: 30,
            ),
          ),
          const SizedBox(height: 4),
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

                    ],
                  ),
                ),
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A2E),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              left: 24,
              right: 24,
              top: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Header
                const Text(
                  'العملة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 12),
                // Description
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Text(
                        'اختر العملة التي تريد عرض الأسعار بها',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.attach_money,
                        color: Color(0xFFFFC107),
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

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

                    ],
                  ),
                ),
                // Currency Selection - IQD
                GestureDetector(
                  onTap: () {
                    widget.onCurrencyChanged('د.ع');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تغيير العملة إلى الدينار العراقي')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A3E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '🇮🇶',
                          style: TextStyle(fontSize: 24),
                        ),
                        const Text(
                          'الدينار العراقي',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Currency Selection - USD
                GestureDetector(
                  onTap: () {
                    widget.onCurrencyChanged('\$');
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم تغيير العملة إلى الدولار الأمريكي')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A3E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '🇺🇸',
                          style: TextStyle(fontSize: 24),
                        ),
                        const Text(
                          'الدولار الأمريكي',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

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

                    ],
                  ),
                ),
                // Change Currency Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'تغيير العملة',
                      style: TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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

class CurrencySelectionPage extends StatefulWidget {
  final Function(String) onCurrencySelected;
  final String currentCurrency;

  const CurrencySelectionPage({
    super.key,
    required this.onCurrencySelected,
    required this.currentCurrency,
  });

  @override
  State<CurrencySelectionPage> createState() => _CurrencySelectionPageState();
}

class _CurrencySelectionPageState extends State<CurrencySelectionPage> {
  late List<Map<String, String>> currencies;
  late List<Map<String, String>> filteredCurrencies;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currencies = [
      {'name': 'درهم إماراتي', 'code': 'AED', 'flag': '🇦🇪'},
      {'name': 'دينار بحريني', 'code': 'BHD', 'flag': '🇧🇭'},
      {'name': 'جنية مصري', 'code': 'EGP', 'flag': '🇪🇬'},
      {'name': 'يورو', 'code': 'EUR', 'flag': '🇪🇺'},
      {'name': 'دينار عراقي', 'code': 'IQD', 'flag': '🇮🇶'},
      {'name': 'دينار أردني', 'code': 'JOD', 'flag': '🇯🇴'},
      {'name': 'دينار كويتي', 'code': 'KWD', 'flag': '🇰🇼'},
      {'name': 'ريال عماني', 'code': 'OMR', 'flag': '🇴🇲'},
      {'name': 'ريال قطري', 'code': 'QAR', 'flag': '🇶🇦'},
      {'name': 'ريال سعودي', 'code': 'SAR', 'flag': '🇸🇦'},
      {'name': 'دولار أمريكي', 'code': 'USD', 'flag': '🇺🇸'},
    ];
    filteredCurrencies = currencies;
    searchController.addListener(_filterCurrencies);
  }

  void _filterCurrencies() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCurrencies = currencies
          .where((currency) =>
              currency['name']!.toLowerCase().contains(query) ||
              currency['code']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'إبحث عن ...',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF2A2A3E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFFFFC107),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            // Currencies List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredCurrencies.length,
                itemBuilder: (context, index) {
                  final currency = filteredCurrencies[index];
                  final isSelected = widget.currentCurrency == currency['code'];
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        widget.onCurrencySelected(currency['code']!);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF2A2A3E).withOpacity(0.8) : const Color(0xFF2A2A3E),
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(color: const Color(0xFFFFC107), width: 2)
                              : Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currency['flag']!,
                              style: const TextStyle(fontSize: 24),
                            ),
                            Text(
                              currency['name']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Back Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A2A3E),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'رجوع',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
