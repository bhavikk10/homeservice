import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final String? phoneNumber;
  final String? otp;
  final bool isAuthenticated;
  final bool locationGranted;

  AuthState({
    this.phoneNumber,
    this.otp,
    this.isAuthenticated = false,
    this.locationGranted = false,
  });

  AuthState copyWith({
    String? phoneNumber,
    String? otp,
    bool? isAuthenticated,
    bool? locationGranted,
  }) {
    return AuthState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      locationGranted: locationGranted ?? this.locationGranted,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => AuthState();

  void setPhoneNumber(String phone) {
    state = state.copyWith(phoneNumber: phone);
  }

  void setOtp(String otp) {
    state = state.copyWith(otp: otp);
  }

  void verifyOtp() {
    // Placeholder bypass - always succeeds
    state = state.copyWith(isAuthenticated: true);
  }

  void grantLocationAccess() {
    state = state.copyWith(locationGranted: true);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
