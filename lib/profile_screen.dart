import 'package:flutter/material.dart';
import 'history_screen.dart';
import 'tips_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // الألوان المعتمدة في تصميم الفيجما بدقة
    const Color primaryColor = Color(0xFF00897B);
    const Color textColor = Color(0xFF2D3748);

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFC), // خلفية متناسقة مع حقول الدخول الفاتحة
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // قسم الهيدر (صورة الحساب والاسم)
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xFFEDF2F7),
              child: Icon(Icons.person, size: 55, color: primaryColor.withOpacity(0.8)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Basant',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor),
            ),
            const Text(
              'Basant@example.com',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // زر سجل الفحوصات الطبية
            _buildProfileButton(
              context: context,
              icon: Icons.history,
              label: 'Medical Tests Record',
              primaryColor: primaryColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                );
              },
            ),

            const SizedBox(height: 14),

            // زر النصائح والإرشادات الطبية
            _buildProfileButton(
              context: context,
              icon: Icons.lightbulb_outline,
              label: 'Medical Advice and Guidelines',
              primaryColor: primaryColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TipsScreen()),
                );
              },
            ),

            const Spacer(), // دفع زر تسجيل الخروج إلى أسفل الشاشة تماماً لتنسيق الواجهة

            // زر تسجيل الخروج (تم تصحيح الإيرور هنا باستخدام onPressed)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // استبدل '/login' باسم راوت شاشة الدخول الحقيقي المعتمد في تطبيقك
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53E3E), // لون أحمر تحذيري هادئ ومتناسق
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // حواف الفيجما الموحدة 8 بكسل
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // الـ Widget المساعد لإنشاء أزرار القائمة بشكل موحد ومتناسق مع التصميم
  Widget _buildProfileButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color primaryColor,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8), // حواف الفيجما الموحدة 8 بكسل
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: primaryColor, size: 24),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF2D3748)),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}