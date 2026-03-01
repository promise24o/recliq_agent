import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/presentation/mobx/vehicle_details_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';

class VehicleDocumentUploadPage extends StatefulWidget {
  const VehicleDocumentUploadPage({super.key});

  @override
  State<VehicleDocumentUploadPage> createState() => _VehicleDocumentUploadPageState();
}

class _VehicleDocumentUploadPageState extends State<VehicleDocumentUploadPage> {
  final VehicleDetailsStore _store = getIt<VehicleDetailsStore>();
  final ImagePicker _imagePicker = ImagePicker();
  String _selectedDocumentType = 'registration';
  File? _selectedFile;
  bool _isUploading = false;

  final List<Map<String, String>> _documentTypes = [
    {
      'value': 'registration',
      'label': 'Vehicle Registration Certificate',
      'description': 'Official vehicle registration document',
    },
    {
      'value': 'insurance',
      'label': 'Vehicle Insurance Certificate',
      'description': 'Valid insurance coverage document',
    },
    {
      'value': 'roadworthiness',
      'label': 'Roadworthiness Certificate',
      'description': 'Vehicle roadworthiness test certificate',
    },
    {
      'value': 'inspection_certificate',
      'label': 'Inspection Certificate',
      'description': 'Vehicle inspection compliance certificate',
    },
  ];

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickDocument() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        title: const Text('Upload Documents'),
        backgroundColor: AppTheme.darkBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppTheme.textPrimary),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              '/shell/profile',
              (route) => false,
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          return LoadingOverlay(
            isVisible: _isUploading,
            message: 'Uploading document...',
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Success message
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.successColor.withValues(alpha: 0.1),
                          AppTheme.successColor.withValues(alpha: 0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radius16),
                      border: Border.all(
                        color: AppTheme.successColor.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppTheme.spacing12),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            size: 48,
                            color: AppTheme.successColor,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacing16),
                        const Text(
                          'Vehicle Details Added!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacing8),
                        const Text(
                          'Your vehicle has been registered. Upload documents to verify your account and unlock enterprise jobs.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing32),

                  // Upload section
                  const Text(
                    'Upload Required Documents',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  const Text(
                    'Verified documents help you access higher-paying jobs and build trust with clients.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing32),

                  // Document type dropdown
                  const Text(
                    'Document Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                      border: Border.all(color: AppTheme.borderSoft),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDocumentType,
                        isExpanded: true,
                        items: _documentTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type['value'],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  type['label']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                Text(
                                  type['description']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedDocumentType = value!;
                            _selectedFile = null; // Reset file when document type changes
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),

                  // Document file selection
                  const Text(
                    'Document File',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                      border: Border.all(
                        color: _selectedFile != null 
                            ? AppTheme.primaryGreen.withValues(alpha: 0.5) 
                            : AppTheme.borderSoft,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _selectedFile != null 
                                  ? Icons.check_circle_outline 
                                  : Icons.description_outlined,
                              color: _selectedFile != null 
                                  ? AppTheme.primaryGreen 
                                  : AppTheme.textSecondary,
                              size: 24,
                            ),
                            const SizedBox(width: AppTheme.spacing12),
                            const Text(
                              'Select Document File',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        if (_selectedFile != null) ...[
                          const SizedBox(height: AppTheme.spacing16),
                          Container(
                            padding: const EdgeInsets.all(AppTheme.spacing12),
                            decoration: BoxDecoration(
                              color: AppTheme.darkBackground,
                              borderRadius: BorderRadius.circular(AppTheme.radius8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.image_outlined,
                                  color: AppTheme.textSecondary,
                                  size: 20,
                                ),
                                const SizedBox(width: AppTheme.spacing8),
                                Expanded(
                                  child: Text(
                                    _selectedFile!.path.split('/').last,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textSecondary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedFile = null;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: AppTheme.errorColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          const SizedBox(height: AppTheme.spacing16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: _isUploading ? null : _pickDocument,
                              icon: const Icon(Icons.cloud_upload_outlined),
                              label: const Text('Choose File'),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppTheme.primaryGreen),
                                foregroundColor: AppTheme.primaryGreen,
                                padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  Text(
                    'Supported formats: JPG, PNG, PDF. Maximum file size: 10MB',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing32),

                  // Upload button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isUploading ? null : _handleUploadDocument,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
                      ),
                      child: _isUploading
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
                  ),
                  const SizedBox(height: AppTheme.spacing16),

                  // Skip for now button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppTheme.borderSoft),
                        foregroundColor: AppTheme.textSecondary,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
                      ),
                      child: const Text(
                        'Skip for Now',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Existing documents section
                  if (_store.vehicleDetails?.documents.isNotEmpty == true) ...[
                    const SizedBox(height: AppTheme.spacing32),
                    const Text(
                      'Uploaded Documents',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing16),
                    ...(_store.vehicleDetails!.documents.map((doc) => _buildDocumentItem(doc))),
                    const SizedBox(height: 100),

                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDocumentItem(vehicle.VehicleDocument document) {
    final documentType = _documentTypes.firstWhere(
      (type) => type['value'] == document.documentType.name,
      orElse: () => {'label': document.documentType.name, 'description': ''},
    );
    
    final status = document.status.name;
    final statusColor = status == 'verified' 
        ? AppTheme.successColor 
        : status == 'rejected' 
            ? AppTheme.errorColor 
            : AppTheme.warningColor;
    
    final statusIcon = status == 'verified' 
        ? Icons.verified_outlined 
        : status == 'rejected' 
            ? Icons.close_outlined 
            : Icons.pending_outlined;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing12),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing8),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius8),
            ),
            child: Icon(
              statusIcon,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  documentType['label']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                if (documentType['description']!.isNotEmpty) ...[
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    documentType['description']!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  'Status: ${status.toUpperCase()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (status == 'rejected')
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedDocumentType = document.documentType.name;
                  _selectedFile = null;
                });
              },
              icon: const Icon(
                Icons.refresh_outlined,
                color: AppTheme.primaryGreen,
              ),
              tooltip: 'Re-upload',
            ),
        ],
      ),
    );
  }

  Future<void> _handleUploadDocument() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a document file'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final success = await _store.uploadVehicleDocument(
        documentType: _selectedDocumentType,
        document: _selectedFile!,
      );
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document uploaded successfully!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
        
        // Navigate back to previous page
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_store.errorMessage ?? 'Failed to upload document'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }
}
