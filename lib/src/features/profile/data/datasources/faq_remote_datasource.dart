import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barcode_scaner/src/core/services/api_service.dart';
import '../models/faq_model.dart';

abstract class FaqRemoteDataSource {
  Future<List<FaqModel>> getUserFaqs();
}

class FaqRemoteDataSourceImpl implements FaqRemoteDataSource {
  final ApiService _api;
  FaqRemoteDataSourceImpl(this._api);

  @override
  Future<List<FaqModel>> getUserFaqs() async {
    final response = await _api.get('/faq/user-faqs');
    if (response.data != null && response.data['success'] == true) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => FaqModel.fromJson(e))
          .toList();
    }
    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch FAQs';
    throw Exception(msg);
  }
}

final faqRemoteDataSourceProvider = Provider<FaqRemoteDataSource>((ref) {
  final api = ref.watch(apiServiceProvider);
  return FaqRemoteDataSourceImpl(api);
});

// ─── Riverpod provider for FAQ list ───
final faqListProvider = FutureProvider<List<FaqModel>>((ref) async {
  final ds = ref.watch(faqRemoteDataSourceProvider);
  return ds.getUserFaqs();
});
