# Ratlozen Services Backend API

Backend API لتطبيق Ratlozen Services المبني بـ Node.js و Express.

## المميزات

- ✅ API RESTful متكاملة
- ✅ قاعدة بيانات SQLite مع Sequelize ORM
- ✅ إدارة الخدمات والمنتجات
- ✅ نظام الطلبات والتتبع
- ✅ محفظة إلكترونية مع المعاملات
- ✅ نظام الإشعارات
- ✅ معالجة الأخطاء الشاملة

## المتطلبات

- Node.js 14+
- npm أو yarn

## التثبيت

```bash
cd backend
npm install
```

## الإعدادات

أنشئ ملف `.env` بالمتغيرات التالية:

```env
PORT=3000
NODE_ENV=development
DATABASE_URL=./database.sqlite
JWT_SECRET=your_jwt_secret_key_change_in_production
API_BASE_URL=http://localhost:3000
```

## تشغيل الخادم

### وضع التطوير (مع المراقبة)

```bash
npm run dev
```

### وضع الإنتاج

```bash
npm start
```

## API Endpoints

### الخدمات (Services)

- `GET /api/services` - الحصول على جميع الخدمات
- `GET /api/services/:id` - الحصول على خدمة محددة
- `POST /api/services` - إنشاء خدمة جديدة
- `PUT /api/services/:id` - تحديث خدمة
- `DELETE /api/services/:id` - حذف خدمة

### المنتجات (Products)

- `GET /api/products` - الحصول على جميع المنتجات
- `GET /api/products/service/:serviceId` - الحصول على منتجات خدمة معينة
- `GET /api/products/:id` - الحصول على منتج محدد
- `POST /api/products` - إنشاء منتج جديد
- `PUT /api/products/:id` - تحديث منتج
- `DELETE /api/products/:id` - حذف منتج

### الطلبات (Orders)

- `GET /api/orders/user/:userId` - الحصول على طلبات المستخدم
- `GET /api/orders/:id` - الحصول على طلب محدد
- `POST /api/orders` - إنشاء طلب جديد
- `PUT /api/orders/:id/status` - تحديث حالة الطلب
- `GET /api/orders/status/:status` - الحصول على الطلبات حسب الحالة

### المحفظة (Wallet)

- `GET /api/wallet/:userId` - الحصول على رصيد المحفظة
- `POST /api/wallet/:userId/add` - إضافة رصيد
- `POST /api/wallet/:userId/withdraw` - سحب رصيد
- `GET /api/wallet/:userId/transactions` - الحصول على سجل المعاملات

### الإشعارات (Notifications)

- `GET /api/notifications/user/:userId` - الحصول على جميع الإشعارات
- `GET /api/notifications/user/:userId/unread` - الحصول على الإشعارات غير المقروءة
- `GET /api/notifications/:id` - الحصول على إشعار محدد
- `POST /api/notifications` - إنشاء إشعار جديد
- `PUT /api/notifications/:id/read` - تحديد الإشعار كمقروء
- `DELETE /api/notifications/:id` - حذف إشعار

## أمثلة الاستخدام

### إنشاء خدمة جديدة

```bash
curl -X POST http://localhost:3000/api/services \
  -H "Content-Type: application/json" \
  -d '{
    "name": "خدمة التنظيف",
    "description": "خدمة تنظيف منزلية احترافية",
    "category": "تنظيف",
    "price": 150.00
  }'
```

### إنشاء طلب جديد

```bash
curl -X POST http://localhost:3000/api/orders \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "productId": 1,
    "quantity": 2,
    "paymentMethod": "wallet"
  }'
```

### إضافة رصيد للمحفظة

```bash
curl -X POST http://localhost:3000/api/wallet/1/add \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 500,
    "description": "إضافة رصيد يدوية"
  }'
```

## هيكل المشروع

```
backend/
├── models/              # نماذج قاعدة البيانات
│   ├── Service.js
│   ├── Product.js
│   ├── Order.js
│   ├── Wallet.js
│   ├── Transaction.js
│   └── Notification.js
├── routes/              # مسارات API
│   ├── services.js
│   ├── products.js
│   ├── orders.js
│   ├── wallet.js
│   └── notifications.js
├── server.js            # ملف الخادم الرئيسي
├── .env                 # متغيرات البيئة
├── package.json         # المكتبات والمتطلبات
└── README.md            # هذا الملف
```

## الترخيص

MIT

## الدعم

للمزيد من المعلومات، يرجى التواصل مع فريق Ratlozen.
