import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ResultScreen extends StatefulWidget {
  final XFile pickedFile;

  const ResultScreen({super.key, required this.pickedFile});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // متغيرات إدارة حالة حجز الموعد
  DateTime _selectedDate = DateTime(2026, 6, 12);
  String? _selectedTime;
  bool _isBookingConfirmed = false;

  // قائمة الساعات المتاحة للحجز كما في التصميم
  final List<String> _availableTimes = [
    '09:00', '10:30', '11:00',
    '01:30', '03:00', '04:30',
    '06:00', '07:30', '09:00'
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF00897B);
    const Color bgColor = Color(0xFFF7FAFC);

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWeb = screenWidth > 768;

    // 1. كارت عرض صورة قاع العين
    final Widget imageCard = Container(
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
            height: 180,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: kIsWeb
                  ? Image.network(widget.pickedFile.path, fit: BoxFit.cover)
                  : Image.file(File(widget.pickedFile.path), fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );

    // 2. كارت نتيجة الذكاء الاصطناعي
    final Widget aiResultCard = Container(
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
              Text('نتيجة التشخيص بالذكاء الاصطناعي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.psychology_outlined, color: Colors.black54, size: 20),
            ],
          ),
          const Divider(height: 24),
          const Text('التشخيص المحتمل', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          const Text(
            'المياه البيضاء (الساد)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('دقة عالية جداً', style: TextStyle(color: Colors.grey, fontSize: 11)),
              Row(
                children: [
                  const Text('91%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: primaryColor)),
                  const SizedBox(width: 6),
                  const Text('نسبة الثقة', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: 0.91,
            backgroundColor: Colors.grey.shade100,
            color: primaryColor,
            minHeight: 6,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9E6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFFFE0B2)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    'هذا التشخيص تمهيدي ويجب مراجعة طبيب مختص لتأكيد النتيجة ووضع خطة علاجية مناسبة.',
                    style: TextStyle(color: Color(0xFFB78103), fontSize: 12, height: 1.4),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.warning_amber_rounded, color: Color(0xFFF57C00), size: 20),
              ],
            ),
          ),
        ],
      ),
    );

    // 3. كارت ملاحظات الطبيب الجديد المعتمد من الفيجما
    final Widget doctorNotesCard = Container(
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
              Text('ملاحظات الطبيب', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.assignment_outlined, color: Colors.black54, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xC8A5D6A7)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'تمت المراجعة من قبل الطبيب',
                      style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.check_circle_outline, color: Color(0xFF2E7D32), size: 18),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'يُنصح بمراجعة طبيب العيون فوراً لبدء العلاج',
                  style: TextStyle(color: Color(0xFF1B5E20), fontSize: 13, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // 4. كارت حجز الموعد والكاليندر التفاعلي
    final Widget calendarCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: !_isBookingConfirmed
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('حجز موعد مع الطبيب', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(width: 8),
              Icon(Icons.calendar_today_outlined, color: Colors.black54, size: 18),
            ],
          ),
          const SizedBox(height: 4),
          const Text('احجز موعداً للمراجعة والحصول على استشارة طبية', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const Divider(height: 24),
          const Text('اختر اليوم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CalendarDatePicker(
              initialDate: _selectedDate,
              firstDate: DateTime(2026, 1, 1),
              lastDate: DateTime(2027, 1, 1),
              onDateChanged: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          const Text('اختر الوقت', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _availableTimes.length,
            itemBuilder: (context, index) {
              final time = _availableTimes[index];
              final isSelected = _selectedTime == time;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedTime = time;
                  });
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : const Color(0xFFF7FAFC),
                    border: Border.all(color: isSelected ? primaryColor : Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                if (_selectedTime == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('برجاء اختيار الوقت المناسب أولاً'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }
                setState(() {
                  _isBookingConfirmed = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text(
                'تأكيد الحجز',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center, // تم التصليح هنا بنجاح
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle, color: primaryColor, size: 48),
          ),
          const SizedBox(height: 16),
          const Text(
            'تم تأكيد الحجز',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          const Text(
            'تم حجز موعدك بنجاح',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const Divider(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
              ),
              const Text('التاريخ المختار', style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedTime ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: primaryColor),
              ),
              const Text('الوقت المختار', style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                'العودة للرئيسية',
                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 10),
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
          'نتيجة الفحص',
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
                  'نتيجة الفحص',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3748)),
                ),
                const SizedBox(height: 4),
                const Text(
                  'نتائج تحليل الذكاء الاصطناعي لصورة العين',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 24),
                isWeb
                    ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: calendarCard),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          imageCard,
                          const SizedBox(height: 20),
                          aiResultCard,
                          const SizedBox(height: 20),
                          doctorNotesCard,
                        ],
                      ),
                    ),
                  ],
                )
                    : Column(
                  children: [
                    imageCard,
                    const SizedBox(height: 16),
                    aiResultCard,
                    const SizedBox(height: 16),
                    doctorNotesCard,
                    const SizedBox(height: 16),
                    calendarCard,
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