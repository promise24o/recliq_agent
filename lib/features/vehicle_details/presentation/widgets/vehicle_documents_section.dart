import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:recliq_agent/core/di/injection.dart';
import 'package:recliq_agent/features/vehicle_details/domain/entities/vehicle_details.dart' as vehicle;
import 'package:recliq_agent/features/vehicle_details/presentation/mobx/vehicle_details_store.dart';
import 'package:recliq_agent/shared/themes/app_theme.dart';
import 'package:recliq_agent/shared/widgets/loading_overlay.dart';
import 'vehicle_document_item.dart';

class VehicleDocumentsSection extends StatelessWidget {
  final List<vehicle.VehicleDocument> documents;
  final vehicle.VehicleStatus vehicleStatus;

  const VehicleDocumentsSection({
    super.key,
    required this.documents,
    required this.vehicleStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing20),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        border: Border.all(color: AppTheme.borderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: AppTheme.primaryGreen,
                    size: 20,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  const Text(
                    'Documents',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              if (_canUploadDocument())
                TextButton.icon(
                  onPressed: () => _showUploadBottomSheet(context),
                  icon: const Icon(Icons.add_outlined, size: 18),
                  label: const Text('Upload'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primaryGreen,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing12,
                      vertical: AppTheme.spacing8,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          VehicleDocumentList(documents: documents),
        ],
      ),
    );
  }

  bool _canUploadDocument() {
    return vehicleStatus == vehicle.VehicleStatus.pending ||
           vehicleStatus == vehicle.VehicleStatus.rejected;
  }

  void _showUploadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const DocumentUploadBottomSheet(),
    );
  }
}

class VehicleDocumentList extends StatelessWidget {
  final List<vehicle.VehicleDocument> documents;

  const VehicleDocumentList({
    super.key,
    required this.documents,
  });

  @override
  Widget build(BuildContext context) {
    if (documents.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppTheme.spacing20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(color: AppTheme.borderSoft),
        ),
        child: Row(
          children: [
            Icon(
              Icons.folder_open_outlined,
              color: AppTheme.textTertiary,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacing12),
            const Text(
              'No documents uploaded yet',
              style: TextStyle(
                color: AppTheme.textTertiary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: documents.map((document) {
        return VehicleDocumentItem(document: document);
      }).toList(),
    );
  }
}

class DocumentUploadBottomSheet extends StatefulWidget {
  const DocumentUploadBottomSheet({super.key});

  @override
  State<DocumentUploadBottomSheet> createState() => _DocumentUploadBottomSheetState();
}

class _DocumentUploadBottomSheetState extends State<DocumentUploadBottomSheet> {
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
        
        // Reset form state
        setState(() {
          _selectedDocumentType = 'registration';
          _selectedFile = null;
        });
        
        // Close bottom sheet and refresh
        Navigator.of(context).pop();
        
        // Wait a bit for the bottom sheet to close, then refresh
        Future.delayed(const Duration(milliseconds: 300), () {
          _store.loadVehicleDetails();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload document: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.darkBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radius20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: AppTheme.spacing12),
            decoration: BoxDecoration(
              color: AppTheme.borderSoft,
              borderRadius: BorderRadius.circular(AppTheme.radius4),
            ),
          ),
          const SizedBox(height: AppTheme.spacing20),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.upload_file_outlined,
                    color: AppTheme.primaryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppTheme.spacing16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload Document',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      SizedBox(height: AppTheme.spacing4),
                      Text(
                        'Add a new document to your vehicle profile',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_outlined),
                  color: AppTheme.textTertiary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing24),
          
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Document Type Selection
                  const Text(
                    'Document Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  ..._documentTypes.map((type) {
                    final isSelected = _selectedDocumentType == type['value'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDocumentType = type['value']!;
                        });
                      },
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
                                ? AppTheme.primaryGreen
                                : AppTheme.borderSoft,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.description_outlined,
                              color: isSelected 
                                  ? AppTheme.primaryGreen
                                  : AppTheme.textTertiary,
                              size: 20,
                            ),
                            const SizedBox(width: AppTheme.spacing12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    type['label']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected 
                                          ? AppTheme.primaryGreen
                                          : AppTheme.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: AppTheme.spacing4),
                                  Text(
                                    type['description']!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: AppTheme.primaryGreen,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // File Selection
                  const Text(
                    'Select Document',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing12),
                  
                  if (_selectedFile != null)
                    Container(
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
                              color: AppTheme.successColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radius8),
                            ),
                            child: const Icon(
                              Icons.check_circle,
                              color: AppTheme.successColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacing12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Document Selected',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacing4),
                                Text(
                                  _selectedFile!.path.split('/').last,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedFile = null;
                              });
                            },
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: _pickDocument,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppTheme.spacing20),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(AppTheme.radius12),
                          border: Border.all(
                            color: AppTheme.primaryGreen.withValues(alpha: 0.5),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: AppTheme.primaryGreen.withValues(alpha: 0.7),
                              size: 40,
                            ),
                            const SizedBox(height: AppTheme.spacing12),
                            Text(
                              'Tap to select document',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryGreen.withValues(alpha: 0.8),
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacing4),
                            const Text(
                              'Supports: JPG, PNG, PDF (Max 10MB)',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  const SizedBox(height: AppTheme.spacing32),
                  
                  // Upload Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (_isUploading || _selectedFile == null) 
                          ? null 
                          : _handleUploadDocument,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radius12),
                        ),
                      ),
                      child: _isUploading
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                SizedBox(width: AppTheme.spacing12),
                                Text('Uploading...'),
                              ],
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
                  
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  } 
}
