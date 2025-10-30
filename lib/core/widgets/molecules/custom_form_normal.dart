import 'package:clients_manager/core/widgets/atoms/custom_button_form.dart';
import 'package:clients_manager/core/widgets/atoms/custom_input_form.dart';
import 'package:flutter/material.dart';
import 'package:clients_manager/core/widgets/atoms/form_field_config.dart';

class CustomFormNormal extends StatefulWidget {
  final List<FormFieldConfig> fields;
  final void Function(Map<String, String> values) onSubmit;
  final String submitButtonText;
  final bool isLoading;
  final double fieldSpacing;
  final EdgeInsetsGeometry? padding;
  final Widget? messageWidget;

  const CustomFormNormal({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.submitButtonText = 'Enviar',
    this.isLoading = false,
    this.fieldSpacing = 16,
    this.padding,
    this.messageWidget,
  });

  @override
  State<CustomFormNormal> createState() => _CustomFormNormalState();
}

class _CustomFormNormalState extends State<CustomFormNormal> {
  final _formKey = GlobalKey<FormState>();
  late Map<String, TextEditingController> _controllers;
  late Map<String, FocusNode> _focusNodes;
  final Map<String, bool> _obscureTextMap = {};
  
  /// ✅ Variable para controlar si el botón está habilitado
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _controllers = {};
    _focusNodes = {};

    for (var field in widget.fields) {
      _controllers[field.id] = TextEditingController(
        text: field.initialValue ?? '',
      );
      _focusNodes[field.id] = FocusNode();

      if (field.type == FormFieldType.password) {
        _obscureTextMap[field.id] = true;
      }

      /// 🎧 Agregar listener a cada controller para detectar cambios
      _controllers[field.id]!.addListener(_validateForm);
    }

    /// ⚡ Validar al inicio (por si hay valores iniciales)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
  }

  @override
  void dispose() {
    /// 🧹 Remover listeners antes de dispose
    for (var controller in _controllers.values) {
      controller.removeListener(_validateForm);
      controller.dispose();
    }
    for (var focusNode in _focusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  /// 🔍 Validar el formulario completo
  /// Esta función se ejecuta cada vez que cambia algún campo
  void _validateForm() {
    bool isValid = true;

    // Revisar cada campo
    for (var field in widget.fields) {
      final controller = _controllers[field.id]!;
      final value = controller.text.trim();

      // Si el campo es requerido y está vacío, el form es inválido
      if (field.isRequired && value.isEmpty) {
        isValid = false;
        break;
      }

      // Si hay validador, ejecutarlo
      if (field.validator != null) {
        final error = field.validator!(value);
        if (error != null) {
          isValid = false;
          break;
        }
      }
    }

    // ⚡ Actualizar el estado solo si cambió
    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  void _handleSubmit() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final values = <String, String>{};
      _controllers.forEach((id, controller) {
        values[id] = controller.text.trim();
      });
      widget.onSubmit(values);
    }
  }

  Widget _buildField(FormFieldConfig config, int index) {
    final controller = _controllers[config.id]!;
    final focusNode = _focusNodes[config.id]!;
    final isLastField = index == widget.fields.length - 1;
    final textInputAction = config.textInputAction ??
        (isLastField ? TextInputAction.done : TextInputAction.next);

    return CustomInputForm(
      controller: controller,
      focusNode: focusNode,
      labelText: config.labelText,
      hintText: config.hintText,
      helperText: config.helperText,
      prefixIcon: config.prefixIcon,
      keyboardType: config.keyboardType,
      textInputAction: textInputAction,
      maxLines: config.maxLines,
      maxLength: config.maxLength,
      inputFormatters: config.inputFormatters,
      enabled: config.enabled && !widget.isLoading,
      obscureText: config.type == FormFieldType.password
          ? (_obscureTextMap[config.id] ?? true)
          : false,
      suffixIcon: config.type == FormFieldType.password
          ? IconButton(
              icon: Icon(
                _obscureTextMap[config.id] ?? true
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureTextMap[config.id] =
                      !(_obscureTextMap[config.id] ?? true);
                });
              },
            )
          : null,
      validator: config.validator,
      onFieldSubmitted: (_) {
        if (!isLastField) {
          final nextField = widget.fields[index + 1];
          _focusNodes[nextField.id]?.requestFocus();
        } else {
          _handleSubmit();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...widget.fields.asMap().entries.map((entry) {
              final index = entry.key;
              final config = entry.value;

              return Column(
                children: [
                  _buildField(config, index),
                  if (index < widget.fields.length - 1)
                    SizedBox(height: widget.fieldSpacing),
                ],
              );
            }).toList(),
            
            SizedBox(height: widget.fieldSpacing + 8),
            
            /// ✅ Botón ahora se habilita/deshabilita según validación
            CustomButtonForm.primary(
              text: widget.submitButtonText,
              isLoading: widget.isLoading,
              isEnabled: _isFormValid && !widget.isLoading, // ← AQUÍ está la magia
              onPressed: _handleSubmit,
            ),
            
            if (widget.messageWidget != null) ...[
              SizedBox(height: widget.fieldSpacing),
              widget.messageWidget!,
            ],
          ],
        ),
      ),
    );
  }
}