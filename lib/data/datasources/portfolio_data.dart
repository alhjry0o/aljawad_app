import '../models/portfolio_project.dart';
import 'services_catalog.dart';

/// بيانات تجريبية توضيحية فقط — ليست مشاريع حقيقية للشركة.

class PortfolioData {
  PortfolioData._();

  static const List<PortfolioProject> projects = [
    PortfolioProject(
      id: 'p1',
      categoryKey: ServicesCatalog.catCleaning,
      titleAr: 'برنامج تنظيف دوري (نموذج توضيحي)',
      titleEn: 'Recurring cleaning program (sample)',
      summaryAr: 'نموذج توضيحي لبرنامج تنظيف دوري لمنشأة.',
      summaryEn: 'Sample recurring cleaning program.',
    ),
    PortfolioProject(
      id: 'p2',
      categoryKey: ServicesCatalog.catFacades,
      titleAr: 'تنظيف واجهات زجاجية (نموذج توضيحي)',
      titleEn: 'Glass facade cleaning (sample)',
      summaryAr: 'نموذج توضيحي لأعمال تنظيف واجهات.',
      summaryEn: 'Sample facade cleaning works.',
    ),
    PortfolioProject(
      id: 'p3',
      categoryKey: ServicesCatalog.catIndustrial,
      titleAr: 'تنظيف مواقف (نموذج توضيحي)',
      titleEn: 'Parking cleaning (sample)',
      summaryAr: 'نموذج توضيحي لتنظيف مواقف وإزالة زيوت.',
      summaryEn: 'Sample parking cleaning and oil removal.',
    ),
    PortfolioProject(
      id: 'p4',
      categoryKey: ServicesCatalog.catPest,
      titleAr: 'برنامج مكافحة آفات (نموذج توضيحي)',
      titleEn: 'Pest control program (sample)',
      summaryAr: 'نموذج توضيحي لبرنامج مكافحة آفات دوري.',
      summaryEn: 'Sample recurring pest control program.',
    ),
    PortfolioProject(
      id: 'p5',
      categoryKey: ServicesCatalog.catInsulation,
      titleAr: 'عزل خزانات (نموذج توضيحي)',
      titleEn: 'Tank insulation (sample)',
      summaryAr: 'نموذج توضيحي لأعمال عزل بالإيبوكسي.',
      summaryEn: 'Sample epoxy insulation works.',
    ),
    PortfolioProject(
      id: 'p6',
      categoryKey: ServicesCatalog.catEquipment,
      titleAr: 'تأجير معدات (نموذج توضيحي)',
      titleEn: 'Equipment rental (sample)',
      summaryAr: 'نموذج توضيحي لتأجير معدات لمشروع.',
      summaryEn: 'Sample equipment rental for a project.',
    ),
  ];
}