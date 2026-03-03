import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/pickup/data/services/pickup_websocket_service.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/features/pickup/presentation/mobx/pickup_store.dart';
import 'package:recliq_agent/features/pickup/presentation/widgets/pickup_status_timeline.dart';
import 'package:recliq_agent/features/pickup/presentation/widgets/tracking_map_widget.dart';
import 'package:recliq_agent/features/pickup/presentation/widgets/pickup_location_bottom_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class PickupDetailPage extends StatefulWidget {
  final String pickupId;

  const PickupDetailPage({
    super.key,
    required this.pickupId,
  });

  @override
  State<PickupDetailPage> createState() => _PickupDetailPageState();
}

class _PickupDetailPageState extends State<PickupDetailPage> {
  final _store = getIt<PickupStore>();
  final _wsService = getIt<PickupWebSocketService>();
  
  StreamSubscription<PickupRequest>? _statusUpdateSub;
  StreamSubscription<String>? _cancelledSub;

  @override
  void initState() {
    super.initState();
    _store.loadPickupDetails(widget.pickupId);
    _setupWebSocketListeners();
  }

  void _setupWebSocketListeners() {
    _statusUpdateSub = _wsService.onStatusUpdate.listen((request) {
      if (request.id == widget.pickupId) {
        _store.loadPickupDetails(widget.pickupId);
      }
    });

    _cancelledSub = _wsService.onCancelled.listen((pickupId) {
      if (pickupId == widget.pickupId && mounted) {
        _showCancelledDialog();
      }
    });
  }

  
  void _showCancelledDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Pickup Cancelled',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: const Text(
          'This pickup has been cancelled by the customer.',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _statusUpdateSub?.cancel();
    _cancelledSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: const PageAppBar(
        title: 'Pickup Details',
      ),
      body: Observer(
        builder: (_) {
          if (_store.errorMessage != null && _store.selectedPickup == null) {
            return _buildErrorState();
          }

          return LoadingOverlay(
            isVisible: _store.isLoading && _store.selectedPickup == null,
            message: 'Loading details...',
            child: _store.selectedPickup == null
                ? const SizedBox.shrink()
                : _buildContent(),
          );
        },
      ),
      bottomNavigationBar: Observer(
        builder: (_) {
          if (_store.selectedPickup == null) return const SizedBox.shrink();
          return _buildBottomActions();
        },
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.cloud_off_rounded,
                size: 48,
                color: AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _store.errorMessage!,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => context.pop(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textSecondary,
                    side: const BorderSide(color: AppTheme.borderSoft),
                  ),
                  child: const Text('Go Back'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => _store.loadPickupDetails(widget.pickupId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final pickup = _store.selectedPickup!;
    
    return RefreshIndicator(
      onRefresh: () => _store.loadPickupDetails(widget.pickupId),
      color: AppTheme.primaryGreen,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(pickup),
            const SizedBox(height: 16),
            _buildCustomerCard(pickup),
            const SizedBox(height: 16),
            _buildPickupDetailsCard(pickup),
            const SizedBox(height: 16),
            if (pickup.status == PickupStatus.assigned ||
                pickup.status == PickupStatus.agentEnRoute)
              _buildTrackingCard(pickup),
            if (pickup.matchingTimeline.isNotEmpty) ...[
              const SizedBox(height: 16),
              PickupStatusTimeline(events: pickup.matchingTimeline),
            ],
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(PickupRequest pickup) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getStatusColor(pickup.status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getStatusColor(pickup.status).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getStatusColor(pickup.status).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getStatusIcon(pickup.status),
              color: _getStatusColor(pickup.status),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatStatus(pickup.status),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _getStatusColor(pickup.status),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getStatusDescription(pickup.status),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(PickupRequest pickup) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    (pickup.userName ?? 'C')[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pickup.userName ?? 'Customer',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    if (pickup.userPhone != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        pickup.userPhone!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (pickup.userPhone != null) ...[
                IconButton(
                  onPressed: () => _callCustomer(pickup.userPhone!),
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                IconButton(
                  onPressed: () => _messageCustomer(pickup.userPhone!),
                  icon: const Icon(
                    Icons.message_outlined,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPickupDetailsCard(PickupRequest pickup) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pickup Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Waste Type', _formatWasteType(pickup.wasteType)),
          _buildDetailRow('Estimated Weight', '${pickup.estimatedWeight} kg'),
          _buildDetailRow(
            'Payout',
            '${pickup.pricing?.currency ?? 'NGN'} ${pickup.pricing?.totalAmount.toStringAsFixed(0) ?? '0'}',
          ),
          _buildDetailRow('Mode', pickup.pickupMode == PickupMode.pickup ? 'Pickup' : 'Dropoff'),
          const Divider(color: AppTheme.borderSoft, height: 24),
          _buildAddressRow(pickup),
          if (pickup.notes != null && pickup.notes!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildNotesRow(pickup.notes!),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressRow(PickupRequest pickup) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on_outlined,
          size: 20,
          color: AppTheme.primaryGreen,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pickup.address ?? 'No address provided',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
              ),
              if (pickup.coordinates != null) ...[
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => PickupLocationBottomSheet.show(context, pickup),
                  child: const Text(
                    'View on Map',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotesRow(String notes) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.darkBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.note_outlined,
            size: 18,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              notes,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingCard(PickupRequest pickup) {

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Live Tracking',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: Observer(
              builder: (_) => TrackingMapWidget(
                pickupId: widget.pickupId,
                pickupCoordinates: pickup.coordinates,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    final pickup = _store.selectedPickup!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        border: Border(
          top: BorderSide(color: AppTheme.borderSoft),
        ),
      ),
      child: SafeArea(
        child: Observer(
          builder: (_) {
            if (_store.isUpdatingStatus) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                ),
              );
            }

            return _buildActionButton(pickup);
          },
        ),
      ),
    );
  }

  Widget _buildActionButton(PickupRequest pickup) {
    switch (pickup.status) {
      case PickupStatus.pendingAcceptance:
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showDeclineDialog(pickup),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.errorColor,
                  side: const BorderSide(color: AppTheme.errorColor),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Decline'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () => _handleAccept(pickup),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Accept Pickup'),
              ),
            ),
          ],
        );

      case PickupStatus.assigned:
        return ElevatedButton(
          onPressed: () => _updateStatus('agent_en_route'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: const Text('Start Navigation'),
        );

      case PickupStatus.agentEnRoute:
        return ElevatedButton(
          onPressed: () => _updateStatus('arrived'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: const Text('I\'ve Arrived'),
        );

      case PickupStatus.arrived:
        return ElevatedButton(
          onPressed: () => _showCompleteDialog(pickup),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            minimumSize: const Size(double.infinity, 48),
          ),
          child: const Text('Complete Pickup'),
        );

      case PickupStatus.completed:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: AppTheme.successColor),
              SizedBox(width: 8),
              Text(
                'Pickup Completed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.successColor,
                ),
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _handleAccept(PickupRequest pickup) async {
    final success = await _store.acceptPickup(pickupId: pickup.id);
    if (success && mounted) {
      HapticFeedback.mediumImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.successMessage ?? 'Pickup accepted!'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    } else if (_store.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.errorMessage!),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  Future<void> _updateStatus(String status) async {
    final success = await _store.updateStatus(
      pickupId: widget.pickupId,
      status: status,
    );
    if (!success && _store.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.errorMessage!),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  void _showDeclineDialog(PickupRequest pickup) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Decline Pickup',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please provide a reason for declining:',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              maxLines: 3,
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                hintText: 'e.g., Too far from current location',
                hintStyle: TextStyle(color: AppTheme.textSecondary.withOpacity(0.5)),
                filled: true,
                fillColor: AppTheme.darkBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.borderSoft),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (reasonController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please provide a reason'),
                    backgroundColor: AppTheme.errorColor,
                  ),
                );
                return;
              }

              Navigator.pop(context);
              final success = await _store.declinePickup(
                pickupId: pickup.id,
                reason: reasonController.text.trim(),
              );

              if (success && mounted) {
                context.pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Decline'),
          ),
        ],
      ),
    );
  }

  void _showCompleteDialog(PickupRequest pickup) {
    final weightController = TextEditingController(
      text: pickup.estimatedWeight.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text(
          'Complete Pickup',
          style: TextStyle(color: AppTheme.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter the actual weight collected:',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: AppTheme.textPrimary),
              decoration: InputDecoration(
                suffixText: 'kg',
                suffixStyle: const TextStyle(color: AppTheme.textSecondary),
                filled: true,
                fillColor: AppTheme.darkBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.borderSoft),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              final weight = double.tryParse(weightController.text);
              if (weight == null || weight <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid weight'),
                    backgroundColor: AppTheme.errorColor,
                  ),
                );
                return;
              }

              Navigator.pop(context);
              final success = await _store.completePickup(
                pickupId: pickup.id,
                actualWeight: weight,
              );

              if (success && mounted) {
                HapticFeedback.heavyImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_store.successMessage ?? 'Pickup completed!'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
            ),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
  }

  Future<void> _callCustomer(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _messageCustomer(String phone) async {
    final uri = Uri.parse('sms:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  
  Color _getStatusColor(PickupStatus status) {
    switch (status) {
      case PickupStatus.pendingAcceptance:
        return AppTheme.warningColor;
      case PickupStatus.assigned:
        return AppTheme.primaryGreen;
      case PickupStatus.agentEnRoute:
        return Colors.blue;
      case PickupStatus.arrived:
        return Colors.purple;
      case PickupStatus.completed:
        return AppTheme.successColor;
      case PickupStatus.cancelled:
      case PickupStatus.failed:
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getStatusIcon(PickupStatus status) {
    switch (status) {
      case PickupStatus.pendingAcceptance:
        return Icons.hourglass_empty;
      case PickupStatus.assigned:
        return Icons.assignment_turned_in;
      case PickupStatus.agentEnRoute:
        return Icons.directions_car;
      case PickupStatus.arrived:
        return Icons.location_on;
      case PickupStatus.completed:
        return Icons.check_circle;
      case PickupStatus.cancelled:
        return Icons.cancel;
      case PickupStatus.failed:
        return Icons.error;
      default:
        return Icons.info;
    }
  }

  String _formatStatus(PickupStatus status) {
    switch (status) {
      case PickupStatus.newRequest:
        return 'New Request';
      case PickupStatus.matching:
        return 'Finding Agent';
      case PickupStatus.pendingAcceptance:
        return 'Awaiting Your Response';
      case PickupStatus.assigned:
        return 'Assigned to You';
      case PickupStatus.agentEnRoute:
        return 'On Your Way';
      case PickupStatus.arrived:
        return 'You\'ve Arrived';
      case PickupStatus.completed:
        return 'Completed';
      case PickupStatus.cancelled:
        return 'Cancelled';
      case PickupStatus.failed:
        return 'Failed';
    }
  }

  String _getStatusDescription(PickupStatus status) {
    switch (status) {
      case PickupStatus.pendingAcceptance:
        return 'Review the details and accept or decline this pickup';
      case PickupStatus.assigned:
        return 'Start navigation to the pickup location';
      case PickupStatus.agentEnRoute:
        return 'Customer is waiting for your arrival';
      case PickupStatus.arrived:
        return 'Collect the waste and complete the pickup';
      case PickupStatus.completed:
        return 'This pickup has been successfully completed';
      case PickupStatus.cancelled:
        return 'This pickup was cancelled';
      default:
        return '';
    }
  }

  String _formatWasteType(WasteType type) {
    switch (type) {
      case WasteType.plastic:
        return 'Plastic';
      case WasteType.paper:
        return 'Paper';
      case WasteType.metal:
        return 'Metal';
      case WasteType.glass:
        return 'Glass';
      case WasteType.organic:
        return 'Organic';
      case WasteType.eWaste:
        return 'E-Waste';
      case WasteType.mixed:
        return 'Mixed';
    }
  }
}
