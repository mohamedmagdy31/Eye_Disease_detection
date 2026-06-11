import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'جميع الفحوصات';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'سجل الفحوصات',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isWeb ? 30.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان العلوي (يظهر في الويب)
            if (isWeb) ...[
              const Text(
                'سجل الفحوصات',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
              ),
              const SizedBox(height: 4),
              const Text('تاريخ فحوصاتك السابقة', style: TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 24),
            ],

            // 1. قسم الإحصائيات (كروت العدادات الأربعة)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isWeb ? 4 : 1, // 4 جنب بعض في الويب، وتحت بعض في الموبايل
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: isWeb ? 2.5 : 4.0,
              children: [
                _buildMiniStatCard('إجمالي', '0', Icons.analytics_outlined, primaryColor),
                _buildMiniStatCard('بانتظار', '0', Icons.hourglass_empty, Colors.orange),
                _buildMiniStatCard('مراجعة', '0', Icons.check_circle_outline, Colors.teal.shade700),
                _buildMiniStatCard('مواعيد', '0', Icons.calendar_today, Colors.blue),
              ],
            ),
            const SizedBox(height: 20),

            // 2. شريط البحث والفلترة (متجاوب حسب الشاشة)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: isWeb
                  ? Row(
                children: [
                  _buildFilterDropdown(),
                  const SizedBox(width: 12),
                  Expanded(child: _buildSearchField()),
                ],
              )
                  : Column(
                children: [
                  _buildSearchField(),
                  const SizedBox(height: 10),
                  _buildFilterDropdown(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. كارت عرض الفحوصات الرئيسي (الـ Empty State من الصورة 1000083750.jpg)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // محاذاة النص لليمين حسب التصميم
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'عرض 0 من 0 فحص',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        'الفحوصات',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF2D3748)),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.assignment_outlined, color: Colors.black54, size: 20),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7FAFC),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Icon(Icons.visibility_off_outlined, size: 36, color: Colors.grey.shade400),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'لا توجد نتائج',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D3748)),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'لم يتم إجراء أي فحوصات بعد',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت بناء حقل البحث
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: 'بحث بالاسم أو التشخيص...',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
        filled: true,
        fillColor: const Color(0xFFF7FAFC),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }

  // ودجت قائمة الفلترة المنسدلة
  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedFilter,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          items: <String>['جميع الفحوصات', 'بانتظار', 'مراجعة', 'مواعيد']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 13)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedFilter = newValue!;
            });
          },
        ),
      ),
    );
  }

  // ودجت كروت الإحصائيات الصغيرة العلوية
  Widget _buildMiniStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}