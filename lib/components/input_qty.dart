// From: https://github.com/pmatatias/input-quantity
// MIT License

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputQty extends StatefulWidget {
  /// maximum value input
  /// default  [maxVal] = [num.maxFinite],
  final num maxVal;

  /// intial value
  /// default [initVal] = 0
  /// To show decimal number, set [initVal] with decimal format
  /// eg: [initVal] = 0.0
  ///
  final num initVal;

  /// minimum value
  /// default [minVal] = 0
  final num minVal;

  /// steps increase and decrease
  /// defalult [steps] = 1
  /// also support for decimal steps
  /// eg: [steps] = 3.14
  final num steps;

  /// Function([num] value) [onChanged]
  /// update value every changes
  /// the [runType] is [num].
  /// parse to [int] : value.toInt();
  /// parse to [double] : value.toDouble();
  final ValueChanged<num?> onQtyChanged;

  /// wrap [TextFormField] with [IntrinsicWidth] widget
  /// this will make the width of [InputQty] set to intrinsic width
  /// default  [isIntrinsicWidth] = true
  /// if `false` wrapped with [Expanded]
  final bool isIntrinsicWidth;

  /// Custom decoration of [TextFormField]
  /// default value:
  ///
  /// const InputDecoration(
  ///  border: UnderlineInputBorder(),
  ///  isDense: true,
  ///  isCollapsed: true,)
  ///
  /// add [contentPadding] to costumize distance between value
  /// and the button
  final InputDecoration? textFieldDecoration;

  const InputQty({
    Key? key,
    this.initVal = 0,
    this.textFieldDecoration,
    this.isIntrinsicWidth = true,
    required this.onQtyChanged,
    this.maxVal = double.maxFinite,
    this.minVal = 0,
    this.steps = 1,
  }) : super(key: key);

  @override
  State<InputQty> createState() => _InputQtyState();
}

class _InputQtyState extends State<InputQty> {
  IconData _icon = Icons.remove;

  /// text controller of textfield
  TextEditingController _valCtrl = TextEditingController();

  /// current value of quantity
  /// late num value;
  late ValueNotifier<num> currentval;

  /// [InputDecoration] use for [TextFormField]
  /// use when [textFieldDecoration] not null
  final _inputDecoration = const InputDecoration(
    border: UnderlineInputBorder(),
    isDense: true,
    isCollapsed: true,
  );
  @override
  void initState() {
    currentval = ValueNotifier(widget.initVal);
    _valCtrl = TextEditingController(text: "${widget.initVal}");
    widget.onQtyChanged(num.tryParse(_valCtrl.text));
    if (widget.initVal <= widget.minVal) {
      setState(() {
        _icon = Icons.delete_outline;
      });
    }
    super.initState();
  }

  /// Increase current value
  /// based on steps
  /// default [steps] = 1
  /// When the current value is empty string, and press [plus] button
  /// then firstly, it set the [value]= [initVal],
  /// after that [value] += [steps]
  void plus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.initVal;
    if (value < widget.maxVal) {
      value += widget.steps;
      currentval = ValueNotifier(value);
    } else {
      value = widget.maxVal;
      currentval = ValueNotifier(value);
    }

    if (value > widget.minVal) {
      setState(() {
        _icon = Icons.remove;
      });
    }

    /// set back to the controller
    _valCtrl.text = "$value";

    /// move cursor to the right side
    _valCtrl.selection =
        TextSelection.fromPosition(TextPosition(offset: _valCtrl.text.length));
    widget.onQtyChanged(num.tryParse(value.toString()));
  }

  /// decrese current value based on stpes
  /// default [steps] = 1
  /// When the current [value] is empty string, and press [minus] button
  /// then firstly, it set the [value]= [initVal],
  /// after that [value] -= [steps]
  void minus() {
    num value = num.tryParse(_valCtrl.text) ?? widget.initVal;
    if (value > widget.minVal) {
      value -= widget.steps;
      currentval = ValueNotifier(value);
    } else {
      value = widget.minVal;
      currentval = ValueNotifier(value);
    }

    if (value <= widget.minVal) {
      setState(() {
        _icon = Icons.delete_outline;
      });
    }

    /// set back to the controller
    _valCtrl.text = "$value";

    /// move cursor to the right side
    _valCtrl.selection =
        TextSelection.fromPosition(TextPosition(offset: _valCtrl.text.length));
    widget.onQtyChanged(num.tryParse(value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return widget.isIntrinsicWidth
        ? IntrinsicWidth(child: _buildInputQty())
        : _buildInputQty();
  }

  /// build widget input quantity
  Widget _buildInputQty() => Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey, width: 0.8),
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xD6D6D6D6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: minus,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: Icon(
                _icon,
                size: 16,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(child: _buildtextfield()),
            const SizedBox(
              width: 8,
            ),
            IconButton(
              color: Colors.teal,
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: plus,
              icon: const Icon(
                Icons.add,
                size: 16,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      );

  /// widget textformfield
  Widget _buildtextfield() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: TextFormField(
          textAlign: TextAlign.center,
          decoration: widget.textFieldDecoration ?? _inputDecoration,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          controller: _valCtrl,
          onChanged: (String strVal) {
            num? temp = num.tryParse(_valCtrl.text);
            if (temp == null) return;
            if (temp > widget.maxVal) {
              temp = widget.maxVal;
              _valCtrl.text = "${widget.maxVal}";
              _valCtrl.selection = TextSelection.fromPosition(
                  TextPosition(offset: _valCtrl.text.length));
            } else if (temp <= widget.minVal) {
              temp = widget.minVal;
              _valCtrl.text = temp.toString();
              _valCtrl.selection = TextSelection.fromPosition(
                  TextPosition(offset: _valCtrl.text.length));
            }
            widget.onQtyChanged(num.tryParse(_valCtrl.text));
          },
          keyboardType: TextInputType.number,
          inputFormatters: [
            // LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\-?\d*")),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _valCtrl.dispose();
  }
}
