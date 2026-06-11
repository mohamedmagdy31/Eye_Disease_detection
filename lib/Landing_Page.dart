import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00897B);
    const Color backgroundColor = Color(0xFFF7FAFC);

    // معرفة عرض الشاشة لتحديد التصميم (ويب أم موبايل)
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 768;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.remove_red_eye, color: primaryColor),
            const SizedBox(width: 8),
            Text(
              isWeb ? 'نظام الكشف الذكي لأمراض العيون' : 'عين الذكاء',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('تسجيل الدخول', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isWeb ? screenWidth * 0.1 : 20.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. الهيدر الرئيسي (Hero Section)
              const SizedBox(height: 20),
              const Text(
                'نظام الكشف الذكي\nلأمراض العيون',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.3, color: Color(0xFF2D3748)),
              ),
              const SizedBox(height: 16),
              const Text(
                'استخدام تقنيات الذكاء الاصطناعي للكشف المبكر عن أمراض العين مثل المياه البيضاء والزرقاء واعتلال الشبكية السكري بدقة استثنائية.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('ابدأ الآن مجاناً', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),

              const SizedBox(height: 40),
              // الإحصائيات
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _StatItem(number: '98%', label: 'دقة الفحص'),
                  _StatItem(number: '+10K', label: 'حالات تم فحصها'),
                  _StatItem(number: '+50', label: 'طبيب معتمد'),
                ],
              ),

              const SizedBox(height: 60),
              // 2. قسم الأمراض التي نكشف عنها
              const Text('الأمراض التي نكشف عنها', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('أنظمة قائمة على خوارزميات متطورة للتعرف على أمراض العيون الشهيرة', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isWeb ? 3 : 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: isWeb ? 1.5 : 3,
                children: const [
                  _DiseaseCard(title: 'المياه البيضاء (الكاتاركت)', icon: Icons.remove_red_eye),
                  _DiseaseCard(title: 'الجلوكوما (المياه الزرقاء)', icon: Icons.remove_red_eye_sharp),
                  _DiseaseCard(title: 'اعتلال الشبكية السكري', icon: Icons.visibility_outlined),
                ],
              ),

              const SizedBox(height: 60),
              // 3. قسم لماذا تختار نظامنا؟
              const Text('لماذا تختار نظامنا؟', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isWeb ? 3 : 1,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: isWeb ? 1.5 : 3.5,
                children: const [
                  _FeatureItem(title: 'تشخيص فوري', desc: 'احصل على نتائج التشخيص في ثوانٍ معدودة باستخدام أحدث تقنيات الذكاء الاصطناعي.', icon: Icons.flash_on),
                  _FeatureItem(title: 'دقة عالية', desc: 'نظامنا يحقق نسبة دقة تصل إلى 98% في فحص وتصنيف الصور الطبية للعين.', icon: Icons.gpp_good),
                  _FeatureItem(title: 'متابعة طبية', desc: 'إمكانية حفظ سجلات الفحص والتشخيص للرجوع إليها في أي وقت وتتبع الحالة.', icon: Icons.history_edu),
                ],
              ),

              const SizedBox(height: 60),
              // 4. بنر دعائي سفلي (ابدأ رحلتك)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: primaryColor.withOpacity(0.2)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.remove_red_eye_outlined, size: 40, color: primaryColor),
                    const SizedBox(height: 16),
                    const Text('ابدأ رحلتك نحو عيون صحية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
                    const SizedBox(height: 8),
                    const Text('انضم إلينا الآن وقم بإجراء أول فحص لعينك مجاناً وبمنتهى السهولة', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('سجل الآن مجاناً', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// عناصر المساعدين (Widgets) لتنظيم الكود وتطابق التصميم:
class _StatItem extends StatelessWidget {
  final String number;
  final String label;
  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(number, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00897B))),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

class _DiseaseCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const _DiseaseCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF00897B), size: 30),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;
  const _FeatureItem({required this.title, required this.desc, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF00897B), size: 24),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 6),
          Expanded(child: Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.3), overflow: TextOverflow.ellipsis, maxLines: 3)),
        ],
      ),
    );
  }
}