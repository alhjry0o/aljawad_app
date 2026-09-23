import '../models/service.dart';
import '../models/service_category.dart';

class ServicesCatalog {
  ServicesCatalog._();

  static const String catCleaning = 'cleaning';
  static const String catFacades = 'facades';
  static const String catIndustrial = 'industrial';
  static const String catPools = 'pools';
  static const String catPest = 'pest';
  static const String catInsulation = 'insulation';
  static const String catMaintenance = 'maintenance';
  static const String catManpower = 'manpower';
  static const String catFacilities = 'facilities';
  static const String catEquipment = 'equipment';
  static const String catConstruction = 'construction';

  static const List<String> siteTypeKeys = [
    'siteHome',
    'siteVilla',
    'sitePalace',
    'siteOffice',
    'siteHotel',
    'siteHospital',
    'siteFactory',
    'siteWarehouse',
    'siteBuilding',
    'siteParking',
    'siteOther',
  ];

  static final List<ServiceCategory> categories = [
    ServiceCategory(
      id: catCleaning,
      nameAr: 'النظافة',
      nameEn: 'Cleaning',
      services: const [
        Service(
          id: 'cleaning_deep',
          categoryId: catCleaning,
          nameAr: 'التنظيف العميق',
          nameEn: 'Deep cleaning',
          shortAr: 'تنظيف شامل للمساحات والمفروشات.',
          shortEn: 'Full cleaning for spaces and furnishings.',
          descriptionAr:
              'خدمة تنظيف عميق شاملة للمساحات الداخلية والخارجية وفق خطة عمل مخصصة للموقع.',
          descriptionEn:
              'Comprehensive deep cleaning of indoor and outdoor spaces per a tailored plan.',
          featuresAr: ['تنظيف الأرضيات', 'تنظيف الجدران', 'المفروشات', 'الأسطح'],
          featuresEn: ['Floors', 'Walls', 'Furnishings', 'Surfaces'],
          sitesAr: ['منازل', 'فلل', 'قصور', 'فنادق', 'مستشفيات'],
          sitesEn: ['Homes', 'Villas', 'Palaces', 'Hotels', 'Hospitals'],
        ),
        Service(
          id: 'cleaning_residential',
          categoryId: catCleaning,
          nameAr: 'تنظيف المنازل والفلل',
          nameEn: 'Homes & villas cleaning',
          shortAr: 'تنظيف دوري للمنازل والفلل.',
          shortEn: 'Recurring cleaning for homes and villas.',
          descriptionAr: 'برامج تنظيف دورية للمنازل والفلل والقصور حسب الجدول المتفق عليه.',
          descriptionEn: 'Recurring cleaning programs for homes, villas and palaces.',
          featuresAr: ['تنظيف دوري', 'فرق مدربة', 'مواد آمنة'],
          featuresEn: ['Recurring', 'Trained teams', 'Safe materials'],
          sitesAr: ['منازل', 'فلل', 'قصور'],
          sitesEn: ['Homes', 'Villas', 'Palaces'],
        ),
        Service(
          id: 'cleaning_post_construction',
          categoryId: catCleaning,
          nameAr: 'تنظيف ما بعد الإنشاء',
          nameEn: 'Post-construction cleaning',
          shortAr: 'إزالة مخلفات وأتربة البناء.',
          shortEn: 'Removing construction dust & debris.',
          descriptionAr:
              'تنظيف شامل بعد أعمال الإنشاء والتشطيبات بما في ذلك إزالة الأتربة والبقايا.',
          descriptionEn: 'Full cleaning after construction and finishes.',
          featuresAr: ['إزالة مخلفات البناء', 'تنظيف الجدران', 'تنظيف الأرضيات'],
          featuresEn: ['Debris removal', 'Wall cleaning', 'Floor cleaning'],
          sitesAr: ['مباني جديدة', 'منشآت'],
          sitesEn: ['New buildings', 'Facilities'],
        ),
        Service(
          id: 'cleaning_high',
          categoryId: catCleaning,
          nameAr: 'تنظيف الجدران والأسقف والمناطق المرتفعة',
          nameEn: 'High walls, ceilings & elevated areas',
          shortAr: 'تنظيف المناطق المرتفعة بأمان.',
          shortEn: 'Safe cleaning of elevated areas.',
          descriptionAr: 'تنظيف المناطق المرتفعة والجدران والأسقف باستخدام معدات مناسبة.',
          descriptionEn: 'Cleaning high areas, walls and ceilings with proper equipment.',
          featuresAr: ['معدات رفع', 'فرق مدرّبة'],
          featuresEn: ['Lifting equipment', 'Trained teams'],
          sitesAr: ['قاعات', 'منشآت', 'مباني'],
          sitesEn: ['Halls', 'Facilities', 'Buildings'],
        ),
      ],
    ),
    ServiceCategory(
      id: catFacades,
      nameAr: 'تنظيف الواجهات',
      nameEn: 'Facade cleaning',
      services: const [
        Service(
          id: 'facades_glass',
          categoryId: catFacades,
          nameAr: 'تنظيف الزجاج والواجهات الزجاجية',
          nameEn: 'Glass & glass facades cleaning',
          shortAr: 'تنظيف احترافي لواجهات الزجاج.',
          shortEn: 'Professional glass facade cleaning.',
          descriptionAr: 'تنظيف الزجاج والواجهات الزجاجية للمباني والأبراج.',
          descriptionEn: 'Cleaning glass and glass facades of buildings and towers.',
          featuresAr: ['زجاج داخلي وخارجي', 'بدون آثار', 'معدات آمنة'],
          featuresEn: ['Interior & exterior', 'Streak-free', 'Safe equipment'],
          sitesAr: ['أبراج', 'مباني', 'مكاتب'],
          sitesEn: ['Towers', 'Buildings', 'Offices'],
        ),
        Service(
          id: 'facades_stone',
          categoryId: catFacades,
          nameAr: 'تنظيف واجهات الحجر والكلادينج',
          nameEn: 'Stone & cladding facades',
          shortAr: 'تنظيف الحجر والكلادينج.',
          shortEn: 'Stone and cladding cleaning.',
          descriptionAr: 'تنظيف واجهات الحجر والكلادينج والنوافذ الداخلية والخارجية.',
          descriptionEn: 'Cleaning stone and cladding facades, windows inside/outside.',
          featuresAr: ['حجر', 'كلادينج', 'نوافذ'],
          featuresEn: ['Stone', 'Cladding', 'Windows'],
          sitesAr: ['أبراج', 'مباني مرتفعة'],
          sitesEn: ['Towers', 'High-rises'],
        ),
        Service(
          id: 'facades_lifting',
          categoryId: catFacades,
          nameAr: 'أعمال رفع ووصول',
          nameEn: 'Lifting & access works',
          shortAr: 'معدات رفع للمناطق المرتفعة.',
          shortEn: 'Lifting equipment for elevated areas.',
          descriptionAr: 'استخدام معدات رفع معتمدة للوصول إلى الواجهات المرتفعة.',
          descriptionEn: 'Certified lifting equipment for high facades.',
          featuresAr: ['معدات رفع', 'سلامة'],
          featuresEn: ['Lifting', 'Safety'],
          sitesAr: ['أبراج', 'منشآت صناعية'],
          sitesEn: ['Towers', 'Industrial'],
        ),
      ],
    ),
    ServiceCategory(
      id: catIndustrial,
      nameAr: 'تنظيف المواقف والمنشآت الصناعية',
      nameEn: 'Parking & industrial cleaning',
      services: const [
        Service(
          id: 'industrial_parking',
          categoryId: catIndustrial,
          nameAr: 'تنظيف المواقف الداخلية والخارجية',
          nameEn: 'Indoor & outdoor parking cleaning',
          shortAr: 'تنظيف مواقف بمعايير احترافية.',
          shortEn: 'Professional parking cleaning.',
          descriptionAr:
              'تنظيف المواقف الداخلية والخارجية وإزالة الزيوت وآثار الإطارات والعلامات الأرضية.',
          descriptionEn:
              'Cleaning parkings, removing oils, tire marks and refreshing floor markings.',
          featuresAr: ['إزالة الزيوت', 'إزالة آثار الإطارات', 'العلامات الأرضية'],
          featuresEn: ['Oil removal', 'Tire marks', 'Floor markings'],
          sitesAr: ['مواقف', 'منشآت'],
          sitesEn: ['Parkings', 'Facilities'],
        ),
        Service(
          id: 'industrial_floors',
          categoryId: catIndustrial,
          nameAr: 'جلي وتلميع الأرضيات',
          nameEn: 'Floor polishing & burnishing',
          shortAr: 'جلي وتلميع الأرضيات.',
          shortEn: 'Polishing and burnishing floors.',
          descriptionAr: 'جلي وتلميع الأرضيات الإيبوكسي والخرسانة والأرضيات الصلبة.',
          descriptionEn: 'Polishing epoxy, concrete and hard floors.',
          featuresAr: ['إيبوكسي', 'خرسانة', 'تلميع'],
          featuresEn: ['Epoxy', 'Concrete', 'Polishing'],
          sitesAr: ['مصانع', 'مستودعات', 'مواقف'],
          sitesEn: ['Factories', 'Warehouses', 'Parkings'],
        ),
        Service(
          id: 'industrial_programs',
          categoryId: catIndustrial,
          nameAr: 'برامج التنظيف الدورية',
          nameEn: 'Recurring cleaning programs',
          shortAr: 'برامج دورية للمنشآت الصناعية.',
          shortEn: 'Recurring programs for industrial sites.',
          descriptionAr: 'برامج تنظيف دورية للمصانع والمستودعات وفق جدول متفق عليه.',
          descriptionEn: 'Recurring cleaning programs for factories and warehouses.',
          featuresAr: ['جدول دوري', 'تقارير متابعة'],
          featuresEn: ['Recurring schedule', 'Follow-up reports'],
          sitesAr: ['مصانع', 'مستودعات'],
          sitesEn: ['Factories', 'Warehouses'],
        ),
      ],
    ),
    ServiceCategory(
      id: catPools,
      nameAr: 'تنظيف المسابح',
      nameEn: 'Pool cleaning',
      services: const [
        Service(
          id: 'pools_basic',
          categoryId: catPools,
          nameAr: 'تنظيف وصيانة المسابح',
          nameEn: 'Pool cleaning & maintenance',
          shortAr: 'تنظيف دوري وصيانة للمسابح.',
          shortEn: 'Recurring pool cleaning and maintenance.',
          descriptionAr: 'تنظيف دوري للمسابح ومعالجة المياه والفحص الدوري.',
          descriptionEn: 'Recurring pool cleaning, water treatment and inspections.',
          featuresAr: ['تنظيف دوري', 'معالجة المياه', 'فحص'],
          featuresEn: ['Recurring', 'Water treatment', 'Inspection'],
          sitesAr: ['فلل', 'فنادق', 'منشآت رياضية'],
          sitesEn: ['Villas', 'Hotels', 'Sports facilities'],
        ),
      ],
    ),
    ServiceCategory(
      id: catPest,
      nameAr: 'مكافحة الآفات',
      nameEn: 'Pest control',
      services: const [
        Service(
          id: 'pest_insects',
          categoryId: catPest,
          nameAr: 'مكافحة الحشرات',
          nameEn: 'Insect control',
          shortAr: 'مكافحة الحشرات الزاحفة والطائرة.',
          shortEn: 'Crawling & flying insect control.',
          descriptionAr:
              'مكافحة الحشرات الزاحفة والطائرة بما فيها الصراصير والنمل وبق الفراش والذباب والبعوض.',
          descriptionEn:
              'Control of crawling and flying insects: roaches, ants, bedbugs, flies, mosquitoes.',
          featuresAr: ['صراصير', 'نمل', 'بق الفراش', 'ذباب', 'بعوض'],
          featuresEn: ['Roaches', 'Ants', 'Bedbugs', 'Flies', 'Mosquitoes'],
          sitesAr: ['منازل', 'منشآت', 'مطاعم', 'فنادق'],
          sitesEn: ['Homes', 'Facilities', 'Restaurants', 'Hotels'],
        ),
        Service(
          id: 'pest_rodents',
          categoryId: catPest,
          nameAr: 'مكافحة القوارض',
          nameEn: 'Rodent control',
          shortAr: 'مكافحة القوارض والمصائد.',
          shortEn: 'Rodent control and traps.',
          descriptionAr: 'مكافحة القوارض باستخدام المصائد والطرق الآمنة.',
          descriptionEn: 'Rodent control using traps and safe methods.',
          featuresAr: ['مصائد', 'وقاية'],
          featuresEn: ['Traps', 'Prevention'],
          sitesAr: ['مستودعات', 'مطاعم', 'منشآت'],
          sitesEn: ['Warehouses', 'Restaurants', 'Facilities'],
        ),
        Service(
          id: 'pest_fumigation',
          categoryId: catPest,
          nameAr: 'التبخير ومكافحة الطيور',
          nameEn: 'Fumigation & bird control',
          shortAr: 'تبخير ومكافحة الطيور.',
          shortEn: 'Fumigation and bird control.',
          descriptionAr: 'خدمات التبخير ومكافحة الطيور والوقاية الدورية.',
          descriptionEn: 'Fumigation, bird control and preventive programs.',
          featuresAr: ['تبخير', 'مكافحة الطيور', 'وقاية'],
          featuresEn: ['Fumigation', 'Bird control', 'Prevention'],
          sitesAr: ['مستودعات', 'منشآت صناعية'],
          sitesEn: ['Warehouses', 'Industrial'],
        ),
      ],
    ),
    ServiceCategory(
      id: catInsulation,
      nameAr: 'العزل المائي والحراري',
      nameEn: 'Water & thermal insulation',
      services: const [
        Service(
          id: 'insulation_water',
          categoryId: catInsulation,
          nameAr: 'معالجة تسربات المياه والعزل المائي',
          nameEn: 'Waterproofing & leak treatment',
          shortAr: 'معالجة التسربات والعزل.',
          shortEn: 'Leak treatment and waterproofing.',
          descriptionAr: 'معالجة تسربات المياه والحماية من الرطوبة والعزل المائي.',
          descriptionEn: 'Treating leaks, moisture protection and waterproofing.',
          featuresAr: ['معالجة تسربات', 'حماية من الرطوبة', 'عزل'],
          featuresEn: ['Leak repair', 'Moisture protection', 'Waterproofing'],
          sitesAr: ['أسطح', 'حمامات', 'خزانات'],
          sitesEn: ['Roofs', 'Bathrooms', 'Tanks'],
        ),
        Service(
          id: 'insulation_thermal',
          categoryId: catInsulation,
          nameAr: 'العزل الحراري',
          nameEn: 'Thermal insulation',
          shortAr: 'عزل حراري للمباني.',
          shortEn: 'Thermal insulation for buildings.',
          descriptionAr: 'تنفيذ العزل الحراري للأسطح والجدران.',
          descriptionEn: 'Thermal insulation for roofs and walls.',
          featuresAr: ['أسطح', 'جدران'],
          featuresEn: ['Roofs', 'Walls'],
          sitesAr: ['مباني', 'فلل'],
          sitesEn: ['Buildings', 'Villas'],
        ),
        Service(
          id: 'insulation_tanks',
          categoryId: catInsulation,
          nameAr: 'عزل الخزانات بالإيبوكسي',
          nameEn: 'Tank insulation with epoxy',
          shortAr: 'عزل خزانات بالإيبوكسي.',
          shortEn: 'Epoxy tank insulation.',
          descriptionAr: 'عزل الخزانات الداخلية والخارجية بالإيبوكسي بمواد معتمدة.',
          descriptionEn: 'Internal and external tank insulation with approved epoxy.',
          featuresAr: ['خزانات', 'إيبوكسي'],
          featuresEn: ['Tanks', 'Epoxy'],
          sitesAr: ['خزانات', 'منشآت'],
          sitesEn: ['Tanks', 'Facilities'],
        ),
      ],
    ),
    ServiceCategory(
      id: catMaintenance,
      nameAr: 'السباكة والكهرباء والتكييف',
      nameEn: 'Plumbing, electrical & HVAC',
      services: const [
        Service(
          id: 'maintenance_plumbing',
          categoryId: catMaintenance,
          nameAr: 'أعمال السباكة',
          nameEn: 'Plumbing works',
          shortAr: 'صيانة وإصلاح السباكة.',
          shortEn: 'Plumbing maintenance and repair.',
          descriptionAr: 'أعمال السباكة والصيانة والإصلاح.',
          descriptionEn: 'Plumbing, maintenance and repair works.',
          featuresAr: ['إصلاح', 'صيانة دورية'],
          featuresEn: ['Repair', 'Preventive'],
          sitesAr: ['منازل', 'منشآت'],
          sitesEn: ['Homes', 'Facilities'],
        ),
        Service(
          id: 'maintenance_electrical',
          categoryId: catMaintenance,
          nameAr: 'أعمال الكهرباء',
          nameEn: 'Electrical works',
          shortAr: 'أعمال وصيانة كهربائية.',
          shortEn: 'Electrical works and maintenance.',
          descriptionAr: 'أعمال الكهرباء والصيانة الوقائية والتصحيحية.',
          descriptionEn: 'Electrical works, preventive and corrective maintenance.',
          featuresAr: ['صيانة', 'إصلاح'],
          featuresEn: ['Maintenance', 'Repair'],
          sitesAr: ['منازل', 'منشآت'],
          sitesEn: ['Homes', 'Facilities'],
        ),
        Service(
          id: 'maintenance_hvac',
          categoryId: catMaintenance,
          nameAr: 'أعمال التكييف',
          nameEn: 'HVAC works',
          shortAr: 'صيانة وتشغيل التكييف.',
          shortEn: 'HVAC operation and maintenance.',
          descriptionAr: 'صيانة وتشغيل أنظمة التكييف.',
          descriptionEn: 'HVAC systems maintenance and operation.',
          featuresAr: ['صيانة', 'تنظيف', 'فحص'],
          featuresEn: ['Maintenance', 'Cleaning', 'Inspection'],
          sitesAr: ['منازل', 'مكاتب', 'منشآت'],
          sitesEn: ['Homes', 'Offices', 'Facilities'],
        ),
      ],
    ),
    ServiceCategory(
      id: catManpower,
      nameAr: 'توفير العمالة',
      nameEn: 'Manpower supply',
      services: const [
        Service(
          id: 'manpower_specialized',
          categoryId: catManpower,
          nameAr: 'العمالة المتخصصة والمساندة',
          nameEn: 'Specialized & supporting manpower',
          shortAr: 'عمالة مدربة لمختلف القطاعات.',
          shortEn: 'Trained manpower for various sectors.',
          descriptionAr:
              'توفير عمالة متخصصة ومساندة للمطاعم والمقاهي والمصانع والفنادق والشركات والمتاجر.',
          descriptionEn:
              'Specialized and supporting manpower for restaurants, cafes, factories, hotels, companies and stores.',
          featuresAr: [
            'فنيو كهرباء',
            'فنيو سباكة',
            'فنيو تكييف',
            'عمالة موسمية',
            'عمالة دائمة',
          ],
          featuresEn: [
            'Electricians',
            'Plumbers',
            'HVAC technicians',
            'Seasonal',
            'Permanent',
          ],
          sitesAr: ['مطاعم', 'مقاهي', 'مصانع', 'فنادق', 'شركات', 'متاجر'],
          sitesEn: ['Restaurants', 'Cafes', 'Factories', 'Hotels', 'Companies', 'Stores'],
        ),
      ],
    ),
    ServiceCategory(
      id: catFacilities,
      nameAr: 'إدارة وتشغيل وصيانة المرافق',
      nameEn: 'Facilities management',
      services: const [
        Service(
          id: 'facilities_management',
          categoryId: catFacilities,
          nameAr: 'إدارة المرافق',
          nameEn: 'Facility management',
          shortAr: 'إدارة وتشغيل وصيانة المرافق.',
          shortEn: 'Facilities operation, management and maintenance.',
          descriptionAr: 'حلول إدارة وتشغيل وصيانة المرافق بشكل متكامل.',
          descriptionEn: 'Integrated facility management, operation and maintenance.',
          featuresAr: ['تشغيل', 'صيانة', 'متابعة'],
          featuresEn: ['Operation', 'Maintenance', 'Follow-up'],
          sitesAr: ['مباني', 'منشآت', 'مجمعات'],
          sitesEn: ['Buildings', 'Facilities', 'Complexes'],
        ),
      ],
    ),
    ServiceCategory(
      id: catEquipment,
      nameAr: 'تأجير المعدات',
      nameEn: 'Equipment rental',
      services: const [
        Service(
          id: 'equipment_heavy',
          categoryId: catEquipment,
          nameAr: 'تأجير معدات ثقيلة وخفيفة',
          nameEn: 'Heavy & light equipment rental',
          shortAr: 'تأجير معدات ورافعات ومولدات.',
          shortEn: 'Rental of equipment, cranes and generators.',
          descriptionAr:
              'تأجير معدات ثقيلة وخفيفة ورافعات ومولدات ومعدات رفع، مع الفحص والصيانة والمساعدة في الاختيار.',
          descriptionEn:
              'Rental of heavy/light equipment, cranes, generators, lifting equipment, with inspection, maintenance and selection support.',
          featuresAr: ['رافعات', 'مولدات', 'معدات رفع', 'فحص وصيانة'],
          featuresEn: ['Cranes', 'Generators', 'Lifting', 'Inspection & maintenance'],
          sitesAr: ['مشاريع', 'منشآت'],
          sitesEn: ['Projects', 'Facilities'],
        ),
      ],
    ),
    ServiceCategory(
      id: catConstruction,
      nameAr: 'الإنشاءات والمقاولات',
      nameEn: 'Construction & contracting',
      services: const [
        Service(
          id: 'construction_general',
          categoryId: catConstruction,
          nameAr: 'أعمال الإنشاءات والمقاولات',
          nameEn: 'Construction & contracting works',
          shortAr: 'إنشاءات وتشطيبات وأعمال ما بعد الإنشاء.',
          shortEn: 'Construction, finishes and post-construction works.',
          descriptionAr:
              'تنفيذ المباني والمنشآت والتشطيبات وأعمال ما بعد الإنشاء والعزل والتشغيل والصيانة.',
          descriptionEn:
              'Buildings, facilities, finishes, post-construction, insulation, operation and maintenance.',
          featuresAr: ['مباني', 'منشآت', 'تشطيبات', 'عزل', 'تشغيل وصيانة'],
          featuresEn: ['Buildings', 'Facilities', 'Finishes', 'Insulation', 'O&M'],
          sitesAr: ['مشاريع', 'منشآت'],
          sitesEn: ['Projects', 'Facilities'],
        ),
      ],
    ),
  ];

  static Service? findById(String id) {
    for (final c in categories) {
      for (final s in c.services) {
        if (s.id == id) return s;
      }
    }
    return null;
  }

  static ServiceCategory? categoryOf(String serviceId) {
    for (final c in categories) {
      if (c.services.any((s) => s.id == serviceId)) return c;
    }
    return null;
  }
}