import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _firstNameController = TextEditingController(text: "John");
  final _lastNameController = TextEditingController(text: "Doe");
  final _emailController = TextEditingController(text: "john.doe@example.com");
  final _phoneController = TextEditingController(text: "+1 234 567 8900");

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _showDeleteAccountDialog() {
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Consumer(
          builder: (context, ref, child) {
            final profileState = ref.watch(profileActionControllerProvider);

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.red),
                  space8W,
                  CustomText(
                    "Delete Account",
                    variant: TextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ],
              ),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "This action is permanent and cannot be undone. Please enter your password to confirm.",
                      color: AppColors.kBrownTextColor,
                      variant: TextVariant.bodySmall,
                    ),
                    space16H,
                    CustomTextField(
                      textEditingController: passwordController,
                      hintText: "Enter your password",
                      title: "Password",
                      isPassword: true,
                      isRequired: true,
                      prefixIcon: const Icon(Icons.lock_outline, size: 20),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Password is required to confirm';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: profileState.isLoading
                      ? null
                      : () => Navigator.of(dialogContext).pop(),
                  child: const CustomText(
                    "Cancel",
                    color: AppColors.kBrownTextColor,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: profileState.isLoading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;
                          final pwd = passwordController.text;

                          final success = await ref
                              .read(profileActionControllerProvider.notifier)
                              .deleteAccount(password: pwd);

                          if (!mounted) return;
                          final state = ref.read(profileActionControllerProvider);

                          if (success) {
                            if (dialogContext.mounted) {
                              Navigator.of(dialogContext).pop();
                            }
                            if (mounted) {
                              CustomSnackbar.show(
                                context,
                                state.successMessage ?? 'Account deleted successfully',
                                isError: false,
                              );
                              context.go(AppRoutes.login);
                            }
                          } else {
                            if (mounted) {
                              CustomSnackbar.show(
                                context,
                                state.errorMessage ?? 'Failed to delete account',
                                isError: true,
                              );
                            }
                          }
                        },
                  child: profileState.isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const CustomText(
                          "Confirm Delete",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "Personal Information",
          variant: TextVariant.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            space16H,
            const CircleAvatar(
              radius: 44,
              backgroundColor: Color(0xFFF1F1F1),
              child: Icon(
                Icons.person_outline,
                size: 44,
                color: AppColors.kTextColor,
              ),
            ),
            space24H,
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    title: "First Name",
                    textEditingController: _firstNameController,
                    hintText: "First Name",
                  ),
                ),
                space12W,
                Expanded(
                  child: CustomTextField(
                    title: "Last Name",
                    textEditingController: _lastNameController,
                    hintText: "Last Name",
                  ),
                ),
              ],
            ),
            space12H,
            CustomTextField(
              title: "Email Address",
              textEditingController: _emailController,
              hintText: "Enter email",
            ),
            space12H,
            CustomTextField(
              title: "Phone Number",
              textEditingController: _phoneController,
              hintText: "Enter phone number",
            ),
            space32H,
            CustomButton(
              text: "Save Changes",
              backgroundColor: const Color(0xFF536148),
              onPressed: () {
                CustomSnackbar.show(context, 'Profile updated successfully');
                context.pop();
              },
            ),
            space16H,
            CustomButton(
              text: "Delete Account",
              isOutlined: true,
              borderColor: Colors.red.shade300,
              textColor: Colors.red,
              onPressed: () => _showDeleteAccountDialog(),
            ),
            space24H,
          ],
        ),
      ),
    );
  }
}
