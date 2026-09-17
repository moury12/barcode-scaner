class FaqModel {
  final String id;
  final String question;
  final String answer;
  final String category;

  const FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['_id'] as String? ?? '',
      question: json['question'] as String? ?? '',
      answer: json['answer'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  /// Maps backend category slug to a human-readable display name.
  String get categoryDisplayName {
    switch (category) {
      case 'general':
        return 'General Questions';
      case 'account_profile':
        return 'Account & Profile';
      case 'membership_redemption':
        return 'Membership & Drink Redemption';
      case 'cafe_management':
        return 'Cafe & Shop Management';
      case 'billing_subscription':
        return 'Billing & Subscriptions';
      case 'security_privacy':
        return 'Security & Privacy';
      case 'technical_support':
        return 'Technical & Support';
      default:
        return category
            .split('_')
            .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
            .join(' ');
    }
  }
}
