import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/features/pickup/domain/repositories/pickup_repository.dart';

part 'pickup_store.g.dart';

@injectable
class PickupStore = _PickupStore with _$PickupStore;

abstract class _PickupStore with Store {
  final PickupRepository _repository;

  _PickupStore(this._repository);

  @observable
  ObservableList<PickupRequest> pendingRequests = ObservableList<PickupRequest>();

  @observable
  PickupRequest? selectedPickup;

  @observable
  TrackingLocation? trackingLocation;

  @observable
  bool isLoading = false;

  @observable
  bool isResponding = false;

  @observable
  bool isUpdatingStatus = false;

  @observable
  String? errorMessage;

  @observable
  String? successMessage;

  @computed
  int get pendingCount => pendingRequests.length;

  @computed
  bool get hasPendingRequests => pendingRequests.isNotEmpty;

  @action
  Future<void> loadPendingRequests() async {
    isLoading = true;
    errorMessage = null;

    try {
      final result = await _repository.getPendingRequests();
      result.fold(
        (failure) => errorMessage = _getHumanizedError(failure.message),
        (requests) => pendingRequests = ObservableList.of(requests),
      );
    } catch (e) {
      errorMessage = _getHumanizedError(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadPickupDetails(String pickupId) async {
    isLoading = true;
    errorMessage = null;

    try {
      final result = await _repository.getPickupDetails(pickupId);
      result.fold(
        (failure) => errorMessage = _getHumanizedError(failure.message),
        (pickup) => selectedPickup = pickup,
      );
    } catch (e) {
      errorMessage = _getHumanizedError(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> acceptPickup({
    required String pickupId,
    int? estimatedArrivalMinutes,
  }) async {
    isResponding = true;
    errorMessage = null;
    successMessage = null;

    try {
      final result = await _repository.respondToPickup(
        pickupId: pickupId,
        response: 'accept',
        estimatedArrivalMinutes: estimatedArrivalMinutes,
      );

      return result.fold(
        (failure) {
          errorMessage = _getHumanizedError(failure.message);
          return false;
        },
        (response) {
          selectedPickup = response.pickup;
          successMessage = 'Pickup accepted successfully!';
          // Remove from pending list
          pendingRequests.removeWhere((r) => r.id == pickupId);
          return true;
        },
      );
    } catch (e) {
      errorMessage = _getHumanizedError(e.toString());
      return false;
    } finally {
      isResponding = false;
    }
  }

  @action
  Future<bool> declinePickup({
    required String pickupId,
    required String reason,
  }) async {
    isResponding = true;
    errorMessage = null;
    successMessage = null;

    try {
      final result = await _repository.respondToPickup(
        pickupId: pickupId,
        response: 'decline',
        reason: reason,
      );

      return result.fold(
        (failure) {
          errorMessage = _getHumanizedError(failure.message);
          return false;
        },
        (response) {
          successMessage = 'Pickup declined';
          // Remove from pending list
          pendingRequests.removeWhere((r) => r.id == pickupId);
          return true;
        },
      );
    } catch (e) {
      errorMessage = _getHumanizedError(e.toString());
      return false;
    } finally {
      isResponding = false;
    }
  }

  @action
  Future<void> loadTrackingLocation(String pickupId) async {
    try {
      final result = await _repository.getTrackingLocation(pickupId);
      result.fold(
        (failure) => errorMessage = _getHumanizedError(failure.message),
        (location) => trackingLocation = location,
      );
    } catch (e) {
      errorMessage = _getHumanizedError(e.toString());
    }
  }

  @action
  Future<bool> updateStatus({
    required String pickupId,
    required String status,
  }) async {
    isUpdatingStatus = true;
    errorMessage = null;

    try {
      final result = await _repository.updatePickupStatus(
        pickupId: pickupId,
        status: status,
      );

      return result.fold(
        (failure) {
          errorMessage = _getHumanizedError(failure.message);
          return false;
        },
        (pickup) {
          selectedPickup = pickup;
          return true;
        },
      );
    } catch (e) {
      errorMessage = _getHumanizedError(e.toString());
      return false;
    } finally {
      isUpdatingStatus = false;
    }
  }

  @action
  Future<bool> completePickup({
    required String pickupId,
    required double actualWeight,
    String? proofImageUrl,
  }) async {
    isUpdatingStatus = true;
    errorMessage = null;
    successMessage = null;

    try {
      final result = await _repository.completePickup(
        pickupId: pickupId,
        actualWeight: actualWeight,
        proofImageUrl: proofImageUrl,
      );

      return result.fold(
        (failure) {
          errorMessage = _getHumanizedError(failure.message);
          return false;
        },
        (pickup) {
          selectedPickup = pickup;
          successMessage = 'Pickup completed successfully!';
          return true;
        },
      );
    } catch (e) {
      errorMessage = _getHumanizedError(e.toString());
      return false;
    } finally {
      isUpdatingStatus = false;
    }
  }

  @action
  void addNewRequest(PickupRequest request) {
    // Add new request from WebSocket/FCM notification
    if (!pendingRequests.any((r) => r.id == request.id)) {
      pendingRequests.insert(0, request);
    }
  }

  @action
  void removeRequest(String pickupId) {
    pendingRequests.removeWhere((r) => r.id == pickupId);
  }

  @action
  void updateRequest(PickupRequest updatedRequest) {
    final index = pendingRequests.indexWhere((r) => r.id == updatedRequest.id);
    if (index != -1) {
      pendingRequests[index] = updatedRequest;
    }
    if (selectedPickup?.id == updatedRequest.id) {
      selectedPickup = updatedRequest;
    }
  }

  @action
  void clearMessages() {
    errorMessage = null;
    successMessage = null;
  }

  String _getHumanizedError(String technicalError) {
    if (technicalError.contains('500') || technicalError.contains('Internal Server Error')) {
      return 'Our servers are having a bit of trouble right now. Please try again in a moment.';
    } else if (technicalError.contains('401') || technicalError.contains('Unauthorized')) {
      return 'Your session has expired. Please log in again to continue.';
    } else if (technicalError.contains('403') || technicalError.contains('Forbidden')) {
      return 'You don\'t have permission to access this feature.';
    } else if (technicalError.contains('404') || technicalError.contains('Not Found')) {
      return 'This pickup request could not be found. It may have been cancelled.';
    } else if (technicalError.contains('timeout') || technicalError.contains('TimeoutException')) {
      return 'The connection is taking too long. Please check your internet connection and try again.';
    } else if (technicalError.contains('network') || technicalError.contains('SocketException')) {
      return 'Unable to connect to our servers. Please check your internet connection.';
    } else if (technicalError.contains('DioException')) {
      return 'Having trouble connecting to our servers. Please try again.';
    } else {
      return 'Something unexpected happened. Please try again.';
    }
  }
}
