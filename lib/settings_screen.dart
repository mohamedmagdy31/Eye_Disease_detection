import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // كونتولرز الملف الشخصي
  final TextEditingController _nameController = TextEditingController(text: 'Mohamed Magdy');
  final TextEditingController _emailController = TextEditingController(text: 'mohamedmagdy31@gmail.com');
  final TextEditingController _phoneController = TextEditingController(text: '+966 5XX XXX XXX');

  // كونتولرز كلمة المرور
  final TextEditingController _currentPasswordController = TextEditingController(text: '123456');
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // حالات أزرار الإشعارات (Switches)
  bool _emailNotifications = true;
  bool _smsNotifications = true;
  bool _appointmentReminders = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00897B);
    const Color bgColor = Color(0xFFF7FAFC);

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 768;

    // 1. كارت الملف الشخصي
    final Widget profileCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('الملف الشخصي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.person_outline, color: Colors.black54, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          const Text('تحديث معلوماتك الشخصية', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 24),
          _buildTextField(label: 'الاسم', controller: _nameController),
          const SizedBox(height: 16),
          _buildTextField(label: 'البريد الإلكتروني', controller: _emailController, alignLeft: true),
          const SizedBox(height: 16),
          _buildTextField(label: 'رقم الهاتف', controller: _phoneController, alignLeft: true),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              icon: const Icon(Icons.save_outlined, color: Colors.white, size: 18),
              label: const Text('حفظ التغييرات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ],
      ),
    );

    // 2. كارت تغيير كلمة المرور
    final Widget passwordCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('تغيير كلمة المرور', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.lock_outline, color: Colors.black54, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          const Text('تحديث كلمة المرور الخاصة بك', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 24),
          _buildTextField(label: 'كلمة المرور الحالية', controller: _currentPasswordController, isPassword: true),
          const SizedBox(height: 16),
          _buildTextField(label: 'كلمة المرور الجديدة', controller: _newPasswordController, isPassword: true, hint: 'أدخل كلمة المرور الجديدة'),
          const SizedBox(height: 16),
          _buildTextField(label: 'تأكيد كلمة المرور', controller: _confirmPasswordController, isPassword: true, hint: 'أعد إدخال كلمة المرور الجديدة'),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              icon: const Icon(Icons.lock_reset, color: Colors.white, size: 18),
              label: const Text('تحديث كلمة المرور', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ],
      ),
    );

    // 3. كارت الإشعارات العريض
    final Widget notificationsCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('الإشعارات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.notifications_none_outlined, color: Colors.black54, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          const Text('إدارة تفضيلات الإشعارات', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 24),
          _buildNotificationSwitch(
            title: 'إشعارات البريد الإلكتروني',
            subtitle: 'استلام إشعارات عند وجود تحديثات على الفحوصات',
            value: _emailNotifications,
            onChanged: (val) => setState(() => _emailNotifications = val),
            activeColor: primaryColor,
          ),
          const Divider(height: 20),
          _buildNotificationSwitch(
            title: 'إشعارات الرسائل النصية',
            subtitle: 'استلام رسائل SMS للمواعيد والتذكيرات',
            value: _smsNotifications,
            onChanged: (val) => setState(() => _smsNotifications = val),
            activeColor: primaryColor,
          ),
          const Divider(height: 20),
          _buildNotificationSwitch(
            title: 'تذكير المواعيد',
            subtitle: 'تذكير قبل الموعد بـ 24 ساعة',
            value: _appointmentReminders,
            onChanged: (val) => setState(() => _appointmentReminders = val),
            activeColor: primaryColor,
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'الإعدادات',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isWeb ? 30.0 : 16.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isWeb ? 1100 : double.infinity),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الإعدادات',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'إدارة حسابك وتفضيلاتك',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 24),
                isWeb
                    ? Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: passwordCard),
                        const SizedBox(width: 20),
                        Expanded(child: profileCard),
                      ],
                    ),
                    const SizedBox(height: 20),
                    notificationsCard,
                  ],
                )
                    : Column(
                  children: [
                    profileCard,
                    const SizedBox(height: 16),
                    passwordCard,
                    const SizedBox(height: 16),
                    notificationsCard,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ويدجت مساعدة لبناء حقول الإدخال متطابقة مع التصميم
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool alignLeft = false,
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: isPassword,
          textAlign: alignLeft ? TextAlign.left : TextAlign.right,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            filled: true,
            fillColor: const Color(0xFFEDF2F7),
            prefixIcon: isPassword ? const Icon(Icons.visibility_off_outlined, size: 20, color: Colors.black45) : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // ويدجت مساعدة لبناء صفوف أزرار التبديل الخاصة بالإشعارات
  Widget _buildNotificationSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color activeColor,
  }) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: activeColor,
          inactiveTrackColor: const Color(0xFFCBD5E0),
        ),
        const Spacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }
}