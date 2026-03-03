import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:recliq_agent/features/pickup/domain/entities/pickup_request.dart';
import 'package:recliq_agent/features/pickup/presentation/widgets/pickup_location_bottom_sheet.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';

class PickupRequestBottomSheet extends StatelessWidget {
  final PickupRequest request;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onClose;

  const PickupRequestBottomSheet({
    super.key,
    required this.request,
    this.onAccept,
    this.onDecline,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.darkBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: AppTheme.textSecondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.local_shipping_outlined,
                      color: AppTheme.primaryGreen,
                      size: 24.w,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Pickup Request',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'Tap to view details',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onClose ?? () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: AppTheme.textSecondary,
                      size: 24.w,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Customer Info
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderSoft),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: AppTheme.textSecondary,
                        size: 20.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Customer',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    request.userName ?? 'Customer',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Location Info
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderSoft),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppTheme.textSecondary,
                        size: 20.w,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Pickup Location',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    request.address ?? 'Address not provided',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (request.coordinates != null) ...[
                    SizedBox(height: 4.h),
                    GestureDetector(
                      onTap: () => PickupLocationBottomSheet.show(context, request),
                      child: Text(
                        'View on Map',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Pickup Details
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderSoft),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    icon: Icons.category_outlined,
                    label: 'Waste Type',
                    value: request.wasteType.name.toUpperCase(),
                  ),
                  SizedBox(height: 12.h),
                  _buildDetailRow(
                    icon: Icons.scale_outlined,
                    label: 'Est. Weight',
                    value: '${request.estimatedWeight}kg',
                  ),
                  SizedBox(height: 12.h),
                  _buildDetailRow(
                    icon: Icons.attach_money_outlined,
                    label: 'Amount',
                    value: '₦${request.pricing?.totalAmount.toStringAsFixed(0) ?? '0'}',
                    valueColor: AppTheme.primaryGreen,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onDecline ?? () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: const BorderSide(color: AppTheme.borderSoft),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Decline',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept ?? () {
                        Navigator.of(context).pop();
                        context.push('/pickup/${request.id}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppTheme.textSecondary,
          size: 20.w,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppTheme.textSecondary,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: valueColor ?? AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
