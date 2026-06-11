import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'patient_dashboard.dart';
import 'doctor_dashboard.dart'; // استيراد شاشة لوحة تحكم الطبيب الجديدة

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isDoctor = false;
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
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450), // لضمان التناسق على الويب والموبايل
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. الشعار
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.remove_red_eye, color: Colors.white, size: 40),
                ),
                const SizedBox(height: 24),

                // 2. الترحيب
                const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 6),
                const Text(
                  'أدخل بياناتك للوصول إلى حسابك',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 30),

                // 3. خيار نوع الحساب (طبيب / مريض)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDoctor = true;
                          });
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: _isDoctor ? primaryColor.withOpacity(0.1) : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _isDoctor ? primaryColor : Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.medical_services_outlined, color: _isDoctor ? primaryColor : Colors.grey),
                              const SizedBox(width: 8),
                              Text('طبيب', style: TextStyle(color: _isDoctor ? primaryColor : Colors.grey, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDoctor = false;
                          });
                        },
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: !_isDoctor ? primaryColor.withOpacity(0.1) : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: !_isDoctor ? primaryColor : Colors.grey.shade300),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_outline, color: !_isDoctor ? primaryColor : Colors.grey),
                              const SizedBox(width: 8),
                              Text('مريض', style: TextStyle(color: !_isDoctor ? primaryColor : Colors.grey, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 4. حقل البريد الإلكتروني
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('البريد الإلكتروني', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                ),
                const SizedBox(height: 8),
                TextField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'example@gmail.com',
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    filled: true,
                    fillColor: fieldBgColor,
                    prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF718096)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),

                // 5. حقل كلمة المرور
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('كلمة المرور', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2D3748))),
                ),
                const SizedBox(height: 8),
                TextField(
                  textAlign: TextAlign.right,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: '••••••',
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
                const SizedBox(height: 30),

                // 6. زر تسجيل الدخول المعدل لفحص نوع الحساب بشكل مباشر وتأكيده في الـ Console
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // سطر طباعة للتأكد والتحقق من القيمة المختارة أثناء الضغط في الـ Debug Console
                      debugPrint("قيمة الاختيار الحالية: هل الحساب طبيب؟ -> $_isDoctor");

                      if (_isDoctor) {
                        // التوجيه للوحة تحكم الدكتور
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const DoctorDashboard()),
                        );
                      } else {
                        // التوجيه للوحة تحكم المريض
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const PatientDashboard()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: const Text('تسجيل الدخول', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 24),

                // 7. رابط إنشاء الحساب
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        'سجل الآن',
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text('  ليس لديك حساب؟ '),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}