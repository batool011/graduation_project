
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/profile/presentation/widget/profile_stat_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // صورة البروفايل (تأخذ كامل السيركل)
        Container(
  width: 120,
  height: 120,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: ClipOval(
    child: Transform.scale(
      scale: 1.5, // 🔥 كبر الصورة (غير الرقم حسب الحاجة)
      child: Image.asset(
        "assets/images/profile.png",
        fit: BoxFit.cover,
      ),
    ),
  ),
),

            const SizedBox(height: 12),

            // الاسم
            Text(
              "Safa Harkel",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            // الإيميل
            Text(
              "safa@example.com",
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),

            const SizedBox(height: 25),

            // البطاقات (تقييمي + مدة العضوية)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileStatCard(
                  title: "تقييمي",
                  value: "4.8 / 5",
                  color: Colors.amber,
                  icon: Icons.star,
                ),
                const SizedBox(width: 12),
                ProfileStatCard(
                  title: "مدة العضوية",
                  value: "سنة و 3 أشهر",
                  color: AppColor.primaryColor,
                  icon: Icons.calendar_month,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // القائمة بنفس شكل الصورة
            _menuItem(Icons.person, "Username", "تغيير اسم المستخدم"),
            _menuItem(Icons.settings, "الإعدادات", "التحكم بالخصوصية"),
            _menuItem(Icons.notifications, "الإشعارات", "حول تنبيهاتك"),

            const SizedBox(height: 20),

            // زر تسجيل الخروج
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      "تسجيل الخروج",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColor.primaryColor, size: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

     
