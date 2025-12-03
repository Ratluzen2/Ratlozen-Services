import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // تحديث هذا الرابط برابط Backend الفعلي على Railway
  static const String baseUrl = 'https://your-railway-domain.railway.app';

  // الحصول على جميع الخدمات
  static Future<List<dynamic>> getServices() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/services'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      }
      throw Exception('Failed to load services');
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  // إنشاء خدمة جديدة
  static Future<bool> createService({
    required String name,
    required String description,
    required String category,
    required double price,
    required bool isActive,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/services'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'description': description,
          'category': category,
          'price': price,
          'isActive': isActive,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // تحديث خدمة
  static Future<bool> updateService({
    required int id,
    required String name,
    required String description,
    required String category,
    required double price,
    required bool isActive,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/services/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'description': description,
          'category': category,
          'price': price,
          'isActive': isActive,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // حذف خدمة
  static Future<bool> deleteService(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/services/$id'),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // الحصول على جميع المنتجات
  static Future<List<dynamic>> getProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/products'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      }
      throw Exception('Failed to load products');
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  // إنشاء منتج جديد
  static Future<bool> createProduct({
    required String name,
    required String description,
    required double price,
    required int serviceId,
    required bool isActive,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'description': description,
          'price': price,
          'serviceId': serviceId,
          'isActive': isActive,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // تحديث منتج
  static Future<bool> updateProduct({
    required int id,
    required String name,
    required String description,
    required double price,
    required int serviceId,
    required bool isActive,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/products/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'description': description,
          'price': price,
          'serviceId': serviceId,
          'isActive': isActive,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // حذف منتج
  static Future<bool> deleteProduct(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/products/$id'),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // الحصول على جميع الطلبات
  static Future<List<dynamic>> getOrders() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/orders'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      }
      throw Exception('Failed to load orders');
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  // تحديث حالة الطلب
  static Future<bool> updateOrderStatus({
    required int id,
    required String status,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/orders/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': status}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // حذف طلب
  static Future<bool> deleteOrder(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/orders/$id'),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // الحصول على معلومات المحفظة
  static Future<Map<String, dynamic>?> getWallet() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/wallet'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'];
      }
      throw Exception('Failed to load wallet');
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // الحصول على الإشعارات
  static Future<List<dynamic>> getNotifications() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/notifications'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      }
      throw Exception('Failed to load notifications');
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  // إنشاء إشعار
  static Future<bool> createNotification({
    required String userId,
    required String title,
    required String message,
    required String type,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/notifications'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'title': title,
          'message': message,
          'type': type,
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // حذف إشعار
  static Future<bool> deleteNotification(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/notifications/$id'),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // التحقق من صحة الخادم
  static Future<bool> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/health'),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
