import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../src_export.dart';

class LegalContentPage extends ConsumerStatefulWidget {
  final String contentType;
  final String title;

  const LegalContentPage({
    super.key,
    required this.contentType,
    required this.title,
  });

  @override
  ConsumerState<LegalContentPage> createState() => _LegalContentPageState();
}

class _LegalContentPageState extends ConsumerState<LegalContentPage> {
  bool _isLoading = true;
  String? _htmlContent;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchContent();
  }

  Future<void> _fetchContent() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final api = ref.read(apiServiceProvider);
      final response = await api.get(
        '/content/content-by-type/${widget.contentType}',
      );

      if (!mounted) return;

      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'] as Map<String, dynamic>?;
        final html = data?['content'] as String? ?? '';
        setState(() {
          _isLoading = false;
          _htmlContent = html;
        });
      } else {
        final msg = (response.data is Map && response.data['message'] != null)
            ? response.data['message']
            : 'Failed to retrieve content';
        setState(() {
          _isLoading = false;
          _errorMessage = msg;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          widget.title,
          variant: TextVariant.titleLarge,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      space12H,
                      CustomText(
                        _errorMessage!,
                        color: AppColors.kBrownTextColor,
                      ),
                      space16H,
                      CustomButton(
                        text: 'Retry',
                        onPressed: _fetchContent,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: AppPadding.getPadding16(context),
                  child: HtmlWidget(
                    _htmlContent ?? '<p>No content available.</p>',
                    textStyle: const TextStyle(
                      color: AppColors.kTextColor,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ),
    );
  }
}
