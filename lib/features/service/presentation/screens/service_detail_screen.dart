import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class _ServiceDetailExpansionTile extends StatefulWidget {
  final String question;
  final String answer;

  const _ServiceDetailExpansionTile({
    required this.question,
    required this.answer,
  });

  @override
  State<_ServiceDetailExpansionTile> createState() => _ServiceDetailExpansionTileState();
}

class _ServiceDetailExpansionTileState extends State<_ServiceDetailExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          CupertinoButton(
            padding: const EdgeInsets.all(16),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.question,
                    style: AppTextStyles.body,
                  ),
                ),
                Icon(
                  _isExpanded ? CupertinoIcons.minus : CupertinoIcons.add,
                  color: AppColors.actionBlue,
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.answer,
                style: AppTextStyles.subtext.copyWith(color: AppColors.textSecondary),
              ),
            ),
        ],
      ),
    );
  }
}

class ServiceDetailScreen extends StatelessWidget {
  final String serviceName;
  const ServiceDetailScreen({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: Text('$serviceName Services', style: AppTextStyles.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Icon(CupertinoIcons.search, color: CupertinoColors.black),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Icon(CupertinoIcons.bell, color: CupertinoColors.black),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Stats
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStat(CupertinoIcons.star_fill, '4.85 Rating', '1.4M+ Happy Customers'),
                    _buildStat(CupertinoIcons.check_mark_circled_solid, 'Insured', 'Service Guarantee'),
                  ],
                ),
              ),
              // Grid of items - Vertical list of sub-services
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildItemCard('Sofa Fabric', CupertinoIcons.rectangle_stack),
                  _buildItemCard('Leather Sofa', CupertinoIcons.rectangle),
                  _buildItemCard('Carpet', CupertinoIcons.square_stack),
                  _buildItemCard('Fabric Headboard', CupertinoIcons.bed_double),
                  _buildItemCard('Dining Chairs', CupertinoIcons.rectangle),
                  _buildItemCard('Curtains', CupertinoIcons.rectangle_on_rectangle),
                ],
              ),
              const SizedBox(height: 32),
              // Home Promise - Dark blue card at bottom
              Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.check_mark_circled_solid, color: AppColors.actionBlue),
                        const SizedBox(width: 8),
                        Text('Home Promise', style: AppTextStyles.title.copyWith(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildPromiseItem(
                      CupertinoIcons.arrow_counterclockwise,
                      '30-day satisfaction warranty',
                      "Complimentary re-service if you're not satisfied",
                    ),
                    const SizedBox(height: 16),
                    _buildPromiseItem(
                      CupertinoIcons.shield_fill,
                      'Comprehensive damage cover',
                      'Up to ₹10,000 coverage for your premium belongings',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Service Details Section with Dropdown Qs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service Details', style: AppTextStyles.header),
                    const SizedBox(height: 16),
                    _buildServiceDetailQuestion('What cleaning agents are used?', 'We use eco-friendly, non-toxic cleaning agents that are safe for your family and pets. All products are certified and approved for home use.'),
                    _buildServiceDetailQuestion('How long does the drying take?', 'Drying time typically ranges from 24-48 hours depending on the item and weather conditions. We ensure proper ventilation and use professional-grade equipment.'),
                    _buildServiceDetailQuestion('Treatment for tough stains?', 'Our experts use specialized stain removal techniques and products. We assess each stain individually and apply the most appropriate treatment method.'),
                    _buildServiceDetailQuestion('What is your cancellation policy?', 'You can cancel or reschedule your appointment up to 24 hours before the scheduled time without any charges.'),
                    _buildServiceDetailQuestion('Do you provide insurance coverage?', 'Yes, we provide comprehensive damage coverage up to ₹10,000 for your premium belongings as part of our Home Promise guarantee.'),
                    _buildServiceDetailQuestion('How do I track my service professional?', 'You will receive real-time updates via the app, including when your professional is assigned, on the way, and has arrived at your location.'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDetailQuestion(String question, String answer) {
    return _ServiceDetailExpansionTile(
      question: question,
      answer: answer,
    );
  }

  Widget _buildStat(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, color: AppColors.actionBlue, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.header.copyWith(fontSize: 14)),
            Text(subtitle, style: AppTextStyles.subtext.copyWith(fontSize: 10)),
          ],
        ),
      ],
    );
  }

  Widget _buildItemCard(String title, IconData icon) {
    // Service item images mapping
    final itemImages = {
      'Sofa Fabric': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=200&h=200&fit=crop',
      'Leather Sofa': 'https://images.unsplash.com/photo-1551292831-023188edfa22?w=200&h=200&fit=crop',
      'Carpet': 'https://images.unsplash.com/photo-1586075010923-2dd4570fb338?w=200&h=200&fit=crop',
      'Fabric Headboard': 'https://images.unsplash.com/photo-1631889993954-0d0a8758f914?w=200&h=200&fit=crop',
      'Dining Chairs': 'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=200&h=200&fit=crop',
      'Curtains': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=200&h=200&fit=crop',
    };

    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: itemImages.containsKey(title)
                ? Image.network(
                    itemImages[title]!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(icon, color: AppColors.textSecondary, size: 32);
                    },
                  )
                : Icon(icon, color: AppColors.textSecondary, size: 32),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyles.subtext.copyWith(fontSize: 11),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildPromiseItem(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.actionBlue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.actionBlue, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.header.copyWith(fontSize: 14)),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.subtext),
            ],
          ),
        ),
      ],
    );
  }
}
