
/*
class BecomeSellerPage extends ConsumerWidget {
  const BecomeSellerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(becomeSellerStepProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Custom Step Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index <= step
                          ? AppColors.kTextColor
                          : AppColors.kBorderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: AppPadding.getPadding12H(context),
              child: _buildStepContent(context, step, ref),
            ),
          ),
          _buildBottomButtons(context, step, ref),
        ],
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, int step, WidgetRef ref) {
    switch (step) {
      case 0:
        return const Step1PersonalInfo();
      case 1:
        return const Step2Identity();
      case 2:
        return const Step3StoreProfile();
      default:
        return const SizedBox();
    }
  }

  Widget _buildBottomButtons(BuildContext context, int step, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(
        12,
      ).copyWith(bottom: MediaQuery.of(context).viewPadding.bottom + 12),
      child: Row(
        children: [
          if (step > 0) ...[
            Expanded(
              child: CustomButton(
                text: 'Previous',
                isOutlined: true,
                borderColor: AppColors.kBorderColor,
                textColor: AppColors.kGreyTextColor,
                onPressed: () =>
                    ref.read(becomeSellerStepProvider.notifier).state--,
              ),
            ),
            space12W,
          ],
          Expanded(
            child: CustomButton(
              text: step == 2 ? 'Submit Application' : 'Next',
              onPressed: () {
                if (step < 2) {
                  ref.read(becomeSellerStepProvider.notifier).state++;
                } else {
                  context.pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/

