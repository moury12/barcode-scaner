import '../../../../src_export.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "Help & support",
          variant: TextVariant.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            // Mock illustration container
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.support_agent,
                size: 80,
                color: Color(0xFF536148),
              ),
            ),
            space16H,
            const CustomTextField(
              title: "Title",
              hintText: "Enter the title of your issue",
            ),
            space12H,
            const CustomTextField(
              title: "Write in below box",
              hintText: "Write here...",
              maxLines: 6,
            ),
            space24H,
            CustomButton(
              text: "Send",
              backgroundColor: const Color(0xFF536148),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}
