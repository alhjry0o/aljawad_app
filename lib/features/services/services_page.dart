import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/localization/generated/app_localizations.dart';
import '../../core/providers/catalog_providers.dart';
import '../../core/routing/app_router.dart';
import '../../core/widgets/empty_state.dart';

class ServicesPage extends ConsumerStatefulWidget {
  const ServicesPage({super.key});

  @override
  ConsumerState<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends ConsumerState<ServicesPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final categories = ref.watch(categoriesProvider);
    final query = ref.watch(servicesQueryProvider);
    final services = ref.watch(filteredServicesProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.servicesTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        )),
                const SizedBox(height: 12),
                TextField(
                  controller: _controller,
                  onChanged: (v) => ref
                      .read(servicesQueryProvider.notifier)
                      .update((s) => s.copyWith(q: v)),
                  decoration: InputDecoration(
                    hintText: l.servicesSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _controller.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              ref
                                  .read(servicesQueryProvider.notifier)
                                  .update((s) => s.copyWith(q: ''));
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                if (i == 0) {
                  return ChoiceChip(
                    label: Text(l.allCategories),
                    selected: query.categoryId == null,
                    onSelected: (_) => ref
                        .read(servicesQueryProvider.notifier)
                        .update((s) => s.copyWith(clearCategory: true)),
                  );
                }
                final c = categories[i - 1];
                final selected = query.categoryId == c.id;
                return ChoiceChip(
                  label: Text(c.name(isAr)),
                  selected: selected,
                  onSelected: (_) => ref
                      .read(servicesQueryProvider.notifier)
                      .update((s) => s.copyWith(categoryId: c.id)),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: services.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    title: l.noResults,
                    description: l.noResultsDesc,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: services.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, i) {
                      final s = services[i];
                      return _ServiceTile(
                        title: s.name(isAr),
                        subtitle: s.short(isAr),
                        onTap: () => context.push(
                          '${AppRoutes.serviceDetails}/${s.id}',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      )),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}