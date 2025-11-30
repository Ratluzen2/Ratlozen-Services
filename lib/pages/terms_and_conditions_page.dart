import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _isArabic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1F3A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F3A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'الشروط والأحكام',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isArabic = !_isArabic;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC107),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _isArabic ? 'EN' : 'AR',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isArabic ? _buildArabicContent() : _buildEnglishContent(),
        ),
      ),
    );
  }

  Widget _buildArabicContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2F4A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFC107), width: 1),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'بسم الله الرحمن الرحيم',
                style: TextStyle(
                  color: Color(0xFFFFC107),
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'في هذه الصفحة تجدون كل ما يهمكم بشأن شروط وأحكام متجر خدمات راتلوزن.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildTermItem(
          '• شراؤك لأي من المنتجات يعبر عن موافقتك لجميع هذه البنود في الصفحة.',
        ),
        _buildTermItem(
          '• جميع المنتجات إلكترونية غير عينية، وتصل لصفحة "الطلبات" على حسابك بالمتجر.',
        ),
        _buildTermItem(
          '• قبل الدفع يتوجب على العميل قراءة وصف المنتج بعناية.',
        ),
        _buildTermItem(
          '• شراء العميل لأي منتج يعبر عن موافقته لمواصفات وشروط المنتجات المذكورة في هذه الصفحة.',
        ),
        _buildTermItem(
          '• جميع المنتجات غير قابلة للاسترجاع والاسترداد نهائيًا.',
        ),
        _buildTermItem(
          '• أي بيانات يخطئ في تزويدها العميل للمتجر تخص الطلب، لا يتحمل المتجر أي مسؤولية في ذلك.',
        ),
        _buildTermItem(
          '• في حالة حصول خلل لأي من المنتجات، يجب على العميل توفير فيديو كامل أثناء لحظة حدوث الخلل يثبت ذلك (لن يتم قبول مشكلة بدون فيديو).',
        ),
        _buildTermItem(
          '• عند شرائك من خدمات راتلوزن فأنت تتحمل مسؤولية بياناتك التي قمت بإدخالها بنفسك.',
        ),
        _buildTermItem(
          '• بسبب الإهمال أو إدخال معلومات زائفة/خاطئة، أو أي سبب آخر قد يؤدي إلى أضرار/خسارات، فإن متجر خدمات راتلوزن غير ملزم بتبديل أو استرجاع أي منتج تم وصول بياناته إليك، وبهذا تكون قد فهمت وأقرت وقبلت إخلاء متجر خدمات راتلوزن من المسؤولية تمامًا.',
        ),
        _buildTermItem(
          '• بعد التسليم، لا يعتبر متجر خدمات راتلوزن مسؤولًا عن أي ضياع أو ضرر للسلع الإلكترونية التي تم شراؤها من خلاله، وأي خسارة أو ضرر قد يعاني منه المشتري لهذا السبب.',
        ),
        _buildTermItem(
          '• يتم تغيير الأسعار بالموقع بشكل يومي/أسبوعي/شهري، ولا يحق للعميل مطالبة الفرق إن كان هناك ارتفاع/انخفاض في الأسعار، وليس متجر خدمات راتلوزن ملزمًا بدفع الفرق أو تثبيت السعر.',
        ),
        _buildTermItem(
          '• يحق للمتجر تغيير أو إضافة بنود في هذه الصفحة في أي وقت يراه مناسبًا، ويجب على العميل متابعة البنود حتى بدون تنبيه.',
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildEnglishContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2F4A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFFC107), width: 1),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  color: Color(0xFFFFC107),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'On this page, you will find everything you need to know regarding the terms and conditions of "Ratluzen Services".',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildTermItemEnglish(
          '• Purchasing any product from the store signifies your acceptance of all the terms stated on this page.',
        ),
        _buildTermItemEnglish(
          '• All products are digital, non-physical, and will be delivered to the "Orders" section in your store account.',
        ),
        _buildTermItemEnglish(
          '• Before making a payment, the customer must carefully read the product description.',
        ),
        _buildTermItemEnglish(
          '• The purchase of any product by the customer signifies their acceptance of the product specifications and conditions mentioned on this page.',
        ),
        _buildTermItemEnglish(
          '• All products are strictly non-refundable and non-returnable.',
        ),
        _buildTermItemEnglish(
          '• The store bears no responsibility for any incorrect information provided by the customer during the order process.',
        ),
        _buildTermItemEnglish(
          '• In case of any issue with a purchased product, the customer must provide a complete video recording at the moment of purchase as proof. (Complaints will not be accepted without a video.)',
        ),
        _buildTermItemEnglish(
          '• "Ratluzen Services" is not responsible for any mistaken purchases made by the customer due to negligence, false/misleading information, or any other reason that may lead to damages or losses. The store is not obligated to replace or refund any product once the details have been delivered to you. By making a purchase, you acknowledge, understand, and accept the store\'s disclaimer of responsibility.',
        ),
        _buildTermItemEnglish(
          '• Once delivered, "Ratluzen Services" is not responsible for any loss or damage to the digital products purchased. Any loss or damage incurred by the customer after purchase is their sole responsibility.',
        ),
        _buildTermItemEnglish(
          '• Prices on the website are subject to daily/weekly/monthly changes. Customers are not entitled to claim any price difference, as prices may fluctuate due to daily promotions or adjustments. "Ratluzen Services" is not obligated to pay the difference or fix prices.',
        ),
        _buildTermItemEnglish(
          '• The store reserves the right to modify or add terms on this page at any time without prior notice. Customers are responsible for reviewing the terms regularly.',
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTermItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: 'Cairo',
          height: 1.8,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildTermItemEnglish(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          height: 1.8,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
