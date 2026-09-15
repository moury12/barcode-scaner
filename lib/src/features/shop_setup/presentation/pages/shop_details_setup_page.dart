import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../src_export.dart';
import '../../presentation/controllers/shop_controller.dart';

class ShopDetailsSetupPage extends ConsumerStatefulWidget {
  final bool isEditing;

  const ShopDetailsSetupPage({super.key, this.isEditing = false});

  @override
  ConsumerState<ShopDetailsSetupPage> createState() =>
      _ShopDetailsSetupPageState();
}

class _ShopDetailsSetupPageState extends ConsumerState<ShopDetailsSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _prefillFromState();
      });
    }
  }

  void _prefillFromState() {
    final shop = ref.read(shopControllerProvider).shop;
    if (shop != null) {
      _nameController.text = shop.name;
      _addressController.text = shop.address ?? '';
      _contactController.text = shop.contactNumber ?? '';
      _descriptionController.text = shop.description ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final ctrl = ref.read(shopControllerProvider.notifier);
    bool success;

    if (widget.isEditing) {
      success = await ctrl.updateShop(
        name: _nameController.text.trim(),
        contactNumber: _contactController.text.trim(),
        description: _descriptionController.text.trim(),
        address: _addressController.text.trim(),
        imagePath: _imageFile?.path,
      );
    } else {
      success = await ctrl.createShop(
        name: _nameController.text.trim(),
        contactNumber: _contactController.text.trim(),
        description: _descriptionController.text.trim(),
        address: _addressController.text.trim(),
        imagePath: _imageFile?.path,
      );
    }

    if (!mounted) return;
    final shopState = ref.read(shopControllerProvider);

    if (success) {
      if (widget.isEditing) {
        CustomSnackbar.show(context, 'Shop updated successfully!', isError: false);
        context.pop();
      } else {
        // After creation, go to opening hours page
        context.go(AppRoutes.openingHours);
      }
    } else {
      CustomSnackbar.show(
        context,
        shopState.errorMessage ?? 'Something went wrong',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopState = ref.watch(shopControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const CustomText(
          AppStaticStrings.appName,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomText(
                widget.isEditing
                    ? 'Update Your Shop'
                    : AppStaticStrings.setupYourShop,
                variant: TextVariant.headlineLarge,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              const CustomText(
                "Complete these details to establish your business presence.",
                textAlign: TextAlign.center,
                color: AppColors.kBrownTextColor,
              ),
              space16H,
              CustomTextField(
                textEditingController: _nameController,
                title: "Shop Name",
                hintText: "e.g. Heritage & Hearth",
                isRequired: true,
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Shop name is required' : null,
              ),
              space12H,
              _logoUploader(),
              space12H,
              CustomTextField(
                textEditingController: _addressController,
                title: "Shop Address",
                hintText: "Street address, City, Postcode",
                isRequired: true,
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Address is required' : null,
              ),
              space12H,
              CustomTextField(
                textEditingController: _contactController,
                title: "Contact Number",
                hintText: "+1 (555) 000-0000",
                keyboardType: TextInputType.phone,
                isRequired: true,
                validator: (val) =>
                    (val == null || val.trim().isEmpty) ? 'Contact number is required' : null,
              ),
              space12H,
              CustomTextField(
                textEditingController: _descriptionController,
                title: "Description",
                hintText: "Tell customers about your shop...",
                maxLines: 4,
              ),
              space24H,
              CustomButton(
                text: widget.isEditing ? "Save Changes →" : "Complete Setup →",
                backgroundColor: AppColors.kSetupButtonColor,
                isLoading: shopState.isLoading,
                onPressed: shopState.isLoading ? null : () => _handleSubmit(),
              ),
              space16H,
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoUploader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText("Shop Logo", fontWeight: FontWeight.bold),
        space8H,
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: _imageFile != null
                    ? AppColors.kPrimaryColor
                    : Colors.grey.shade400,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_imageFile!, fit: BoxFit.cover),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 32,
                        color: Colors.grey,
                      ),
                      space8H,
                      CustomText(
                        "Upload Shop Logo",
                        variant: TextVariant.labelMedium,
                        fontWeight: FontWeight.w600,
                      ),
                      space2H,
                      CustomText(
                        "PNG, JPG up to 5MB",
                        variant: TextVariant.bodySmall,
                        color: Colors.grey,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
