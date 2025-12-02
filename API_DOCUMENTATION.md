# Ratlozen Services Backend API Documentation

## نظرة عامة

واجهة برمجية متكاملة لتطبيق Ratlozen Services توفر إدارة شاملة للخدمات والمنتجات والطلبات والمحفظة الإلكترونية والإشعارات.

## معلومات الخادم

- **Base URL**: `https://your-railway-domain.railway.app`
- **Version**: 1.0.0
- **Environment**: Production
- **Database**: PostgreSQL (Neon)

## متغيرات البيئة المطلوبة

```env
NODE_ENV=production
PORT=3000
DATABASE_URL=postgresql://user:password@host/database
```

## Endpoints

### 1. Health Check

#### GET /api/health

التحقق من حالة الخادم

**Response:**
```json
{
  "status": "OK",
  "message": "Ratlozen Backend is running on Vercel",
  "timestamp": "2024-12-02T12:00:00.000Z",
  "environment": "production",
  "database": "Configured",
  "uptime": 3600
}
```

---

### 2. Services (الخدمات)

#### GET /api/services

الحصول على قائمة جميع الخدمات

**Response:**
```json
{
  "success": true,
  "message": "Services endpoint",
  "data": [],
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### POST /api/services

إنشاء خدمة جديدة

**Request Body:**
```json
{
  "name": "تنظيف المنزل",
  "description": "خدمة تنظيف شاملة",
  "category": "التنظيف",
  "price": 150.00,
  "isActive": true
}
```

**Response:**
```json
{
  "success": true,
  "message": "Service created",
  "data": {
    "name": "تنظيف المنزل",
    "description": "خدمة تنظيف شاملة",
    "category": "التنظيف",
    "price": 150.00,
    "isActive": true
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### GET /api/services/:id

الحصول على خدمة محددة

**Response:**
```json
{
  "success": true,
  "message": "Service 1",
  "data": {
    "id": 1
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### PUT /api/services/:id

تحديث خدمة

**Request Body:**
```json
{
  "name": "تنظيف متقدم",
  "price": 200.00
}
```

**Response:**
```json
{
  "success": true,
  "message": "Service 1 updated",
  "data": {
    "name": "تنظيف متقدم",
    "price": 200.00
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### DELETE /api/services/:id

حذف خدمة

**Response:**
```json
{
  "success": true,
  "message": "Service 1 deleted",
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

---

### 3. Products (المنتجات)

#### GET /api/products

الحصول على قائمة جميع المنتجات

**Response:**
```json
{
  "success": true,
  "message": "Products endpoint",
  "data": [],
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### POST /api/products

إنشاء منتج جديد

**Request Body:**
```json
{
  "name": "منتج 1",
  "description": "وصف المنتج",
  "price": 100.00,
  "serviceId": 1,
  "isActive": true
}
```

**Response:**
```json
{
  "success": true,
  "message": "Product created",
  "data": {
    "name": "منتج 1",
    "description": "وصف المنتج",
    "price": 100.00,
    "serviceId": 1,
    "isActive": true
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### GET /api/products/:id

الحصول على منتج محدد

#### PUT /api/products/:id

تحديث منتج

#### DELETE /api/products/:id

حذف منتج

---

### 4. Orders (الطلبات)

#### GET /api/orders

الحصول على قائمة جميع الطلبات

**Response:**
```json
{
  "success": true,
  "message": "Orders endpoint",
  "data": [],
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### POST /api/orders

إنشاء طلب جديد

**Request Body:**
```json
{
  "productId": 1,
  "quantity": 2,
  "totalPrice": 200.00,
  "status": "pending",
  "userId": "user123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Order created",
  "data": {
    "productId": 1,
    "quantity": 2,
    "totalPrice": 200.00,
    "status": "pending",
    "userId": "user123"
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### GET /api/orders/:id

الحصول على طلب محدد

#### PUT /api/orders/:id

تحديث حالة الطلب

#### DELETE /api/orders/:id

حذف طلب

---

### 5. Wallet (المحفظة الإلكترونية)

#### GET /api/wallet

الحصول على معلومات المحفظة

**Response:**
```json
{
  "success": true,
  "message": "Wallet endpoint",
  "data": {
    "balance": 0,
    "currency": "SAR"
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### POST /api/wallet/deposit

إضافة رصيد إلى المحفظة

**Request Body:**
```json
{
  "amount": 500.00,
  "method": "credit_card",
  "transactionId": "txn_123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Deposit created",
  "data": {
    "amount": 500.00,
    "method": "credit_card",
    "transactionId": "txn_123"
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### POST /api/wallet/withdraw

سحب رصيد من المحفظة

**Request Body:**
```json
{
  "amount": 100.00,
  "method": "bank_transfer",
  "accountNumber": "1234567890"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Withdrawal created",
  "data": {
    "amount": 100.00,
    "method": "bank_transfer",
    "accountNumber": "1234567890"
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

---

### 6. Notifications (الإشعارات)

#### GET /api/notifications

الحصول على قائمة الإشعارات

**Response:**
```json
{
  "success": true,
  "message": "Notifications endpoint",
  "data": [],
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### POST /api/notifications

إنشاء إشعار جديد

**Request Body:**
```json
{
  "userId": "user123",
  "title": "عنوان الإشعار",
  "message": "محتوى الإشعار",
  "type": "order_update"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Notification created",
  "data": {
    "userId": "user123",
    "title": "عنوان الإشعار",
    "message": "محتوى الإشعار",
    "type": "order_update"
  },
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

#### GET /api/notifications/:id

الحصول على إشعار محدد

#### DELETE /api/notifications/:id

حذف إشعار

---

## Error Handling

جميع الأخطاء يتم إرجاعها بالصيغة التالية:

```json
{
  "success": false,
  "error": "Error Type",
  "message": "وصف الخطأ",
  "timestamp": "2024-12-02T12:00:00.000Z"
}
```

### رموز الأخطاء الشائعة

- **400**: Bad Request - بيانات غير صحيحة
- **404**: Not Found - المورد غير موجود
- **500**: Internal Server Error - خطأ في الخادم

---

## CORS Headers

تم تفعيل CORS لجميع الطلبات:

```
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, POST, PUT, DELETE, PATCH, OPTIONS
Access-Control-Allow-Headers: Content-Type, Authorization
```

---

## أمثلة الاستخدام

### استخدام cURL

```bash
# الحصول على صحة الخادم
curl -X GET https://your-domain.railway.app/api/health

# إنشاء خدمة جديدة
curl -X POST https://your-domain.railway.app/api/services \
  -H "Content-Type: application/json" \
  -d '{
    "name": "خدمة جديدة",
    "description": "وصف",
    "category": "فئة",
    "price": 100.00
  }'
```

### استخدام Dart/Flutter

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

final baseUrl = 'https://your-domain.railway.app';

// الحصول على صحة الخادم
Future<void> checkHealth() async {
  final response = await http.get(
    Uri.parse('$baseUrl/api/health'),
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Server Status: ${data['status']}');
  }
}

// إنشاء خدمة جديدة
Future<void> createService() async {
  final response = await http.post(
    Uri.parse('$baseUrl/api/services'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': 'خدمة جديدة',
      'description': 'وصف',
      'category': 'فئة',
      'price': 100.00,
      'isActive': true,
    }),
  );
  
  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    print('Service created: ${data['data']}');
  }
}

// الحصول على جميع الخدمات
Future<void> getServices() async {
  final response = await http.get(
    Uri.parse('$baseUrl/api/services'),
  );
  
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('Services: ${data['data']}');
  }
}
```

---

## ملاحظات مهمة

1. **جميع الطلبات تدعم JSON**
2. **جميع الاستجابات تتضمن timestamp**
3. **تم تفعيل CORS لجميع الأصول**
4. **المحفظة والمعاملات تتطلب معرّف المستخدم**
5. **الإشعارات يتم إنشاؤها تلقائياً عند تحديثات الطلبات**

---

## الدعم والمساعدة

للمزيد من المعلومات، يرجى مراجعة:
- Repository: https://github.com/Ratluzen2/Ratlozen-Services
- Issues: https://github.com/Ratluzen2/Ratlozen-Services/issues

---

**آخر تحديث:** 2024-12-02
**الإصدار:** 1.0.0
