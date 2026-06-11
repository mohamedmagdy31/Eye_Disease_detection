import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'result_screen.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  final TextEditingController _complaintController = TextEditingController();

  // متغيرات حفظ وإدارة الصورة المرفوعة
  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  // دالة فتح الاستوديو واختيار الصورة
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedFile = image;
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00897B);
    const Color bgColor = Color(0xFFF7FAFC);

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 768;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'التشخيص وفحص العين',
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
                // عنوان الصفحة الفرعي لشاشة الموبايل والويب
                const Text(
                  'فحص جديد',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'دخل شكواك وارفع صورة قاع العين للحصول على تشخيص دقيق',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 24),

                // تصميم متجاوب: جنب بعض في الويب، وتحت بعض في الموبايل
                isWeb
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // تفاصيل الشكوى (يمين في الويب)
                    Expanded(child: _buildComplaintSection()),
                    const SizedBox(width: 20),
                    // رفع صورة قاع العين (يسار في الويب)
                    Expanded(child: _buildUploadSection(primaryColor)),
                  ],
                )
                    : Column(
                  children: [
                    // تفاصيل الشكوى (فوق في الموبايل)
                    _buildComplaintSection(),
                    const SizedBox(height: 20),
                    // رفع صورة قاع العين (تحت في الموبايل)
                    _buildUploadSection(primaryColor),
                  ],
                ),

                const SizedBox(height: 30),

                // زر إرسال الفحص العريض الأخضر أسفل التصميم
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_pickedFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('برجاء رفع صورة قاع العين أولاً'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      // الانتقال المباشر لشاشة النتيجة وتمرير الصورة المرفوعة بنجاح
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(pickedFile: _pickedFile!),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    label: const Text(
                      'إرسال الفحص',
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 1. كارت تفاصيل الشكوى
  Widget _buildComplaintSection() {
    return Container(
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
              Text('تفاصيل الشكوى', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.description_outlined, color: Colors.black54, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'ما هي شكواك؟ وبماذا تشعر في عينك؟',
            style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _complaintController,
            maxLines: 5,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'مثال: أشعر بضبابية في الرؤية، خاصة في الصباح، مع وجود هالات حول الأضواء في الليل...',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
              filled: true,
              fillColor: const Color(0xFFEDF2F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'كلما كانت التفاصيل أكثر كلما كان التشخيص أدق',
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // 2. كارت رفع وعرض صورة قاع العين
  Widget _buildUploadSection(Color primaryColor) {
    return Container(
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
              Text('صورة قاع العين', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.camera_alt_outlined, color: Colors.black54, size: 20),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            height: 145,
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
            ),
            child: _pickedFile == null
                ? InkWell(
              onTap: _pickImage,
              borderRadius: BorderRadius.circular(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.cloud_upload_outlined, color: primaryColor, size: 24),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'اسحب الملف وأفلته هنا',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'أو اضغط لاختيار ملف',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            )
                : Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: kIsWeb
                        ? Image.network(_pickedFile!.path, fit: BoxFit.cover)
                        : Image.file(File(_pickedFile!.path), fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.red.withOpacity(0.9),
                    radius: 16,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.delete, color: Colors.white, size: 16),
                      onPressed: () {
                        setState(() {
                          _pickedFile = null;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'الحد الأقصى (10) ملفات PDF ،WebP ،JPG ،PNG مستندات',
            style: TextStyle(color: Colors.grey, fontSize: 10),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}