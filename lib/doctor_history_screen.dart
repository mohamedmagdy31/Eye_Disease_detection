import 'package:flutter/material.dart';

class DoctorHistoryScreen extends StatelessWidget {
  const DoctorHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00897B);
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 768;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isWeb ? 30.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'سجل الفحوصات',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
          ),
          const SizedBox(height: 4),
          const Text(
            'جميع فحوصات المرضى وحالاتهم',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 24),

          // 1. الكروت الإحصائية الأربعة العلوية
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isWeb ? 4 : 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: isWeb ? 1.8 : 2.2,
            children: [
              _buildStatCard('إجمالي', '6', Icons.analytics_outlined, Colors.blue),
              _buildStatCard('بانتظار', '2', Icons.hourglass_empty, Colors.orange),
              _buildStatCard('مراجعة', '2', Icons.check_circle_outline, Colors.green),
              _buildStatCard('مواعيد', '2', Icons.calendar_today_outlined, Colors.purple),
            ],
          ),
          const SizedBox(height: 24),

          // 2. شريط البحث والفلترة (تم إصلاح الإيرور هنا)
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('جميع الفحوصات', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: '...بحث باستخدام الفحوصات',
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 3. قائمة الفحوصات
          Column(
            children: [
              _buildHistoryItem(
                name: 'عائشة ناصر Magdy', // تم تعديل الاسم هنا
                tag: 'موعد مستعجل',
                tagColor: Colors.teal,
                disease: 'المياه البيضاء (الساد)',
                details: 'تشخيص أولى للفحص بناءً على دقة النموذج الحالية ووضع خطة العلاج المناسبة.',
                progress: 0.92,
                percent: '92%',
                primaryColor: primaryColor,
              ),
              _buildHistoryItem(
                name: 'أحمد محمد',
                tag: 'بانتظار المراجعة',
                tagColor: Colors.orange,
                disease: 'المياه البيضاء (الساد)',
                details: 'الحالة قيد الدراسة وفي انتظار مراجعة دقيقة من الطبيب المختص.',
                progress: 0.92,
                percent: '92%',
                primaryColor: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 18),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required String name,
    required String tag,
    required Color tagColor,
    required String disease,
    required String details,
    required double progress,
    required String percent,
    required Color primaryColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: tagColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                child: Text(tag, style: TextStyle(color: tagColor, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              Row(
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(width: 8),
                  const Icon(Icons.assignment_ind_outlined, size: 18, color: Colors.grey),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(disease, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 6),
          Text(
            details,
            textAlign: TextAlign.right,
            style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text('عرض التفاصيل', style: TextStyle(color: Colors.black87, fontSize: 12)),
              ),
              Row(
                children: [
                  Text(percent, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 80,
                    child: LinearProgressIndicator(value: progress, color: primaryColor, backgroundColor: Colors.grey.shade100, minHeight: 4),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}