import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../src_export.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String? _pickedImagePath;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final user = ref.read(userProfileProvider).profile;
      if (user != null) {
        _fullNameController.text = user.fullName;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImagePath = picked.path;
      });
    }
  }

  Future<void> _handleSave() async {
    final name = _fullNameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      CustomSnackbar.show(context, 'Full name is required', isError: true);
      return;
    }

    final success = await ref.read(userProfileProvider.notifier).updateProfile(
          fullName: name,
          phone: phone,
          imagePath: _pickedImagePath,
        );

    if (!mounted) return;
    final state = ref.read(userProfileProvider);

    if (success) {
      CustomSnackbar.show(
        context,
        state.successMessage ?? 'Profile updated successfully',
        isError: false,
      );
      context.pop();
    } else {
      CustomSnackbar.show(
        context,
        state.errorMessage ?? 'Failed to update profile',
        isError: true,
      );
    }
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

                          if (!context.mounted) return;
                          final state = ref.read(profileActionControllerProvider);

                          if (success) {
                            if (dialogContext.mounted) {
                              Navigator.of(dialogContext).pop();
                            }
                            if (context.mounted) {
                              CustomSnackbar.show(
                                context,
                                state.successMessage ?? 'Account deleted successfully',
                                isError: false,
                              );
                              context.go(AppRoutes.login);
                            }
                          } else {
                            if (context.mounted) {
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
    final userProfileState = ref.watch(userProfileProvider);
    final user = userProfileState.profile;
    final currentImg = user?.profileImg ?? "";

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
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  if (_pickedImagePath != null)
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: FileImage(File(_pickedImagePath!)),
                    )
                  else if (currentImg.isNotEmpty)
                    ClipOval(
                      child: CustomNetworkImage(
                        imageUrl: currentImg,
                        height: 96,
                        width: 96,
                        boxShape: BoxShape.circle,
                      ),
                    )
                  else
                    const CircleAvatar(
                      radius: 48,
                      backgroundColor: Color(0xFFF1F1F1),
                      child: Icon(
                        Icons.person_outline,
                        size: 48,
                        color: AppColors.kTextColor,
                      ),
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            space24H,
            CustomTextField(
              title: "Full Name",
              textEditingController: _fullNameController,
              hintText: "Enter full name",
              isRequired: true,
            ),
            space12H,
            CustomTextField(
              title: "Email Address",
              textEditingController: _emailController,
              hintText: "Enter email",
              readOnly: true,
            ),
            space12H,
            CustomTextField(
              title: "Phone Number",
              textEditingController: _phoneController,
              hintText: "Enter phone number",
              keyboardType: TextInputType.phone,
            ),
            space32H,
            CustomButton(
              text: "Save Changes",
              isLoading: userProfileState.isLoading,
              backgroundColor: const Color(0xFF536148),
              onPressed: _handleSave,
            ),
            space16H,
            CustomButton(
              text: "Delete Account",
              isOutlined: true,
              borderColor: Colors.red.shade300,
              textColor: Colors.red,
              onPressed: _showDeleteAccountDialog,
            ),
            space24H,
          ],
        ),
      ),
    );
  }
}
