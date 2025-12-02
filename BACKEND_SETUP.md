# Ratlozen Services Backend - دليل الإعداد والنشر

## 📌 نظرة عامة

هذا الدليل يشرح كيفية إعداد ونشر واجهة برمجية (API) متكاملة لتطبيق Ratlozen Services على Railway.

## 🔧 المتطلبات

- Node.js >= 18.0.0
- npm أو yarn
- حساب على [Railway.app](https://railway.app) (مجاني)
- حساب على [Neon](https://neon.tech) (PostgreSQL مجاني)

## 📦 التثبيت المحلي

### 1. استنساخ المستودع

```bash
git clone https://github.com/Ratluzen2/Ratlozen-Services.git
cd Ratlozen-Services
```

### 2. تثبيت المكتبات

```bash
npm install
```

### 3. إعداد متغيرات البيئة

```bash
# نسخ ملف المثال
cp .env.example .env

# تحديث .env بالقيم الصحيحة
nano .env
```

**المتغيرات المطلوبة:**

```env
NODE_ENV=production
PORT=3000
DATABASE_URL=postgresql://neondb_owner:npg_7s4DtFNTkoLJ@ep-super-pine-a4jbxnal-pooler.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require
```

### 4. تشغيل الخادم

```bash
# في بيئة التطوير
npm run dev

# في بيئة الإنتاج
npm start
```

الخادم سيعمل على: `http://localhost:3000`

## 🚀 النشر على Railway

### الخطوة 1: إنشاء حساب Railway

1. اذهب إلى [railway.app](https://railway.app)
2. اضغط على **"Start for Free"**
3. اختر **"GitHub"** للتسجيل
4. أكمل عملية التسجيل

### الخطوة 2: إنشاء مشروع جديد

1. اذهب إلى [لوحة التحكم](https://railway.app/dashboard)
2. اضغط على **"New Project"**
3. اختر **"Deploy from GitHub repo"**
4. اختر **"Ratluzen2/Ratlozen-Services"**
5. اختر branch **"main"**
6. اضغط **"Deploy"**

### الخطوة 3: إضافة متغيرات البيئة

1. في لوحة تحكم Railway، اذهب إلى المشروع
2. اختر **"Variables"** أو **"Environment"**
3. أضف المتغيرات التالية:

| المتغير | القيمة |
|--------|--------|
| `NODE_ENV` | `production` |
| `PORT` | `3000` |
| `DATABASE_URL` | رابط قاعدة البيانات من Neon |

### الخطوة 4: الحصول على رابط الخادم

1. في لوحة تحكم Railway، اختر الخدمة
2. ابحث عن **"Deployments"** أو **"Settings"**
3. انسخ **"Public URL"** أو **"Domain"**

مثال: `https://ratlozen-services.railway.app`

## 🗄️ إعداد قاعدة البيانات (Neon)

### الخطوة 1: إنشاء قاعدة بيانات

1. اذهب إلى [neon.tech](https://neon.tech)
2. اضغط على **"Sign Up"**
3. اختر **"GitHub"** للتسجيل
4. أنشئ مشروع جديد

### الخطوة 2: الحصول على رابط الاتصال

1. في لوحة تحكم Neon، اختر المشروع
2. اذهب إلى **"Connection String"**
3. انسخ الرابط الكامل (يبدأ بـ `postgresql://`)

### الخطوة 3: إضافة رابط الاتصال إلى Railway

أضف `DATABASE_URL` في متغيرات البيئة في Railway

## 📊 هيكل قاعدة البيانات

### جدول Services (الخدمات)

```sql
CREATE TABLE services (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  category VARCHAR(100),
  price DECIMAL(10, 2),
  isActive BOOLEAN DEFAULT true,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### جدول Products (المنتجات)

```sql
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2),
  serviceId INTEGER REFERENCES services(id),
  isActive BOOLEAN DEFAULT true,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### جدول Orders (الطلبات)

```sql
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  productId INTEGER REFERENCES products(id),
  quantity INTEGER,
  totalPrice DECIMAL(10, 2),
  status VARCHAR(50) DEFAULT 'pending',
  userId VARCHAR(255),
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### جدول Wallet (المحفظة)

```sql
CREATE TABLE wallet (
  id SERIAL PRIMARY KEY,
  userId VARCHAR(255) UNIQUE NOT NULL,
  balance DECIMAL(10, 2) DEFAULT 0,
  currency VARCHAR(3) DEFAULT 'SAR',
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### جدول Notifications (الإشعارات)

```sql
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  userId VARCHAR(255),
  title VARCHAR(255),
  message TEXT,
  type VARCHAR(50),
  isRead BOOLEAN DEFAULT false,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🧪 اختبار الـ API

### استخدام cURL

```bash
# الحصول على صحة الخادم
curl https://your-domain.railway.app/api/health

# الحصول على جميع الخدمات
curl https://your-domain.railway.app/api/services

# إنشاء خدمة جديدة
curl -X POST https://your-domain.railway.app/api/services \
  -H "Content-Type: application/json" \
  -d '{
    "name": "تنظيف المنزل",
    "description": "خدمة تنظيف شاملة",
    "category": "التنظيف",
    "price": 150.00,
    "isActive": true
  }'
```

### استخدام Postman

1. افتح [Postman](https://www.postman.com)
2. أنشئ request جديد
3. اختر الـ method (GET, POST, PUT, DELETE)
4. أدخل الرابط: `https://your-domain.railway.app/api/...`
5. أضف Headers: `Content-Type: application/json`
6. أضف Body (إذا لزم الأمر)
7. اضغط **"Send"**

## 🔍 استكشاف الأخطاء

### خطأ: Application not found

**السبب:** الخادم لم يتم نشره بعد أو الرابط خاطئ

**الحل:**
1. تحقق من لوحة تحكم Railway
2. تأكد من انتهاء النشر (Status: Success)
3. انسخ الرابط الصحيح

### خطأ: DATABASE_URL not found

**السبب:** متغير البيئة لم يتم إضافته

**الحل:**
1. اذهب إلى Railway Dashboard
2. اختر المشروع
3. اذهب إلى Variables
4. أضف `DATABASE_URL`

### خطأ: Connection refused

**السبب:** قاعدة البيانات غير متاحة

**الحل:**
1. تحقق من أن Neon تعمل
2. تحقق من صحة رابط الاتصال
3. تأكد من أن SSL مفعل

## 📱 استخدام الـ API من Flutter

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class RatlozenAPI {
  static const String baseUrl = 'https://your-domain.railway.app';

  // الحصول على الخدمات
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

  // إنشاء طلب
  static Future<void> createOrder({
    required int productId,
    required int quantity,
    required double totalPrice,
    required String userId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/orders'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'productId': productId,
          'quantity': quantity,
          'totalPrice': totalPrice,
          'status': 'pending',
          'userId': userId,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // إضافة رصيد
  static Future<void> depositWallet({
    required double amount,
    required String method,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/wallet/deposit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'method': method,
          'transactionId': 'txn_${DateTime.now().millisecondsSinceEpoch}',
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to deposit');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
```

## 📚 الموارد الإضافية

- [توثيق API الكاملة](./API_DOCUMENTATION.md)
- [Railway Documentation](https://docs.railway.app)
- [Neon Documentation](https://neon.tech/docs)
- [Express.js Guide](https://expressjs.com)

## 🤝 المساعدة والدعم

إذا واجهت أي مشاكل:

1. تحقق من [GitHub Issues](https://github.com/Ratluzen2/Ratlozen-Services/issues)
2. أنشئ issue جديد مع وصف المشكلة
3. تواصل مع الفريق عبر البريد الإلكتروني

---

**آخر تحديث:** 2024-12-02
**الإصدار:** 1.0.0
