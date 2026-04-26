import 'package:flutter/material.dart';
import '../color_manager.dart';

class RadioGroupOption<T> {
  final T value;
  final String label;

  RadioGroupOption({required this.value, required this.label});
}

class RadioGroup<T> extends StatefulWidget {
  final List<RadioGroupOption<T>> options;
  final List<T>? initialValues;
  final bool isMultipleChoice;
  final void Function(List<T> selectedValues)? onChanged;

  const RadioGroup({
    super.key,
    required this.options,
    this.initialValues,
    this.isMultipleChoice = false,
    this.onChanged,
  });

  @override
  State<RadioGroup<T>> createState() => _RadioGroupState<T>();
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  late List<T> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = List<T>.from(widget.initialValues ?? []);
  }

  @override
  void didUpdateWidget(RadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValues != oldWidget.initialValues) {
      _selectedValues = List<T>.from(widget.initialValues ?? []);
    }
  }

  void _handleSelect(T value) {
    setState(() {
      if (widget.isMultipleChoice) {
        if (_selectedValues.contains(value)) {
          _selectedValues.remove(value);
        } else {
          _selectedValues.add(value);
        }
      } else {
        _selectedValues = [value];
      }
    });
    widget.onChanged?.call(_selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        final isSelected = _selectedValues.contains(option.value);
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? ColorManager.primeColor.withValues(alpha: 0.05) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? ColorManager.primeColor : ColorManager.whiteBlueColor,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: ColorManager.primeColor.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ] : null,
            ),
            child: InkWell(
              onTap: () => _handleSelect(option.value),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Custom Radio/Checkbox Indicator
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: widget.isMultipleChoice ? BoxShape.rectangle : BoxShape.circle,
                        borderRadius: widget.isMultipleChoice ? BorderRadius.circular(6) : null,
                        border: Border.all(
                          color: isSelected ? ColorManager.primeColor : ColorManager.hintColor,
                          width: 2,
                        ),
                        color: isSelected ? ColorManager.primeColor : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Center(
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    // Label
                    Expanded(
                      child: Text(
                        option.label,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? ColorManager.primeColor : ColorManager.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
