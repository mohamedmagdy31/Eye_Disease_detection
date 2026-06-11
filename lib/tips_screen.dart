import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // كود اللون التيل المعتمد في الفيجما بدقة
    const Color primaryColor = Color(0xFF00897B);

    // قائمة النصائح الطبية للعناية بالعين
    final List<Map<String, dynamic>> tips = [
      {
        'title': 'قاعدة 20-20-20 اليومية',
        'desc': 'كل 20 دقيقة عمل على الشاشة، انظر لأي مجسم يبعد عنك 20 قدمًا لمدة 20 ثانية لتخفيف إجهاد عضلات العين.',
        'icon': Icons.timer_outlined
      },
      {
        'title': 'تنظيم إضاءة المحيط',
        'desc': 'تجنب تصفح الهاتف تماماً في الغرف المظلمة؛ اجعل إضاءة الغرفة متناسقة مع سطوع شاشتك.',
        'icon': Icons.lightbulb_outline
      },
      {
        'title': 'الفحوصات الدورية المجدولة',
        'desc': 'احرص على إجراء فحص قاع العين السنوي بشكل منتظم، خاصة إذا كنت تستخدم الشاشات لفترات طويلة.',
        'icon': Icons.remove_red_eye_outlined
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC),
      appBar: AppBar(
        title: const Text(
          'Medical Advice and Guidelines',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // حواف مطابقة للفيجما 8 بكسل
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF2F7), // نفس لون حقول الدخول الفاتحة
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(tips[index]['icon'], color: primaryColor, size: 24),
                ),
                title: Text(
                  tips[index]['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    tips[index]['desc'],
                    style: const TextStyle(color: Color(0xFF4A5568), height: 1.4, fontSize: 14),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}