import 'package:flutter/material.dart';
import 'diagnosis_screen.dart'; // شاشة فحص جديد
import 'history_screen.dart';   // شاشة سجل الفحوصات
import 'settings_screen.dart';  // إستيراد شاشة الإعدادات المضافة حديثاً

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = const Color(0xFF00897B);
    Color bgColor = const Color(0xFFF7FAFC);

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 768;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: isWeb
          ? null
          : AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.remove_red_eye, color: primaryColor),
            const SizedBox(width: 8),
            const Text('عين الذكاء', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        // إضافة أيقونة الإعدادات في الـ AppBar للموبايل
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black54),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWeb) _buildSidebar(context, primaryColor),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isWeb ? 30.0 : 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'مرحباً، Mohamed Magdy',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                          ),
                          const SizedBox(height: 4),
                          const Text('نتمنى لك صحة جيدة وعيوناً سليمة', style: TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                      if (isWeb)
                        ElevatedButton.icon(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosisScreen())),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text('فحص جديد', style: TextStyle(color: Colors.white)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  if (!isWeb) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosisScreen())),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        icon: const Icon(Icons.search, color: Colors.white),
                        label: const Text('فحص جديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isWeb ? 3 : 1,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: isWeb ? 2.2 : 3.5,
                    children: [
                      _StatCard(title: 'إجمالي الفحوصات', value: '0', icon: Icons.analytics_outlined, iconColor: primaryColor),
                      _StatCard(title: 'بانتظار Mراجعة', value: '0', icon: Icons.hourglass_empty, iconColor: Colors.orange),
                      _StatCard(title: 'مواعيد قادمة', value: '0', icon: Icons.calendar_today, iconColor: Colors.blue),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: isWeb ? 2 : 1,
                        child: _buildResultsCard(context, primaryColor),
                      ),
                      if (isWeb) const SizedBox(width: 20),
                      if (isWeb)
                        Expanded(
                          flex: 1,
                          child: _buildTipsCard(primaryColor),
                        ),
                    ],
                  ),

                  if (!isWeb) ...[
                    const SizedBox(height: 20),
                    _buildTipsCard(primaryColor),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, Color primaryColor) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          ListTile(
            leading: Icon(Icons.remove_red_eye, color: primaryColor, size: 30),
            title: const Text('عين الذكاء', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: const Text('نظام تشخيص العيون', style: TextStyle(fontSize: 12)),
          ),
          const Divider(),
          const SizedBox(height: 20),
          _sidebarItem(context, Icons.home, 'الرئيسية', true, primaryColor, () {}),
          _sidebarItem(context, Icons.search, 'فحص جديد', false, primaryColor, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosisScreen()));
          }),
          _sidebarItem(context, Icons.history, 'سجل الفحوصات', false, primaryColor, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
          }),
          // تفعيل زرار الإعدادات في الويب (السايد بار)
          _sidebarItem(context, Icons.settings, 'الإعدادات', false, primaryColor, () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }),
          const Spacer(),
          _sidebarItem(context, Icons.dark_mode_outlined, 'الوضع الليلي', false, primaryColor, () {}),
          _sidebarItem(context, Icons.logout, 'تسجيل الخروج', false, Colors.red, () {
            Navigator.pop(context);
          }, isExit: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sidebarItem(BuildContext context, IconData icon, String title, bool isActive, Color primaryColor, VoidCallback onTap, {bool isExit = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isActive ? Colors.white : (isExit ? Colors.red : Colors.black54)),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : (isExit ? Colors.red : Colors.black87),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        dense: true,
        onTap: onTap,
      ),
    );
  }

  Widget _buildResultsCard(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('آخر نتائج الفحص', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen())),
                child: const Text('عرض الكل', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Icon(Icons.visibility_off_outlined, size: 50, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                const Text('لا توجد فحوصات سابقة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 6),
                const Text('ابدأ بإجراء أول فحص لعينك الآن', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosisScreen())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: const Text('افحص جديد', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTipsCard(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_border, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              const Text('نصائح صحية للعيون', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          const Text('حافظ على صحة عينيك دائماً', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 24),
          _tipItem('فحص دوري للعيون', 'ينصح بإجراء فحص شامل للعيون مرة كل سنة على الأقل.', Icons.check_circle_outline, primaryColor),
          _tipItem('ترطيب العيون', 'استخدم قطرات مرطبة للعيون إذا كنت تعمل على الشاشات لفترات طويلة.', Icons.water_drop_outlined, primaryColor),
          _tipItem('حماية من الأشعة', 'ارتدِ نظارات شمسية مع حماية UV عند الخروج نهاراً.', Icons.wb_sunny_outlined, primaryColor),
          _tipItem('تغذية صحية', 'تناول الأطعمة الغنية بفيتامين A والأوميجا 3 لصحة أفضل للعين.', Icons.restaurant, primaryColor),
        ],
      ),
    );
  }

  Widget _tipItem(String title, String desc, IconData icon, Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 6),
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
        ],
      ),
    );
  }
}