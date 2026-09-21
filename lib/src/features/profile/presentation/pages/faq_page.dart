import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barcode_scaner/src/features/profile/data/datasources/faq_remote_datasource.dart';
import 'package:barcode_scaner/src/features/profile/data/models/faq_model.dart';
import '../../../../src_export.dart';

class FaqPage extends ConsumerWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqAsync = ref.watch(faqListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          'FAQ',
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: faqAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                space12H,
                CustomText(
                  err.toString().replaceAll('Exception: ', ''),
                  textAlign: TextAlign.center,
                  color: AppColors.kBrownTextColor,
                ),
                space16H,
                CustomButton(
                  text: 'Retry',
                  backgroundColor: AppColors.kPrimaryColor,
                  onPressed: () => ref.invalidate(faqListProvider),
                ),
              ],
            ),
          ),
        ),
        data: (faqs) => faqs.isEmpty
            ? const Center(
                child: CustomText(
                  'No FAQs available.',
                  color: AppColors.kBrownTextColor,
                ),
              )
            : _FaqList(faqs: faqs),
      ),
    );
  }
}

class _FaqList extends StatelessWidget {
  final List<FaqModel> faqs;
  const _FaqList({required this.faqs});

  @override
  Widget build(BuildContext context) {
    // Group by category
    final Map<String, List<FaqModel>> grouped = {};
    for (final faq in faqs) {
      grouped.putIfAbsent(faq.category, () => []).add(faq);
    }

    return ListView(
      padding: AppPadding.getPadding12(context),
      children: [
        space8H,
        for (final entry in grouped.entries) ...[
          _CategoryHeader(label: entry.value.first.categoryDisplayName),
          space8H,
          ...entry.value.map((faq) => _FaqItem(faq: faq)),
          space16H,
        ],
      ],
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String label;
  const _CategoryHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: CustomText(
        label.toUpperCase(),
        variant: TextVariant.labelSmall,
        fontWeight: FontWeight.bold,
        color: AppColors.kBrownTextColor,
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  final FaqModel faq;
  const _FaqItem({required this.faq});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _expanded
              ? AppColors.kPrimaryColor.withValues(alpha: 0.4)
              : Colors.grey.shade200,
        ),
        boxShadow: [
          if (_expanded)
            BoxShadow(
              color: AppColors.kPrimaryColor.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomText(
                          widget.faq.question,
                          variant: TextVariant.bodyMedium,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: _expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (_expanded) ...[
                    space12H,
                    CustomText(
                      widget.faq.answer,
                      variant: TextVariant.bodyMedium,
                      color: AppColors.kBrownTextColor,
                      height: 1.5,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
