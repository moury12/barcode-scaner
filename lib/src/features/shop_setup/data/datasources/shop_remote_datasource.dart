import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../models/shop_model.dart';

abstract class ShopRemoteDataSource {
  Future<ShopModel> getMyShop();

  Future<ShopModel> createShop({
    required String name,
    required String contactNumber,
    required String description,
    required String address,
    String? imagePath,
  });

  Future<ShopModel> updateShop({
    String? name,
    String? contactNumber,
    String? description,
    String? address,
    String? imagePath,
  });

  Future<OpeningHourModel> createOpeningHour({
    required String day,
    required String openTime,
    required String closeTime,
  });

  Future<List<OpeningHourModel>> getOpeningHours();

  Future<bool> updateOpeningHour({
    required String id,
    String? day,
    String? openTime,
    String? closeTime,
    bool? isClosed,
  });

  Future<bool> deleteOpeningHour(String id);
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  final ApiService _api;

  ShopRemoteDataSourceImpl(this._api);

  @override
  Future<ShopModel> getMyShop() async {
    final response = await _api.get('/shop/my-shop');
    if (response.data != null && response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data == null) throw Exception('No shop data returned');
      return ShopModel.fromJson(data);
    }
    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch shop';
    throw Exception(msg);
  }

  @override
  Future<ShopModel> createShop({
    required String name,
    required String contactNumber,
    required String description,
    required String address,
    String? imagePath,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'contactNumber': contactNumber,
      'description': description,
      'address': address,
      if (imagePath != null)
        'image': await MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
    });

    final response = await _api.post(
      '/shop/create-shop',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'] as Map<String, dynamic>?;
        if (data != null) return ShopModel.fromJson(data);
      }
    }

    // 409 "already created" — fetch existing shop
    if (response.statusCode == 409) {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message'] as String
          : 'Conflict';
      if (msg.contains('already created')) {
        return getMyShop();
      }
      throw Exception(msg);
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to create shop';
    throw Exception(msg);
  }

  @override
  Future<ShopModel> updateShop({
    String? name,
    String? contactNumber,
    String? description,
    String? address,
    String? imagePath,
  }) async {
    final fields = <String, dynamic>{};
    if (name != null) fields['name'] = name;
    if (contactNumber != null) fields['contactNumber'] = contactNumber;
    if (description != null) fields['description'] = description;
    if (address != null) fields['address'] = address;
    if (imagePath != null) {
      fields['image'] = await MultipartFile.fromFile(
          imagePath, filename: imagePath.split('/').last);
    }

    final formData = FormData.fromMap(fields);
    final response = await _api.patch(
      '/shop/update-shop',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.data != null && response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data != null) return ShopModel.fromJson(data);
    }
    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to update shop';
    throw Exception(msg);
  }

  @override
  Future<OpeningHourModel> createOpeningHour({
    required String day,
    required String openTime,
    required String closeTime,
  })
   async {
    final response = await _api.post(
      '/opening-hour/create-opening-hour',
      data: {
        'day': day,
        'openTime': openTime,
        'closeTime': closeTime,
      },
    );

    if (response.data != null && response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data != null) return OpeningHourModel.fromJson(data);
    }
    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to create opening hour';
    throw Exception(msg);
  }

  @override
  Future<List<OpeningHourModel>> getOpeningHours() async {
    final response = await _api.get('/opening-hour/opening-hours');
    if (response.data != null && response.data['success'] == true) {
      final rawList = response.data['data'];
      if (rawList is List) {
        return rawList
            .whereType<Map<String, dynamic>>()
            .map((e) => OpeningHourModel.fromJson(e))
            .toList();
      }
      return [];
    }
    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch opening hours';
    throw Exception(msg);
  }

  @override
  Future<bool> updateOpeningHour({
    required String id,
    String? day,
    String? openTime,
    String? closeTime,
    bool? isClosed,
  }) async {
    final data = <String, dynamic>{};
    if (day != null) data['day'] = day;
    if (openTime != null) data['openTime'] = openTime;
    if (closeTime != null) data['closeTime'] = closeTime;
    if (isClosed != null) data['isClosed'] = isClosed;

    final response = await _api.patch(
      '/opening-hour/update-opening-hour/$id',
      data: data,
    );

    if (response.data != null && response.data['success'] == true) {
      return true;
    }
    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to update opening hour';
    throw Exception(msg);
  }

  @override
  Future<bool> deleteOpeningHour(String id) async {
    final response = await _api.delete(
      '/opening-hour/delete-opening-hour/$id',
    );

    if (response.data != null && response.data['success'] == true) {
      return true;
    }
    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to delete opening hour';
    throw Exception(msg);
  }
}

final shopRemoteDataSourceProvider = Provider<ShopRemoteDataSource>((ref) {
  final api = ref.watch(apiServiceProvider);
  return ShopRemoteDataSourceImpl(api);
});
