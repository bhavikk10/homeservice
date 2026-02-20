import 'package:flutter_riverpod/flutter_riverpod.dart';

enum RequestStatus {
  inReview,
  proAssigned,
  onTheWay,
  workInProgress,
  completed,
}

class ServiceRequest {
  final String id;
  final String serviceType;
  final String description;
  final DateTime timestamp;
  final RequestStatus status;
  final String? videoPath;
  final List<String>? imagePaths;
  final String? professionalName;
  final double? professionalRating;

  ServiceRequest({
    required this.id,
    required this.serviceType,
    required this.description,
    required this.timestamp,
    required this.status,
    this.videoPath,
    this.imagePaths,
    this.professionalName,
    this.professionalRating,
  });
}

class ServiceRequestState {
  final List<ServiceRequest> activeRequests;
  final List<ServiceRequest> pastRequests;
  final ServiceRequest? currentRequest;

  ServiceRequestState({
    this.activeRequests = const [],
    this.pastRequests = const [],
    this.currentRequest,
  });

  ServiceRequestState copyWith({
    List<ServiceRequest>? activeRequests,
    List<ServiceRequest>? pastRequests,
    ServiceRequest? currentRequest,
  }) {
    return ServiceRequestState(
      activeRequests: activeRequests ?? this.activeRequests,
      pastRequests: pastRequests ?? this.pastRequests,
      currentRequest: currentRequest ?? this.currentRequest,
    );
  }
}

class ServiceRequestNotifier extends Notifier<ServiceRequestState> {
  @override
  ServiceRequestState build() {
    // Initialize with sample requests matching inspiration
    return ServiceRequestState(
      activeRequests: [
        ServiceRequest(
          id: '88291',
          serviceType: 'Plumbing',
          description: 'Kitchen faucet leak causing low water pressure and cabinet damage. Water pooling under sink.',
          timestamp: DateTime(2023, 10, 24, 10, 30),
          status: RequestStatus.inReview,
          imagePaths: ['https://images.unsplash.com/photo-1621905252507-b35492cc74b4?w=200&h=200&fit=crop'],
        ),
        ServiceRequest(
          id: '88290',
          serviceType: 'Electrician',
          description: 'Master bedroom outlet sparking when plugging in devices. Needs immediate inspection.',
          timestamp: DateTime(2023, 10, 23, 14, 15),
          status: RequestStatus.proAssigned,
          professionalName: 'John Doe',
          professionalRating: 4.9,
          imagePaths: ['https://images.unsplash.com/photo-1621905251918-48416bd8575a?w=200&h=200&fit=crop'],
        ),
        ServiceRequest(
          id: '88289',
          serviceType: 'HVAC Repair',
          description: 'Air conditioner blowing warm air. Professional is currently 5 mins away.',
          timestamp: DateTime(2023, 10, 23, 9, 0),
          status: RequestStatus.onTheWay,
          professionalName: 'Mike Johnson',
          professionalRating: 4.8,
          imagePaths: ['https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=200&h=200&fit=crop'],
        ),
      ],
      pastRequests: [
        ServiceRequest(
          id: '88288',
          serviceType: 'Plumbing',
          description: 'Bathroom sink drain clogged',
          timestamp: DateTime(2023, 10, 20, 15, 30),
          status: RequestStatus.completed,
        ),
      ],
    );
  }

  void addRequest(ServiceRequest request) {
    state = state.copyWith(
      activeRequests: [...state.activeRequests, request],
      currentRequest: request,
    );
  }

  void updateRequestStatus(String id, RequestStatus status) {
    final updated = state.activeRequests.map((req) {
      if (req.id == id) {
        return ServiceRequest(
          id: req.id,
          serviceType: req.serviceType,
          description: req.description,
          timestamp: req.timestamp,
          status: status,
          videoPath: req.videoPath,
          imagePaths: req.imagePaths,
          professionalName: req.professionalName,
          professionalRating: req.professionalRating,
        );
      }
      return req;
    }).toList();

    state = state.copyWith(activeRequests: updated);
  }

  void setCurrentRequest(ServiceRequest? request) {
    state = state.copyWith(currentRequest: request);
  }
}

final serviceRequestProvider = NotifierProvider<ServiceRequestNotifier, ServiceRequestState>(ServiceRequestNotifier.new);
