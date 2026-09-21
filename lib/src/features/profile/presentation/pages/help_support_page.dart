import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class HelpSupportPage extends ConsumerStatefulWidget {
  const HelpSupportPage({super.key});

  @override
  ConsumerState<HelpSupportPage> createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends ConsumerState<HelpSupportPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final api = ref.read(apiServiceProvider);
      final response = await api.post(
        '/support/submit',
        data: {
          'title': _titleController.text.trim(),
          'message': _messageController.text.trim(),
        },
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (response.data != null && response.data['success'] == true) {
        CustomSnackbar.show(
          context,
          response.data['message'] as String? ??
              'Your support message has been submitted successfully.',
          isError: false,
        );
        context.pop();
      } else {
        final msg = (response.data is Map && response.data['message'] != null)
            ? response.data['message']
            : 'Failed to submit support request';
        CustomSnackbar.show(context, msg, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      final msg = e.toString().replaceAll('Exception: ', '');
      CustomSnackbar.show(context, msg, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "Help & Support",
          variant: TextVariant.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/images/support.png',
                fit: BoxFit.contain,
                height: 180,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 140,
                  width: 140,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F1F1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.support_agent,
                    size: 64,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              ),
              space16H,
              CustomTextField(
                textEditingController: _titleController,
                title: "Title",
                hintText: "Enter the title of your issue",
                isRequired: true,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              space12H,
              CustomTextField(
                textEditingController: _messageController,
                title: "Message",
                hintText: "Describe your issue here...",
                maxLines: 6,
                isRequired: true,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Message is required';
                  }
                  return null;
                },
              ),
              space24H,
              CustomButton(
                text: "Send Message",
                isLoading: _isLoading,
                backgroundColor: const Color(0xFF536148),
                onPressed: _isLoading ? null : _handleSubmit,
              ),
              space16H,
            ],
          ),
        ),
      ),
    );
  }
}
