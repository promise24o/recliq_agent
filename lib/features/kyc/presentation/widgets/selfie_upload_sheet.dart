import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/themes/app_theme.dart';
import '../mobx/kyc_store.dart';

class SelfieUploadSheet extends StatefulWidget {
  final KycStore kycStore;
  final String userId;

  const SelfieUploadSheet({
    super.key,
    required this.kycStore,
    required this.userId,
  });

  @override
  State<SelfieUploadSheet> createState() => _SelfieUploadSheetState();
}

class _SelfieUploadSheetState extends State<SelfieUploadSheet> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: AppTheme.spacing16,
          right: AppTheme.spacing16,
          top: AppTheme.spacing16,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16 + 100, // Extra space for floating navbar
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.dividerColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppTheme.radius8),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppTheme.primaryGreen,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Selfie',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'Take a clear selfie for verification',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing24),

              // Instructions
              _buildInstructionsCard(),
              const SizedBox(height: AppTheme.spacing24),

              // Image upload area
              _buildImageUploadArea(),
              const SizedBox(height: AppTheme.spacing24),

              // Upload button
              if (_selectedImage != null) ...[
                _buildUploadButton(),
                const SizedBox(height: AppTheme.spacing16),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionsCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: AppTheme.primaryGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppTheme.primaryGreen,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              const Text(
                'Photo Guidelines',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildGuideline('Face should be clearly visible'),
          _buildGuideline('Good lighting and no shadows'),
          _buildGuideline('No sunglasses or masks'),
          _buildGuideline('Neutral expression recommended'),
        ],
      ),
    );
  }

  Widget _buildGuideline(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.spacing6, left: AppTheme.spacing8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacing24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: _selectedImage != null 
              ? AppTheme.primaryGreen.withValues(alpha: 0.3)
              : AppTheme.borderSoft,
        ),
      ),
      child: Column(
        children: [
          if (_selectedImage == null) ...[
            Icon(
              Icons.camera_alt_outlined,
              size: 48,
              color: AppTheme.textTertiary,
            ),
            const SizedBox(height: AppTheme.spacing16),
            const Text(
              'Take a selfie or choose from gallery',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            const Text(
              'JPG or PNG (max 10MB)',
              style: TextStyle(
                color: AppTheme.textTertiary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryGreen),
                      foregroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, size: 18),
                        SizedBox(width: AppTheme.spacing8),
                        Text('Take Photo'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryGreen),
                      foregroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_library, size: 18),
                        SizedBox(width: AppTheme.spacing8),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radius8),
              child: Image.file(
                _selectedImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: AppTheme.surfaceColor,
                    child: const Icon(
                      Icons.broken_image,
                      size: 48,
                      color: AppTheme.textTertiary,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            const Text(
              'Selfie captured successfully',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryGreen),
                      foregroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.refresh, size: 18),
                        SizedBox(width: AppTheme.spacing8),
                        Text('Retake'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryGreen),
                      foregroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo_library, size: 18),
                        SizedBox(width: AppTheme.spacing8),
                        Text('Choose Another'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.kycStore.isUploadingSelfie ? null : _handleUpload,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radius12),
          ),
        ),
        child: widget.kycStore.isUploadingSelfie
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Upload Selfie',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        
        // Check file size (10MB limit)
        final fileSize = await file.length();
        if (fileSize > 10 * 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Image size must be less than 10MB'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        setState(() {
          _selectedImage = file;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleUpload() async {
    if (_selectedImage == null) return;

    await widget.kycStore.uploadSelfie(
      widget.userId,
      _selectedImage!,
    );

    if (mounted) {
      if (widget.kycStore.successMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.kycStore.successMessage!),
            backgroundColor: AppTheme.primaryGreen,
          ),
        );
        Navigator.pop(context);
      } else if (widget.kycStore.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.kycStore.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
