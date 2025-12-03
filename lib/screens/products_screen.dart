import 'package:flutter/material.dart';
import 'package:ratlozen_services/services/api_service.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<dynamic>> _productsFuture;
  String _selectedCategory = 'الجميع';
  
  final List<Map<String, dynamic>> categories = [
    {'name': 'الجميع', 'icon': Icons.apps, 'color': Colors.amber},
    {'name': 'التسوق', 'icon': Icons.shopping_bag, 'color': Colors.blue},
    {'name': 'الاتصالات', 'icon': Icons.signal_cellular_alt, 'color': Colors.purple},
    {'name': 'الألعاب', 'icon': Icons.sports_esports, 'color': Colors.green},
    {'name': 'التطبيقات', 'icon': Icons.apps, 'color': Colors.orange},
  ];

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService.getProducts();
  }

  List<dynamic> _filterProducts(List<dynamic> products) {
    if (_selectedCategory == 'الجميع') {
      return products;
    }
    return products.where((product) {
      final category = product['category'] ?? '';
      return category.toString().contains(_selectedCategory);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text(
          'كل المنتجات',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '\$ 0.00',
                style: TextStyle(
                  color: Colors.amber[400],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // قائمة الفئات الأفقية
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = _selectedCategory == category['name'];
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category['name'];
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF2A2A2A),
                            border: isSelected
                                ? Border.all(
                                    color: category['color'],
                                    width: 3,
                                  )
                                : null,
                          ),
                          child: Icon(
                            category['icon'],
                            color: isSelected ? category['color'] : Colors.grey,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category['name'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // شبكة المنتجات
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  );
                }
                
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'خطأ في تحميل المنتجات',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  );
                }
                
                final products = _filterProducts(snapshot.data ?? []);
                
                if (products.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد منتجات في هذه الفئة',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  );
                }
                
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildProductCard(product);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(dynamic product) {
    final name = product['name'] ?? 'منتج';
    
    // تدرجات لونية مختلفة لكل منتج
    final gradients = [
      [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)],
      [const Color(0xFFEA580C), const Color(0xFFFB923C)],
      [const Color(0xFF059669), const Color(0xFF10B981)],
      [const Color(0xFF7C3AED), const Color(0xFFA78BFA)],
      [const Color(0xFFDC2626), const Color(0xFFF87171)],
      [const Color(0xFF0891B2), const Color(0xFF06B6D4)],
    ];
    
    final gradientIndex = product.hashCode % gradients.length;
    final gradient = gradients[gradientIndex];
    
    return GestureDetector(
      onTap: () {
        // يمكن إضافة صفحة تفاصيل المنتج هنا
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradient,
                ),
              ),
              child: Stack(
                children: [
                  // محتوى المنتج
                  Center(
                    child: Text(
                      name.length > 15 ? name.substring(0, 15) : name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  

                ],
              ),
            ),
          ),
          
          // اسم المنتج أسفل البطاقة
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              name.length > 12 ? '${name.substring(0, 12)}...' : name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
