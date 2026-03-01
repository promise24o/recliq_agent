import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class CustomSearchableDropdown<T> extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) displayText;
  final String Function(T) searchFilter;
  final Function(T?) onChanged;
  final String? errorText;
  final bool enabled;
  final Widget? leadingIcon;

  const CustomSearchableDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.items,
    this.selectedItem,
    required this.displayText,
    required this.searchFilter,
    required this.onChanged,
    this.errorText,
    this.enabled = true,
    this.leadingIcon,
  });

  @override
  State<CustomSearchableDropdown<T>> createState() =>
      _CustomSearchableDropdownState<T>();
}

class _CustomSearchableDropdownState<T>
    extends State<CustomSearchableDropdown<T>> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isDropdownOpen = false;
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where((item) => widget
              .searchFilter(item)
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
      if (_isDropdownOpen) {
        _focusNode.requestFocus();
        _searchController.clear();
        _filteredItems = widget.items;
      } else {
        _focusNode.unfocus();
        _searchController.clear();
      }
    });
  }

  void _selectItem(T item) {
    widget.onChanged(item);
    _toggleDropdown();
  }

  void _clearSelection() {
    widget.onChanged(null);
    _toggleDropdown();
  }

  Color get _disabledFillColor => AppTheme.surfaceDark.withOpacity(0.55);
  Color get _disabledBorderColor => AppTheme.primaryGreen.withOpacity(0.25);
  Color get _disabledIconColor => AppTheme.primaryGreen.withOpacity(0.4);
  Color get _disabledTextColor => Colors.white.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: hasError ? Colors.redAccent : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _toggleDropdown,
          child: AbsorbPointer(
            absorbing: false,
            child: Container(
              decoration: BoxDecoration(
                color:
                    widget.enabled ? AppTheme.surfaceDark : _disabledFillColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: hasError
                      ? Colors.redAccent
                      : widget.enabled
                          ? (_isFocused
                              ? AppTheme.primaryGreen
                              : Colors.white24)
                          : _disabledBorderColor,
                  width: _isFocused ? 1.2 : 1.0,
                ),
              ),
              child: Column(
                children: [
                  // Selected item display
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        if (widget.leadingIcon != null) ...[
                          widget.leadingIcon!,
                          const SizedBox(width: 12),
                        ],
                        Icon(
                          widget.icon,
                          color: hasError
                              ? Colors.redAccent
                              : widget.enabled
                                  ? (_isFocused
                                      ? AppTheme.primaryGreen
                                      : Colors.white54)
                                  : _disabledIconColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.selectedItem != null
                                ? widget.displayText(widget.selectedItem!)
                                : widget.hint,
                            style: TextStyle(
                              color: widget.selectedItem != null
                                  ? (widget.enabled
                                      ? Colors.white
                                      : _disabledTextColor)
                                  : (widget.enabled
                                      ? Colors.white38
                                      : Colors.white24),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (widget.selectedItem != null && widget.enabled)
                          GestureDetector(
                            onTap: _clearSelection,
                            child: Icon(
                              Icons.clear,
                              color: Colors.white54,
                              size: 20,
                            ),
                          ),
                        Icon(
                          _isDropdownOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: widget.enabled
                              ? Colors.white54
                              : _disabledIconColor,
                        ),
                      ],
                    ),
                  ),
                  // Dropdown list
                  if (_isDropdownOpen) ...[
                    Container(
                      height: 1,
                      color: Colors.white24,
                    ),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Column(
                        children: [
                          // Search field
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                hintStyle:
                                    const TextStyle(color: Colors.white38),
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.white54),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.05),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.white24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.white24),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: AppTheme.primaryGreen),
                                ),
                              ),
                              onChanged: _filterItems,
                            ),
                          ),
                          // Items list
                          Expanded(
                            child: _filteredItems.isEmpty
                                ? Container(
                                    padding: const EdgeInsets.all(16),
                                    child: const Text(
                                      'No items found',
                                      style: TextStyle(color: Colors.white38),
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _filteredItems.length,
                                    itemBuilder: (context, index) {
                                      final item = _filteredItems[index];
                                      final isSelected =
                                          widget.selectedItem == item;

                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => _selectItem(item),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppTheme.primaryGreen
                                                      .withOpacity(0.1)
                                                  : Colors.transparent,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    widget.displayText(item),
                                                    style: TextStyle(
                                                      color: isSelected
                                                          ? AppTheme
                                                              .primaryGreen
                                                          : Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                if (isSelected)
                                                  Icon(
                                                    Icons.check,
                                                    color:
                                                        AppTheme.primaryGreen,
                                                    size: 20,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            widget.errorText!,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
