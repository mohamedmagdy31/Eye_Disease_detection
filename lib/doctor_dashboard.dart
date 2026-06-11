import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  // 0 يعني الشاشة الرئيسية، 1 يعني سجل الفحوصات
  int _currentScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00897B);
    const Color bgColor = Color(0xFFF7FAFC);

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 768;

    // استخدمنا الـ Builder هنا عشان يدينا Context صحيح يقدر يتحكم في الـ Drawer بدقة
    return Builder(
        builder: (scaffoldContext) {
          return Scaffold(
            backgroundColor: bgColor,
            appBar: isWeb
                ? null
                : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'عين الذكاء',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.remove_red_eye, color: primaryColor),
                ],
              ),
            ),
            // في الموبايل بنعرض السايدبار كـ Drawer، وفي الويب بنخليه null لأنه معروض ثابت في الـ body
            drawer: isWeb ? null : Drawer(child: _buildSidebar(scaffoldContext, primaryColor)),
            body: Row(
              children: [
                if (isWeb) _buildSidebar(scaffoldContext, primaryColor),
                Expanded(
                  child: _currentScreenIndex == 1
                      ? _buildDoctorHistoryScreen(primaryColor, isWeb)
                      : _buildMainDashboardHome(primaryColor, isWeb),
                ),
              ],
            ),
          );
        }
    );
  }

  // ----------------------------------------------------
  // 1. محتوى الشاشة الرئيسية (لوحة التحكم)
  // ----------------------------------------------------
  Widget _buildMainDashboardHome(Color primaryColor, bool isWeb) {
    final Widget pendingReviewsCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text('الفحوصات بانتظار المراجعة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.hourglass_empty, color: Colors.orange, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          const Text('2 حالة تحتاج مراجعتك', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 24),
          _buildPatientReviewItem(name: 'أحمد محمد', disease: 'المياه البيضاء (الساد)', progress: 0.92, percent: '92%', primaryColor: primaryColor),
          const SizedBox(height: 16),
          _buildPatientReviewItem(name: 'محمد سعيد', disease: 'اعتلال الشبكية السكري', progress: 0.88, percent: '88%', primaryColor: primaryColor),
        ],
      ),
    );

    final Widget recentActivityCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('النشاط الأخير', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(width: 8),
              Icon(Icons.bolt, color: primaryColor, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          const Text('آخر الأنشطة والإجراءات', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 24),
          _buildActivityItem('أرسل ملاحظات طبية', 'لفاطمة علي • منذ ساعة'),
          _buildActivityItem('راجع نتيجة فحص', 'لمحمد مسعود • منذ 3 ساعات'),
          _buildActivityItem('تم حجز موعد', 'أحمد محمد • منذ 5 ساعات'),
          _buildActivityItem('أرسل ملاحظات طبية', 'لسارة أحمد • أمس'),
        ],
      ),
    );

    final Widget quickStatsCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('إحصائيات سريعة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(width: 8),
              Icon(Icons.bar_chart, color: primaryColor, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          const Text('معدل المراجعة', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('33%', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
              Text('معدل المراجعة', style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: 0.33, color: primaryColor, backgroundColor: Colors.grey.shade100, minHeight: 6),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildSubStatBox(title: 'مراجعة مكتملة', value: '2', color: primaryColor)),
              const SizedBox(width: 12),
              Expanded(child: _buildSubStatBox(title: 'بانتظار', value: '2', color: Colors.orange)),
            ],
          )
        ],
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(isWeb ? 30.0 : 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('مرحباً، DR/Mohamed Magdy', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                  SizedBox(height: 4),
                  Text('طبيب عيون', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: primaryColor.withOpacity(0.1),
                radius: 24,
                child: Icon(Icons.medical_services_outlined, color: primaryColor, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 24),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isWeb ? 5 : 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: isWeb ? 1.6 : 2.2,
            children: [
              _buildTopStatCard('إجمالي المرضى', '6', Icons.people_outline, primaryColor),
              _buildTopStatCard('بانتظار المراجعة', '2', Icons.hourglass_empty, Colors.orange),
              _buildTopStatCard('تمت المراجعة', '2', Icons.check_circle_outline, Colors.green),
              _buildTopStatCard('مواعيد حجزت', '2', Icons.calendar_today_outlined, Colors.blue),
              _buildTopStatCard('فحوصات اليوم', '1', Icons.analytics_outlined, Colors.purple),
            ],
          ),
          const SizedBox(height: 24),

          isWeb
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: quickStatsCard),
              const SizedBox(width: 20),
              Expanded(flex: 1, child: recentActivityCard),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: pendingReviewsCard),
            ],
          )
              : Column(
            children: [
              pendingReviewsCard,
              const SizedBox(height: 16),
              recentActivityCard,
              const SizedBox(height: 16),
              quickStatsCard,
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // 2. محتوى شاشة سجل الفحوصات
  // ----------------------------------------------------
  Widget _buildDoctorHistoryScreen(Color primaryColor, bool isWeb) {
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

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isWeb ? 4 : 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: isWeb ? 1.8 : 2.2,
            children: [
              _buildTopStatCard('إجمالي الفحوصات', '6', Icons.analytics_outlined, Colors.blue),
              _buildTopStatCard('بانتظار المراجعة', '2', Icons.hourglass_empty, Colors.orange),
              _buildTopStatCard('تمت المراجعة', '2', Icons.check_circle_outline, Colors.green),
              _buildTopStatCard('مواعيد حجزت', '2', Icons.calendar_today_outlined, Colors.purple),
            ],
          ),
          const SizedBox(height: 24),

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
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Column(
            children: [
              _buildHistoryItem(
                name: 'عائشة ناصر Magdy',
                tag: 'موعد مستعجل',
                tagColor: Colors.teal,
                disease: 'المياه البيضاء (الساد)',
                details: 'تشخيص أولي للفحص بناءً على دقة النموذج الحالية ووضع خطة العلاج المناسبة.',
                progress: 0.92,
                percent: '92%',
                primaryColor: primaryColor,
              ),
              _buildHistoryItem(
                name: 'أحمد محمد',
                tag: 'بانتظار المراجعة',
                tagColor: Colors.orange,
                disease: 'المياه البيضاء (الساد)',
                details: 'الحالة قيد الدراسة وفي انتظار مراجعة دقيقة من الطبيب المختص لتأكيد النتيجة المبدئية.',
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

  // ----------------------------------------------------
  // 3. بناء الـ Sidebar والتنقل التفاعلي الذكي
  // ----------------------------------------------------
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
          _sidebarItem('الرئيسية', Icons.home, _currentScreenIndex == 0, primaryColor, () {
            setState(() {
              _currentScreenIndex = 0;
            });
            // لو الـ Drawer مفتوح (في الموبايل)، بنقفله بشكل آمن من غير ما يأثر على الـ Navigation
            if (Scaffold.of(context).isDrawerOpen) {
              Navigator.pop(context);
            }
          }),
          _sidebarItem('سجل الفحوصات', Icons.history, _currentScreenIndex == 1, primaryColor, () {
            setState(() {
              _currentScreenIndex = 1;
            });
            // لو الـ Drawer مفتوح (في الموبايل)، بنقفله بشكل آمن من غير ما يأثر على الـ Navigation
            if (Scaffold.of(context).isDrawerOpen) {
              Navigator.pop(context);
            }
          }),
          _sidebarItem('الإعدادات', Icons.settings, false, primaryColor, () {}),
          const Spacer(),
          _sidebarItem('الوضع الليلي', Icons.dark_mode_outlined, false, primaryColor, () {}),
          _sidebarItem('تسجيل الخروج', Icons.logout, false, Colors.red, () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }, isExit: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sidebarItem(String title, IconData icon, bool isActive, Color primaryColor, VoidCallback onTap, {bool isExit = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : (isExit ? Colors.red : Colors.black87),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        leading: Icon(icon, color: isActive ? Colors.white : (isExit ? Colors.red : Colors.black54)),
        dense: true,
      ),
    );
  }

  // ----------------------------------------------------
  // 4. الـ Widgets المساعدة للأشكال والكروت
  // ----------------------------------------------------
  Widget _buildTopStatCard(String title, String value, IconData icon, Color color) {
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
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientReviewItem({required String name, required String disease, required double progress, required String percent, required Color primaryColor}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade100), borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: const Text('بانتظار المراجعة', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 4),
          Text(disease, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('نسبة الحالة', style: TextStyle(color: Colors.grey, fontSize: 11)),
              Text(percent, style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: progress, color: primaryColor, backgroundColor: Colors.grey.shade100, minHeight: 4),
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
      margin: const EdgeInsets.only(top: 16),
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

  Widget _buildActivityItem(String action, String details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(action, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(details, style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.circle, size: 6, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildSubStatBox({required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: const Color(0xFFF7FAFC), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }
}