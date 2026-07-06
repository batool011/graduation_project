import 'package:career/core/constant/class/app_string.dart';
import 'package:career/features/employee_evaluation/domain/model/employee_evaluation_model.dart';
import 'package:get/get.dart';

class EmployeeEvaluationController extends GetxController {
  final RxDouble overallRating = 4.6.obs;

  final EmployeeProfile employeeProfile = const EmployeeProfile(
    employeeName: 'أحمد علي',
    jobTitle: 'موظف مبيعات أول',
    department: 'قسم المبيعات',
    employeeId: 'EMP-1042',
  );

  List<Map<String, dynamic>> get ratingBreakdown => [
    {'label': AppString.generalPerformance, 'value': 0.92},
    {'label': AppString.commitment, 'value': 0.88},
    {'label': AppString.communication, 'value': 0.81},
    {'label': AppString.problemSolving, 'value': 0.76},
  ];

  final List<EmployeeEvaluationModel> evaluations = const [
    EmployeeEvaluationModel(
      employeeName: 'أحمد علي',
      jobTitle: 'موظف مبيعات أول',
      department: 'قسم المبيعات',
      rating: 4.8,
      feedback:
          'يظهر مستوى ممتاز من المسؤولية، ويتعامل مع العملاء بثقة وهدوء، مع قدرة واضحة على إغلاق الصفقات بسرعة.',
      date: 'يونيو 2026',
      strengths: ['التواصل', 'الالتزام', 'السرعة في التنفيذ'],
      focusAreas: ['تفويض بعض المهام', 'مراجعة التقارير بشكل أدق'],
    ),
    EmployeeEvaluationModel(
      employeeName: 'أحمد علي',
      jobTitle: 'موظف مبيعات أول',
      department: 'قسم المبيعات',
      rating: 4.5,
      feedback:
          'يحافظ على مستوى ثابت من الأداء خلال الشهر، ويُظهر تحسناً واضحاً في سرعة الاستجابة للطلبات.',
      date: 'أبريل 2026',
      strengths: ['العمل الجماعي', 'التنظيم', 'المرونة'],
      focusAreas: ['التقارير الشهرية', 'الإدارة الزمنية'],
    ),
    EmployeeEvaluationModel(
      employeeName: 'أحمد علي',
      jobTitle: 'موظف مبيعات أول',
      department: 'قسم المبيعات',
      rating: 4.7,
      feedback:
          'يمتلك قدرة قوية على ضبط الإيقاع اليومي والعمل مع الفريق، مع قابلية عالية للتطوير في المراحل القادمة.',
      date: 'مارس 2026',
      strengths: ['القيادة', 'اتخاذ القرار', 'الانضباط'],
      focusAreas: ['التوثيق', 'عرض النتائج على الفريق بشكل دوري'],
    ),
  ];
}