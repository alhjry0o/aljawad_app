class AppAssets {
  AppAssets._();

  static const String logo = 'assets/logo/logo.png';

  static const String servicePlaceholder =
      'assets/images/service_placeholder.png';
  static const String projectPlaceholder =
      'assets/images/project_placeholder.png';

  /// ربط معرّف الخدمة بمسار صورتها.
  /// لإضافة صورة لخدمة جديدة: ضع الملف في assets/images/services/
  /// ثم أضف سطراً هنا بنفس المعرّف.
  static const Map<String, String> serviceImages = {
    'cleaning_deep': 'assets/images/services/cleaning_deep.jpg',
    'cleaning_residential': 'assets/images/services/cleaning_residential.jpg',
    'cleaning_post_construction':
        'assets/images/services/cleaning_post_construction.jpg',
    'cleaning_high': 'assets/images/services/cleaning_high.jpg',
    'facades_glass': 'assets/images/services/facades_glass.jpg',
    'facades_stone': 'assets/images/services/facades_stone.jpg',
    'facades_lifting': 'assets/images/services/facades_lifting.jpg',
    'industrial_parking': 'assets/images/services/industrial_parking.jpg',
    'industrial_floors': 'assets/images/services/industrial_floors.jpg',
    'industrial_programs': 'assets/images/services/industrial_programs.jpg',
    'pools_basic': 'assets/images/services/pools_basic.jpg',
    'pest_insects': 'assets/images/services/pest_insects.jpg',
    'pest_rodents': 'assets/images/services/pest_rodents.jpg',
    'pest_fumigation': 'assets/images/services/pest_fumigation.jpg',
    'insulation_water': 'assets/images/services/insulation_water.jpg',
    'insulation_thermal': 'assets/images/services/insulation_thermal.jpg',
    'insulation_tanks': 'assets/images/services/insulation_tanks.jpg',
    'maintenance_plumbing': 'assets/images/services/maintenance_plumbing.jpg',
    'maintenance_electrical':
        'assets/images/services/maintenance_electrical.jpg',
    'maintenance_hvac': 'assets/images/services/maintenance_hvac.jpg',
    'manpower_specialized': 'assets/images/services/manpower_specialized.jpg',
    'facilities_management':
        'assets/images/services/facilities_management.jpg',
    'equipment_heavy': 'assets/images/services/equipment_heavy.jpg',
    'construction_general': 'assets/images/services/construction_general.jpg',
  };

  static String? serviceImage(String id) => serviceImages[id];

  /// ربط معرّف المشروع بمسار صورته (للاستخدام لاحقاً).
  static const Map<String, String> projectImages = {
    'p1': 'assets/images/projects/p1.jpg',
    'p2': 'assets/images/projects/p2.jpg',
    'p3': 'assets/images/projects/p3.jpg',
    'p4': 'assets/images/projects/p4.jpg',
    'p5': 'assets/images/projects/p5.jpg',
    'p6': 'assets/images/projects/p6.jpg',
  };

  static String? projectImage(String id) => projectImages[id];
}