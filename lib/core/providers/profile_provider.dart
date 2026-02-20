import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SubscriptionTier {
  silver,
  gold,
  diamond,
}

class UserProfile {
  final String id;
  final String fullName;
  final String address;
  final String society;
  final String houseNo;
  final String plotNo;
  final String userId;
  final SubscriptionTier currentPlan;
  final String? avatarUrl;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.address,
    required this.society,
    required this.houseNo,
    required this.plotNo,
    required this.userId,
    this.currentPlan = SubscriptionTier.silver,
    this.avatarUrl,
  });
}

class ProfileState {
  final UserProfile? profile;
  final bool isLoading;

  ProfileState({
    this.profile,
    this.isLoading = false,
  });

  ProfileState copyWith({
    UserProfile? profile,
    bool? isLoading,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileNotifier extends Notifier<ProfileState> {
  @override
  ProfileState build() => ProfileState(
    profile: UserProfile(
      id: '882941',
      fullName: 'Alex Johnson',
      address: '123, Skyline Apartments, Near Central Park, Sector 45',
      society: 'Green Valley',
      houseNo: 'B-402',
      plotNo: '98A',
      userId: 'HM-2024-X89',
      currentPlan: SubscriptionTier.silver,
    ),
  );

  void updateProfile(UserProfile updatedProfile) {
    state = state.copyWith(profile: updatedProfile);
  }

  void updateSubscription(SubscriptionTier tier) {
    if (state.profile != null) {
      final updated = UserProfile(
        id: state.profile!.id,
        fullName: state.profile!.fullName,
        address: state.profile!.address,
        society: state.profile!.society,
        houseNo: state.profile!.houseNo,
        plotNo: state.profile!.plotNo,
        userId: state.profile!.userId,
        currentPlan: tier,
        avatarUrl: state.profile!.avatarUrl,
      );
      state = state.copyWith(profile: updated);
    }
  }
}

final profileProvider = NotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier.new);
