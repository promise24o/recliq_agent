import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/themes/app_theme.dart';
import '../mobx/kyc_store.dart';

class DocumentUploadSheet extends StatefulWidget {
  final KycStore kycStore;
  final String userId;

  const DocumentUploadSheet({
    super.key,
    required this.kycStore,
    required this.userId,
  });

  @override
  State<DocumentUploadSheet> createState() => _DocumentUploadSheetState();
}

class _DocumentUploadSheetState extends State<DocumentUploadSheet> {
  String? _selectedDocumentType;
  XFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, String>> _documentTypes = [
    {'value': 'id_card', 'label': 'National ID Card', 'description': 'Government-issued ID card'},
    {'value': 'passport', 'label': 'Passport', 'description': 'International passport'},
    {'value': 'driver_license', 'label': 'Driver\'s License', 'description': 'Valid driver\'s license'},
  ];

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
                      Icons.description_outlined,
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
                          'Upload Document',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          'Upload your ID document for verification',
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

              // Document type selection
              const Text(
                'Document Type',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              ..._documentTypes.map((docType) => _buildDocumentTypeOption(docType)),
              const SizedBox(height: AppTheme.spacing24),

              // File upload area
              if (_selectedDocumentType != null) ...[
                _buildFileUploadArea(),
                const SizedBox(height: AppTheme.spacing24),
              ],

              // Upload button
              if (_selectedDocumentType != null && _selectedFile != null) ...[
                _buildUploadButton(),
                const SizedBox(height: AppTheme.spacing16),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentTypeOption(Map<String, String> docType) {
    final isSelected = _selectedDocumentType == docType['value'];
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedDocumentType = docType['value'];
          _selectedFile = null;
        });
      },
      borderRadius: BorderRadius.circular(AppTheme.radius12),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
        padding: const EdgeInsets.all(AppTheme.spacing16),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppTheme.primaryGreen.withValues(alpha: 0.1)
              : AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(
            color: isSelected 
                ? AppTheme.primaryGreen.withValues(alpha: 0.3)
                : AppTheme.borderSoft,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppTheme.primaryGreen : AppTheme.borderSoft,
                ),
                color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
              ),
              child: Center(
                child: Icon(
                  Icons.check,
                  size: 12,
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    docType['label']!,
                    style: TextStyle(
                      color: isSelected ? AppTheme.primaryGreen : AppTheme.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    docType['description']!,
                    style: const TextStyle(
                      color: AppTheme.textTertiary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileUploadArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacing24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: _selectedFile != null 
              ? AppTheme.primaryGreen.withValues(alpha: 0.3)
              : AppTheme.borderSoft,
        ),
      ),
      child: Column(
        children: [
          if (_selectedFile == null) ...[
            Icon(
              Icons.cloud_upload_outlined,
              size: 48,
              color: AppTheme.textTertiary,
            ),
            const SizedBox(height: AppTheme.spacing16),
            const Text(
              'Choose a file to upload',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            const Text(
              'JPG, PNG or PDF (max 10MB)',
              style: TextStyle(
                color: AppTheme.textTertiary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            OutlinedButton(
              onPressed: _pickFile,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryGreen),
                foregroundColor: AppTheme.primaryGreen,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing24,
                  vertical: AppTheme.spacing12,
                ),
              ),
              child: const Text('Browse Files'),
            ),
          ] else ...[
            Icon(
              Icons.description,
              size: 48,
              color: AppTheme.primaryGreen,
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              _selectedFile!.name,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Selected: ${_selectedFile!.name}',
              style: const TextStyle(
                color: AppTheme.textTertiary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            OutlinedButton(
              onPressed: _pickFile,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryGreen),
                foregroundColor: AppTheme.primaryGreen,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing24,
                  vertical: AppTheme.spacing12,
                ),
              ),
              child: const Text('Change File'),
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
        onPressed: widget.kycStore.isUploadingDocument ? null : _handleUpload,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radius12),
          ),
        ),
        child: widget.kycStore.isUploadingDocument
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'Upload Document',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        // Check file size (10MB limit)
        final fileSize = await pickedFile.length();
        if (fileSize > 10 * 1024 * 1024) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('File size must be less than 10MB'),
                backgroundColor: Colors.red,
              ),
            );
          }
          return;
        }

        setState(() {
          _selectedFile = pickedFile;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleUpload() async {
    if (_selectedFile == null || _selectedDocumentType == null) return;

    final file = _selectedFile!;
    if (file.path == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to access file'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final documentFile = File(file.path!);
    
    await widget.kycStore.uploadDocument(
      widget.userId,
      _selectedDocumentType!,
      documentFile,
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
