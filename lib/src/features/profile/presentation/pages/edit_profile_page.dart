import '../../../../src_export.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
