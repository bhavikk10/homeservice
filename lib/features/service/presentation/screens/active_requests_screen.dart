import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/providers/service_request_provider.dart';
import '../../../../core/navigation/app_navigator.dart';

class ActiveRequestsScreen extends ConsumerStatefulWidget {
  const ActiveRequestsScreen({super.key});

  @override
  ConsumerState<ActiveRequestsScreen> createState() => _ActiveRequestsScreenState();
}

class _ActiveRequestsScreenState extends ConsumerState<ActiveRequestsScreen> with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  late AnimationController _tabAnimationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _tabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _tabAnimationController,
      curve: Curves.easeOut,
    ));
    _tabAnimationController.forward();
  }

  @override
  void dispose() {
    _tabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requests = ref.watch(serviceRequestProvider);
    final activeRequests = requests.activeRequests;
    final pastRequests = requests.pastRequests;

    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.white,
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: const Text(
          'Active Requests',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: CupertinoColors.black,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Icon(CupertinoIcons.bell, color: CupertinoColors.black, size: 22),
            ),
            const SizedBox(width: 8),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Icon(CupertinoIcons.search, color: CupertinoColors.black, size: 22),
            ),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Tabs: Active and Past
            Container(
              color: CupertinoColors.white,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _selectedTab = 0;
                          _tabAnimationController.forward(from: 0.0);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab == 0 ? AppColors.actionBlue : CupertinoColors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Active',
                          style: AppTextStyles.header.copyWith(
                            color: _selectedTab == 0 ? AppColors.actionBlue : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _selectedTab = 1;
                          _tabAnimationController.forward(from: 0.0);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _selectedTab == 1 ? AppColors.actionBlue : CupertinoColors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          'Past',
                          style: AppTextStyles.header.copyWith(
                            color: _selectedTab == 1 ? AppColors.actionBlue : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _tabAnimationController,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedTab == 0 ? 'MY ACTIVE REQUESTS' : 'MY PAST REQUESTS',
                          style: AppTextStyles.header,
                        ),
                        const SizedBox(height: 16),
                        if (_selectedTab == 0)
                          ...activeRequests.asMap().entries.map((entry) => _buildRequestCard(entry.value, entry.key)),
                        if (_selectedTab == 1)
                          ...pastRequests.asMap().entries.map((entry) => _buildPastRequestCard(entry.value, entry.key)),
                        if ((_selectedTab == 0 && activeRequests.isEmpty) || (_selectedTab == 1 && pastRequests.isEmpty))
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Text(
                                'No requests found',
                                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestCard(ServiceRequest request, int index) {
    String statusText = 'In Review';
    Color statusColor = AppColors.actionBlue;
    Color statusBgColor = AppColors.actionBlue.withOpacity(0.1);
    
    switch (request.status) {
      case RequestStatus.inReview:
        statusText = 'In Review';
        statusColor = AppColors.actionBlue;
        statusBgColor = AppColors.actionBlue.withOpacity(0.1);
        break;
      case RequestStatus.proAssigned:
        statusText = 'Pro Assigned';
        statusColor = AppColors.actionBlue;
        statusBgColor = AppColors.actionBlue.withOpacity(0.1);
        break;
      case RequestStatus.onTheWay:
        statusText = 'On the Way';
        statusColor = AppColors.successGreen;
        statusBgColor = AppColors.successGreen.withOpacity(0.1);
        break;
      case RequestStatus.completed:
        statusText = 'Completed';
        statusColor = AppColors.successGreen;
        statusBgColor = AppColors.successGreen.withOpacity(0.1);
        break;
      default:
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timestamp and Status Chip
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_getMonthName(request.timestamp.month)} ${request.timestamp.day}, ${request.timestamp.year} • ${_formatTime(request.timestamp)}',
                style: AppTextStyles.subtext.copyWith(fontSize: 12),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: AppTextStyles.subtext.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Service Type
          Text(
            request.serviceType,
            style: AppTextStyles.header.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            request.description,
            style: AppTextStyles.body.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // Thumbnail and Action Link
          Row(
            children: [
              // Thumbnail
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: request.imagePaths != null && request.imagePaths!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          request.imagePaths!.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(CupertinoIcons.photo, color: AppColors.textPlaceholder);
                          },
                        ),
                      )
                    : Icon(CupertinoIcons.photo, color: AppColors.textPlaceholder),
              ),
              const Spacer(),
              // Action Link
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (request.status == RequestStatus.onTheWay || request.status == RequestStatus.proAssigned) {
                    AppNavigator.pushTrackingTimeline(context);
                  } else if (request.status == RequestStatus.inReview) {
                    AppNavigator.pushTrackingTimeline(context);
                  } else {
                    AppNavigator.pushTrackingTimeline(context);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      request.status == RequestStatus.onTheWay
                          ? 'Track on Map'
                          : (request.status == RequestStatus.proAssigned
                              ? 'Track Professional >'
                              : 'View Details >'),
                      style: AppTextStyles.subtext.copyWith(
                        color: AppColors.actionBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (request.status == RequestStatus.onTheWay) ...[
                      const SizedBox(width: 4),
                      Icon(CupertinoIcons.location_solid, color: AppColors.actionBlue, size: 14),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }

  Widget _buildPastRequestCard(ServiceRequest request, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timestamp and Completed Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_getMonthName(request.timestamp.month)} ${request.timestamp.day}, ${request.timestamp.year} • ${_formatTime(request.timestamp)}',
                style: AppTextStyles.subtext.copyWith(fontSize: 12),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.successGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Completed',
                  style: AppTextStyles.subtext.copyWith(
                    color: AppColors.successGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            request.serviceType,
            style: AppTextStyles.header.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          // Completed Timeline
          Text('Service Status', style: AppTextStyles.header.copyWith(fontSize: 14)),
          const SizedBox(height: 16),
          _buildCompletedTimelineItem('Submitted', '${_formatTime(request.timestamp)} - Request received', true),
          _buildCompletedTimelineItem('Professional Assigned', 'Assigned to ${request.professionalName ?? 'Professional'}', true),
          _buildCompletedTimelineItem('Work Completed', 'Service completed successfully', true),
          const SizedBox(height: 16),
          // Review Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.star_fill, color: AppColors.warningText, size: 20),
                    const SizedBox(width: 8),
                    Text('Rate Your Experience', style: AppTextStyles.header.copyWith(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        CupertinoIcons.star_fill,
                        color: index < 4 ? AppColors.warningText : CupertinoColors.systemGrey4,
                        size: 28,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 12),
                Text(
                  'Thank you for choosing our service!',
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildCompletedTimelineItem(String title, String subtitle, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.actionBlue,
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.check_mark, size: 12, color: CupertinoColors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.subtext.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
