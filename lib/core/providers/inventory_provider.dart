import 'package:flutter_riverpod/flutter_riverpod.dart';

class InventoryItem {
  final String id;
  final String name;
  final String category;
  final String location;
  final bool isPendingAudit;

  InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    this.isPendingAudit = true,
  });
}

class InventoryState {
  final List<InventoryItem> items;
  final String? videoPath;
  final bool isScanning;

  InventoryState({
    this.items = const [],
    this.videoPath,
    this.isScanning = false,
  });

  InventoryState copyWith({
    List<InventoryItem>? items,
    String? videoPath,
    bool? isScanning,
  }) {
    return InventoryState(
      items: items ?? this.items,
      videoPath: videoPath ?? this.videoPath,
      isScanning: isScanning ?? this.isScanning,
    );
  }
}

class InventoryNotifier extends Notifier<InventoryState> {
  @override
  InventoryState build() => InventoryState();

  void addItem(InventoryItem item) {
    state = state.copyWith(
      items: [...state.items, item],
    );
  }

  void setVideoPath(String path) {
    state = state.copyWith(videoPath: path);
  }

  void startScanning() {
    state = state.copyWith(isScanning: true);
  }

  void completeScanning(List<InventoryItem> scannedItems) {
    state = state.copyWith(
      items: scannedItems,
      isScanning: false,
    );
  }
}

final inventoryProvider = NotifierProvider<InventoryNotifier, InventoryState>(InventoryNotifier.new);
