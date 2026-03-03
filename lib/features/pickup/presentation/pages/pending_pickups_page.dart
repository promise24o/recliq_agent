import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/core/services/sound_service.dart';
import 'package:recliq_agent/features/pickup/data/services/pickup_websocket_service.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/features/pickup/presentation/mobx/pickup_store.dart';
import 'package:recliq_agent/features/pickup/presentation/widgets/pickup_request_card.dart';
import 'package:recliq_agent/features/pickup/presentation/widgets/pickup_request_bottom_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/app_bar.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class PendingPickupsPage extends StatefulWidget {
  const PendingPickupsPage({super.key});

  @override
  State<PendingPickupsPage> createState() => _PendingPickupsPageState();
}

class _PendingPickupsPageState extends State<PendingPickupsPage> {
  final _store = getIt<PickupStore>();
  final _wsService = getIt<PickupWebSocketService>();
  final _soundService = getIt<SoundService>();
  
  StreamSubscription<PickupRequest>? _newRequestSub;
  StreamSubscription<PickupRequest>? _statusUpdateSub;
  StreamSubscription<String>? _cancelledSub;

  @override
  void initState() {
    super.initState();
    _store.loadPendingRequests();
    _setupWebSocketListeners();
  }

  void _setupWebSocketListeners() {
    _wsService.connect();
    
    _newRequestSub = _wsService.onNewRequest.listen((request) {
      _store.addNewRequest(request);
      _showNewRequestNotification(request);
    });

    _statusUpdateSub = _wsService.onStatusUpdate.listen((request) {
      _store.updateRequest(request);
    });

    _cancelledSub = _wsService.onCancelled.listen((pickupId) {
      _store.removeRequest(pickupId);
      _showCancelledNotification();
    });
  }

  void _showNewRequestNotification(PickupRequest request) {
    if (!mounted) return;
    
    // Play alert sound 4 times like Bolt
    _soundService.playAlertSound(repeatCount: 4);
    
    // Show bottom sheet with pickup details
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PickupRequestBottomSheet(
        request: request,
        onAccept: () {
          Navigator.of(context).pop();
          _navigateToDetail(request);
        },
        onDecline: () {
          Navigator.of(context).pop();
          // Optionally handle decline action
        },
        onClose: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _showCancelledNotification() {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('A pickup request was cancelled'),
        backgroundColor: AppTheme.warningColor,
      ),
    );
  }

  void _navigateToDetail(PickupRequest request) {
    context.push('/pickup/${request.id}');
  }

  @override
  void dispose() {
    _newRequestSub?.cancel();
    _statusUpdateSub?.cancel();
    _cancelledSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: const PageAppBar(
        title: 'Pickup Requests',
      ),
      body: Observer(
        builder: (_) {
          if (_store.errorMessage != null && _store.pendingRequests.isEmpty) {
            return _buildErrorState();
          }

          return LoadingOverlay(
            isVisible: _store.isLoading && _store.pendingRequests.isEmpty,
            message: 'Loading requests...',
            child: SizedBox.expand(
              child: RefreshIndicator(
                onRefresh: () => _store.loadPendingRequests(),
                color: AppTheme.primaryGreen,
                child: _store.pendingRequests.isEmpty && !_store.isLoading
                    ? _buildEmptyState()
                    : _buildRequestsList(),
              ),
            ),
          );
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
            ElevatedButton(
              onPressed: () => _store.loadPendingRequests(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.inbox_rounded,
                  size: 64,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'No Pending Requests',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 48),
                child: Text(
                  'New pickup requests will appear here. Stay online to receive requests!',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequestsList() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: _store.pendingRequests.length,
      itemBuilder: (context, index) {
        final request = _store.pendingRequests[index];
        return PickupRequestCard(
          request: request,
          onTap: () => _navigateToDetail(request),
          onAccept: () => _handleAccept(request),
          onDecline: () => _showDeclineDialog(request),
        );
      },
    );
  }

  Future<void> _handleAccept(PickupRequest request) async {
    final success = await _store.acceptPickup(pickupId: request.id);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.successMessage ?? 'Pickup accepted!'),
          backgroundColor: AppTheme.successColor,
        ),
      );
      context.push('/pickup/${request.id}');
    } else if (_store.errorMessage != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.errorMessage!),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  void _showDeclineDialog(PickupRequest request) {
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
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.borderSoft),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.primaryGreen),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          Observer(
            builder: (_) => ElevatedButton(
              onPressed: _store.isResponding
                  ? null
                  : () async {
                      if (reasonController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please provide a reason'),
                            backgroundColor: AppTheme.errorColor,
                          ),
                        );
                        return;
                      }
                      
                      final success = await _store.declinePickup(
                        pickupId: request.id,
                        reason: reasonController.text.trim(),
                      );
                      
                      if (mounted) {
                        Navigator.pop(context);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pickup declined'),
                              backgroundColor: AppTheme.warningColor,
                            ),
                          );
                        }
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
                foregroundColor: Colors.white,
              ),
              child: _store.isResponding
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Decline'),
            ),
          ),
        ],
      ),
    );
  }
}
