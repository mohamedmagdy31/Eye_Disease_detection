import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00897B);
    const Color fieldBgColor = Color(0xFFEDF2F7);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // شعار الأبليكيشن (الأيقونة الخضراء)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.remove_red_eye, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 24),

              // العنوان والترحيب
              const Text(
                'إنشاء حساب جديد',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
              ),
              const SizedBox(height: 6),
              const Text(
                'أنشئ حسابك للبدء في استخدام النظام',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 35),

              // حقل الاسم الكامل
              const Align(
                alignment: Alignment.centerRight,
                child: Text('الاسم الكامل', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
              ),
              const SizedBox(height: 8),
              TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'محمد مجدي',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  filled: true,
                  fillColor: fieldBgColor,
                  prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF718096)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // حقل البريد الإلكتروني
              const Align(
                alignment: Alignment.centerRight,
                child: Text('البريد الإلكتروني', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
              ),
              const SizedBox(height: 8),
              TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'example@email.com',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  filled: true,
                  fillColor: fieldBgColor,
                  prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF718096)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // حقل كلمة المرور
              const Align(
                alignment: Alignment.centerRight,
                child: Text('كلمة المرور', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
              ),
              const SizedBox(height: 8),
              TextField(
                textAlign: TextAlign.right,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: '••••••••',
                  filled: true,
                  fillColor: fieldBgColor,
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF718096)),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 35),

              // زر إنشاء الحساب
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // بعد التسجيل بنجاح، يُرجَع به لشاشة تسجيل الدخول
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم إنشاء الحساب بنجاح!')),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  child: const Text('إنشاء الحساب', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24),

              // رابط العودة لتسجيل الدخول
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'تسجيل الدخول',
                      style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text('  لديك حساب بالفعل؟ '),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}