import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/navigation/app_navigator.dart';

/// Screen showing sub-items when user taps a category (e.g. Home Appliances, Furniture Repair).
class ServiceSubCategoryScreen extends StatelessWidget {
  final String serviceName;
  final String categoryName;
  final List<String> items;
  final IconData icon;

  const ServiceSubCategoryScreen({
    super.key,
    required this.serviceName,
    required this.categoryName,
    required this.items,
    this.icon = CupertinoIcons.square_grid_2x2,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: Text(categoryName, style: AppTextStyles.title),
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
              const SizedBox(height: 24),
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
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
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
    // Home Appliances
    'A/C': 'https://images.unsplash.com/photo-1665826254141-bfa10685e002?w=400&auto=format&fit=crop&q=60',
    'Washing Machine': 'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1?w=400&auto=format&fit=crop&q=60',
    'TV': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400&auto=format&fit=crop&q=60',
    'Air Cooler': 'https://images.unsplash.com/photo-1665826254141-bfa10685e002?w=400&auto=format&fit=crop&q=60',
    'Geyser': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Fans': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Switch Boards': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Plugs': 'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?w=400&auto=format&fit=crop&q=60',
    'Exhaust': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Fan Regulator': 'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?w=400&auto=format&fit=crop&q=60',
    'Fancy Lights': 'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?w=400&auto=format&fit=crop&q=60',
    'Bulbs and Tubelights': 'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?w=400&auto=format&fit=crop&q=60',
    'Chandelier': 'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?w=400&auto=format&fit=crop&q=60',
    'Doorbell': 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&auto=format&fit=crop&q=60',
    'CCTV': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400&auto=format&fit=crop&q=60',
    'MCB': 'https://images.unsplash.com/photo-1565814329452-e1efa11c5b89?w=400&auto=format&fit=crop&q=60',
    'Home Theatre': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400&auto=format&fit=crop&q=60',
    'Inverters': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Stabiliser': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Iron': 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=400&auto=format&fit=crop&q=60',
    'Vacuum Cleaner': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Trimmer': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400&auto=format&fit=crop&q=60',
    'Projector': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400&auto=format&fit=crop&q=60',
    'Desktops': 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=400&auto=format&fit=crop&q=60',
    // Kitchen Appliances
    'Refrigerators': 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=400&auto=format&fit=crop&q=60',
    'Stove': 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=400&auto=format&fit=crop&q=60',
    'Coffee Machine': 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&auto=format&fit=crop&q=60',
    'Microwave': 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=400&auto=format&fit=crop&q=60',
    'Water Purifier': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Juicer and Mixer': 'https://images.unsplash.com/photo-1571175443880-49e1d25b2bc5?w=400&auto=format&fit=crop&q=60',
    // Furniture Repair
    'Bed': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400&auto=format&fit=crop&q=60',
    'Sofa': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop&q=60',
    'Table': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop&q=60',
    'Chair': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop&q=60',
    'Door Repair': 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&auto=format&fit=crop&q=60',
    'Drawer': 'https://media.istockphoto.com/id/1152991125/photo/male-hand-opening-drawer-on-white-cabinet.jpg?s=612x612&w=0&k=20&c=792aNSErEO-zvKz3dwP0q3pEUoqtlZvKFtcrtW17GGg=',
    'Cupboard Lock': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400&auto=format&fit=crop&q=60',
    'Cupboard': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop&q=60',
    'Door Mesh': 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&auto=format&fit=crop&q=60',
    'Door Closer': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0rlSpcG4_6UpRdxswrozujdfRERexgi_KtQ&s',
    'Door Lock': 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=400&auto=format&fit=crop&q=60',
    // Kitchen Fitting
    'Cabinet Hinges': 'https://www.shutterstock.com/image-photo/stainless-furniture-hinge-cabinet-600nw-2446160655.jpg',
    'Pull-out Drawer': 'https://www.shutterstock.com/image-photo/stainless-furniture-hinge-cabinet-600nw-2446160655.jpg',
    'Cabinet Hydraulic': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3U5HebcDRdXgGPNoBSQF5NQ9qDaBKuIO7EA&s',
    // Dry Cleaning
    'Sofa Fabric': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop&q=60',
    'Leather Sofa': 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=400&auto=format&fit=crop&q=60',
    'Carpets': 'https://images.unsplash.com/photo-1600166898405-da9535204843?w=400&auto=format&fit=crop&q=60',
    'Fabric Headboard': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400&auto=format&fit=crop&q=60',
    'Leather Headboard': 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400&auto=format&fit=crop&q=60',
    'Dining Tables and Chairs': 'https://thumbs.dreamstime.com/b/young-positive-afro-american-house-maid-apron-cleaning-table-modern-kitchen-services-concept-housework-female-cleaner-174355373.jpg',
    'Curtains': 'https://media.istockphoto.com/id/486726853/photo/ironing-with-garment-steamer.jpg?s=612x612&w=0&k=20&c=t8NvfBAcpD3fb7iQfsEZRfh9YT1txiFR9aAJTJORy3o=',
    'Large Chair': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&auto=format&fit=crop&q=60',
    // Plumber
    'Bath and Shower': 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&auto=format&fit=crop&q=60',
    'Tap Mixer': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Toilet': 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&auto=format&fit=crop&q=60',
    'Basins & Sinks': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Drainage & Blockage': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Leakages & Connections': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    'Water Tanks & Motors': 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39?w=400&auto=format&fit=crop&q=60',
    // Pest Control (user-provided link for termite/bedbugs; cockroach per user)
    'Cockroach': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU6xVIg-EAXNhdQWiN_ZVa21QIeebOL16HeA&s',
    'Termite Control': 'https://plus.unsplash.com/premium_photo-1682126097276-57e5d1d3f812?fm=jpg&q=60&w=800&auto=format&fit=crop',
    'Bedbugs': 'https://images.unsplash.com/photo-1584515933487-779824d29309?w=400&auto=format&fit=crop&q=60',
    // Cleaning
    'Bathroom Cleaning': 'https://images.unsplash.com/photo-1552321554-5fefe8c9ef14?w=400&auto=format&fit=crop&q=60',
    'Kitchen Cleaning': 'https://static.vecteezy.com/system/resources/thumbnails/074/448/133/small/a-woman-in-yellow-gloves-cleans-the-kitchen-counter-with-a-yellow-cloth-showcasing-a-bright-and-tidy-atmosphere-photo.jpeg',
    'Fan': 'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400&auto=format&fit=crop&q=60',
    'Glass/Window': 'https://images.unsplash.com/photo-1769767677770-debe851c95d4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Z2xhc3MlMjBjbGVhbmluZ3xlbnwwfHwwfHx8Mg%3D%3D',
  };
}
