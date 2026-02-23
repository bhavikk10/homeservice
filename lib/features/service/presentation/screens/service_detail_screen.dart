import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';

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
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          CupertinoButton(
            padding: const EdgeInsets.all(16),
            onPressed: () {
              setState(() => _isExpanded = !_isExpanded);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(widget.question, style: AppTextStyles.body),
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

  // Electrician & Carpenter: category first, then sub-page
  static const Map<String, Map<String, List<String>>> _categoryServices = {
    'Electrician': {
      'Home Appliances': [
        'A/C', 'Washing Machine', 'TV', 'Air Cooler', 'Geyser', 'Fans',
        'Switch Boards', 'Plugs', 'Exhaust', 'Fan Regulator', 'Fancy Lights',
        'Bulbs and Tubelights', 'Chandelier', 'Doorbell', 'CCTV', 'MCB',
        'Home Theatre', 'Inverters', 'Stabiliser', 'Iron', 'Vacuum Cleaner',
        'Trimmer', 'Projector', 'Desktops',
      ],
      'Kitchen Appliances': [
        'Refrigerators', 'Stove', 'Coffee Machine', 'Microwave',
        'Water Purifier', 'Juicer and Mixer',
      ],
    },
    'Carpenter': {
      'Furniture Repair': [
        'Bed', 'Sofa', 'Table', 'Chair', 'Door Repair', 'Drawer',
        'Cupboard Lock', 'Cupboard', 'Door Mesh', 'Door Closer', 'Door Lock',
      ],
      'Kitchen Fitting': [
        'Cabinet Hinges', 'Pull-out Drawer', 'Cabinet Hydraulic',
      ],
    },
  };

  // Direct-item services (no category step)
  static const Map<String, List<String>> _directServices = {
    'Plumber': [
      'Bath and Shower', 'Tap Mixer', 'Toilet', 'Basins & Sinks',
      'Drainage & Blockage', 'Leakages & Connections', 'Water Tanks & Motors',
    ],
    'Dry Cleaning': [
      'Sofa Fabric', 'Leather Sofa', 'Carpets', 'Fabric Headboard',
      'Leather Headboard', 'Dining Tables and Chairs', 'Curtains', 'Large Chair',
    ],
    'Pest Control': ['Cockroach', 'Termite Control', 'Bedbugs'],
    'Cleaning': ['Bathroom Cleaning', 'Kitchen Cleaning', 'Fan', 'Glass/Window'],
  };

  static const Map<String, String> _categoryImages = {
    'Home Appliances': 'https://images.unsplash.com/photo-1558002038-10559092a3d2?w=200&h=200&fit=crop',
    'Kitchen Appliances': 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=200&h=200&fit=crop',
    'Furniture Repair': 'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=1332&auto=format&fit=crop',
    'Kitchen Fitting': 'https://media.istockphoto.com/id/134581710/photo/man-constructing-cabinet-units-in-new-kitchen.jpg?s=612x612&w=0&k=20&c=qM8RekDmXiTt-T66n2AJSW7hiBJ6whwctBPw9D-j2xk=',
  };

  List<Widget> _buildServiceOptions(BuildContext context) {
    // Electrician & Carpenter: show category cards first
    final categories = _categoryServices[serviceName];
    if (categories != null) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: categories.entries.map((e) {
              final imageUrl = _categoryImages[e.key];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GestureDetector(
                  onTap: () => AppNavigator.pushServiceSubCategory(
                    context,
                    serviceName: serviceName,
                    categoryName: e.key,
                    items: e.value,
                    icon: serviceName == 'Electrician'
                        ? CupertinoIcons.bolt_fill
                        : CupertinoIcons.hammer_fill,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: CupertinoColors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: CupertinoColors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: 64,
                            height: 64,
                            child: imageUrl != null
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Icon(
                                      serviceName == 'Electrician'
                                          ? CupertinoIcons.bolt_fill
                                          : CupertinoIcons.hammer_fill,
                                      color: AppColors.actionBlue,
                                      size: 32,
                                    ),
                                  )
                                : Icon(
                                    serviceName == 'Electrician'
                                        ? CupertinoIcons.bolt_fill
                                        : CupertinoIcons.hammer_fill,
                                    color: AppColors.actionBlue,
                                    size: 32,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            e.key,
                            style: AppTextStyles.header.copyWith(fontSize: 16),
                          ),
                        ),
                        Icon(CupertinoIcons.chevron_right, color: AppColors.textSecondary),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ];
    }

    // Direct services: show item grid
    final items = _directServices[serviceName];
    if (items != null) {
      final icon = _getIconForService(serviceName);
      return [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 0.85,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: items
                .map((item) => _buildItemCard(context, item, icon))
                .toList(),
          ),
        ),
      ];
    }

    return [];
  }

  IconData _getIconForService(String name) {
    switch (name) {
      case 'Plumber':
        return CupertinoIcons.drop_fill;
      case 'Dry Cleaning':
        return CupertinoIcons.drop_triangle_fill;
      case 'Pest Control':
        return CupertinoIcons.ant;
      case 'Cleaning':
        return CupertinoIcons.sparkles;
      default:
        return CupertinoIcons.square_grid_2x2;
    }
  }

  Widget _buildItemCard(BuildContext context, String title, IconData icon) {
    final imageUrl = _itemImageUrls[title];
    return GestureDetector(
      onTap: () => AppNavigator.pushCaptureProblem(context),
      child: Column(
        children: [
          Container(
            height: 88,
            width: 88,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (_, child, progress) =>
                          progress == null ? child : _buildImagePlaceholder(icon),
                      errorBuilder: (_, __, ___) => _buildImagePlaceholder(icon),
                    )
                  : _buildImagePlaceholder(icon),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTextStyles.subtext.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(IconData icon) => Container(
        color: AppColors.backgroundLight,
        alignment: Alignment.center,
        child: Icon(icon, color: AppColors.textSecondary, size: 32),
      );

  static const Map<String, String> _itemImageUrls = {
    'Bath and Shower': 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&auto=format&fit=crop&q=60',
    'Tap Mixer': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Toilet': 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&auto=format&fit=crop&q=60',
    'Basins & Sinks': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Drainage & Blockage': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Leakages & Connections': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Water Tanks & Motors': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Sofa Fabric': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop&q=60',
    'Leather Sofa': 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=400&auto=format&fit=crop&q=60',
    'Carpets': 'https://images.unsplash.com/photo-1600166898405-da9535204843?w=400&auto=format&fit=crop&q=60',
    'Fabric Headboard': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400&auto=format&fit=crop&q=60',
    'Leather Headboard': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400&auto=format&fit=crop&q=60',
    'Dining Tables and Chairs': 'https://thumbs.dreamstime.com/b/young-positive-afro-american-house-maid-apron-cleaning-table-modern-kitchen-services-concept-housework-female-cleaner-174355373.jpg',
    'Curtains': 'https://media.istockphoto.com/id/486726853/photo/ironing-with-garment-steamer.jpg?s=612x612&w=0&k=20&c=t8NvfBAcpD3fb7iQfsEZRfh9YT1txiFR9aAJTJORy3o=',
    'Large Chair': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop&q=60',
    'Cockroach': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU6xVIg-EAXNhdQWiN_ZVa21QIeebOL16HeA&s',
    'Termite Control': 'https://plus.unsplash.com/premium_photo-1682126097276-57e5d1d3f812?fm=jpg&q=60&w=800&auto=format&fit=crop',
    'Bedbugs': 'https://images.unsplash.com/photo-1584515933487-779824d29309?w=400&auto=format&fit=crop&q=60',
    'Bathroom Cleaning': 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&auto=format&fit=crop&q=60',
    'Kitchen Cleaning': 'https://static.vecteezy.com/system/resources/thumbnails/074/448/133/small/a-woman-in-yellow-gloves-cleans-the-kitchen-counter-with-a-yellow-cloth-showcasing-a-bright-and-tidy-atmosphere-photo.jpeg',
    'Fan': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400&auto=format&fit=crop&q=60',
    'Glass/Window': 'https://images.unsplash.com/photo-1769767677770-debe851c95d4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2xhc3MlMjBjbGVhbmluZ3xlbnwwfHwwfHx8Mg%3D%3D',
  };

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(onPressed: () => Navigator.of(context).pop()),
        middle: Text('$serviceName Services', style: AppTextStyles.title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(padding: EdgeInsets.zero, onPressed: () {}, child: Icon(CupertinoIcons.search, color: CupertinoColors.black)),
            CupertinoButton(padding: EdgeInsets.zero, onPressed: () {}, child: Icon(CupertinoIcons.bell, color: CupertinoColors.black)),
          ],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),
              ..._buildServiceOptions(context),
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Details',
                      style: AppTextStyles.header.copyWith(fontSize: 17),
                    ),
                    const SizedBox(height: 16),
                    _ServiceDetailExpansionTile(
                      question: 'What is your cancellation policy?',
                      answer: 'You can cancel or reschedule your appointment up to 24 hours before the scheduled time without any charges.',
                    ),
                    _ServiceDetailExpansionTile(
                      question: 'How do I track my service professional?',
                      answer: 'You will receive real-time updates via the app, including when your professional is assigned, on the way, and has arrived at your location.',
                    ),
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
}
