import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../../presentation/controllers/shop_controller.dart';
import '../../data/models/shop_model.dart';

class OpeningHoursPage extends ConsumerStatefulWidget {
  const OpeningHoursPage({super.key});

  @override
  ConsumerState<OpeningHoursPage> createState() => _OpeningHoursPageState();
}

class _OpeningHoursPageState extends ConsumerState<OpeningHoursPage> {
  final _dayController = TextEditingController();
  TimeOfDay? _openTime;
  TimeOfDay? _closeTime;
  String? _editingId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(openingHourControllerProvider.notifier).fetchOpeningHours();
    });
  }

  @override
  void dispose() {
    _dayController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final hourStr = hour.toString().padLeft(2, '0');
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hourStr:$minute $period';
  }

  Future<void> _pickTime({required bool isOpen}) async {
    final initial = isOpen
        ? (_openTime ?? const TimeOfDay(hour: 9, minute: 0))
        : (_closeTime ?? const TimeOfDay(hour: 17, minute: 0));
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isOpen) {
          _openTime = picked;
        } else {
          _closeTime = picked;
        }
      });
    }
  }

  TimeOfDay? _parseTime(String time) {
    try {
      final parts = time.split(' ');
      final timeParts = parts[0].split(':');
      var h = int.parse(timeParts[0]);
      final m = int.parse(timeParts[1]);
      if (parts.length > 1) {
        if (parts[1].toUpperCase() == 'PM' && h != 12) h += 12;
        if (parts[1].toUpperCase() == 'AM' && h == 12) h = 0;
      }
      return TimeOfDay(hour: h, minute: m);
    } catch (_) {
      return null;
    }
  }

  void _populateEditForm(OpeningHourModel hour) {
    setState(() {
      _editingId = hour.id;
      _dayController.text = hour.day;
      _openTime = _parseTime(hour.openTime);
      _closeTime = _parseTime(hour.closeTime);
    });
  }

  void _cancelEdit() {
    setState(() {
      _editingId = null;
      _dayController.clear();
      _openTime = null;
      _closeTime = null;
    });
  }

  Future<void> _handleSave() async {
    final day = _dayController.text.trim();
    if (day.isEmpty) {
      CustomSnackbar.show(context, 'Please enter a day or range', isError: true);
      return;
    }
    if (_openTime == null) {
      CustomSnackbar.show(context, 'Please select an open time', isError: true);
      return;
    }
    if (_closeTime == null) {
      CustomSnackbar.show(context, 'Please select a close time', isError: true);
      return;
    }

    final isUpdating = _editingId != null;
    final success = isUpdating
        ? await ref.read(openingHourControllerProvider.notifier).updateOpeningHour(
            id: _editingId!,
            day: day,
            openTime: _formatTime(_openTime!),
            closeTime: _formatTime(_closeTime!),
          )
        : await ref.read(openingHourControllerProvider.notifier).addOpeningHour(
            day: day,
            openTime: _formatTime(_openTime!),
            closeTime: _formatTime(_closeTime!),
          );

    if (!mounted) return;

    if (success) {
      _cancelEdit();
      CustomSnackbar.show(context, isUpdating ? 'Opening hour updated!' : 'Opening hour added!', isError: false);
    } else {
      final err = ref.read(openingHourControllerProvider).errorMessage;
      CustomSnackbar.show(context, err ?? 'Failed to save', isError: true);
    }
  }

  Future<void> _handleDelete(String id) async {
    final success = await ref.read(openingHourControllerProvider.notifier).deleteOpeningHour(id);
    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(context, 'Opening hour deleted!', isError: false);
    } else {
      final err = ref.read(openingHourControllerProvider).errorMessage;
      CustomSnackbar.show(context, err ?? 'Failed to delete', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(openingHourControllerProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const CustomText(
          AppStaticStrings.appName,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              'Opening Hours',
              variant: TextVariant.headlineLarge,
              fontWeight: FontWeight.bold,
            ),
            space4H,
            const CustomText(
              'Let customers know when your shop is open.',
              color: AppColors.kBrownTextColor,
            ),
            space20H,

            // ─── Add Form ───
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        _editingId == null ? 'Add New Hours' : 'Edit Hours',
                        fontWeight: FontWeight.bold,
                        variant: TextVariant.titleMedium,
                      ),
                      if (_editingId != null)
                        TextButton(
                          onPressed: _cancelEdit,
                          child: const Text('Cancel', style: TextStyle(color: AppColors.kPrimaryColor)),
                        ),
                    ],
                  ),
                  space12H,
                  CustomTextField(
                    textEditingController: _dayController,
                    title: 'Day / Range',
                    hintText: 'e.g. Monday - Friday',
                  ),
                  space12H,
                  Row(
                    children: [
                      Expanded(child: _timePickerTile(isOpen: true)),
                      space12W,
                      Expanded(child: _timePickerTile(isOpen: false)),
                    ],
                  ),
                  space16H,
                  CustomButton(
                    text: _editingId == null ? '+ Add Opening Hour' : 'Update Opening Hour',
                    backgroundColor: AppColors.kPrimaryColor,
                    isLoading: state.isAdding,
                    onPressed: state.isAdding ? null : _handleSave,
                  ),
                ],
              ),
            ),

            space24H,

            // ─── Hours List ───
            if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (state.hours.isEmpty)
              _emptyHoursWidget()
            else ...[
              const CustomText(
                'Current Hours',
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              space12H,
              ...state.hours.map((h) => _hourCard(h)),
            ],

            space32H,

            // ─── Done Button ───
            CustomButton(
              text: 'Done →',
              backgroundColor: AppColors.kSetupButtonColor,
              onPressed: () => context.go(AppRoutes.mainLayout),
            ),
            space16H,
          ],
        ),
      ),
    );
  }

  Widget _timePickerTile({required bool isOpen}) {
    final label = isOpen ? 'Open Time' : 'Close Time';
    final time = isOpen ? _openTime : _closeTime;
    return GestureDetector(
      onTap: () => _pickTime(isOpen: isOpen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(label, fontWeight: FontWeight.bold, variant: TextVariant.labelMedium),
          space4H,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  isOpen ? Icons.lock_open_outlined : Icons.lock_outline,
                  size: 18,
                  color: AppColors.kPrimaryColor,
                ),
                space8W,
                Expanded(
                  child: CustomText(
                    time != null ? _formatTime(time) : 'Select',
                    color: time != null ? Colors.black87 : Colors.grey,
                    variant: TextVariant.bodyMedium,
                  ),
                ),
                const Icon(Icons.access_time, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hourCard(OpeningHourModel hour) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.access_time, color: AppColors.kPrimaryColor, size: 20),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  hour.day,
                  fontWeight: FontWeight.w600,
                  variant: TextVariant.bodyMedium,
                ),
                space2H,
                CustomText(
                  '${hour.openTime} – ${hour.closeTime}',
                  color: AppColors.kBrownTextColor,
                  variant: TextVariant.bodySmall,
                ),
              ],
            ),
          ),
          if (hour.isClosed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const CustomText(
                'Closed',
                color: Colors.red,
                variant: TextVariant.labelSmall,
              ),
            ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                _populateEditForm(hour);
              } else if (value == 'delete') {
                _handleDelete(hour.id);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete', style: TextStyle(color: Colors.red))),
            ],
            icon: const Icon(Icons.more_vert, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _emptyHoursWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const Column(
        children: [
          Icon(Icons.schedule_outlined, size: 40, color: Colors.grey),
          space8H,
          CustomText(
            'No opening hours yet',
            color: AppColors.kBrownTextColor,
            variant: TextVariant.bodyMedium,
          ),
          CustomText(
            'Add your first opening hour above',
            color: Colors.grey,
            variant: TextVariant.bodySmall,
          ),
        ],
      ),
    );
  }
}
