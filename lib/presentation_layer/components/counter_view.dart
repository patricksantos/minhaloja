import 'package:flutter/material.dart';

import 'package:minhaloja/infra/infra.dart';

class CounterView extends StatefulWidget {
  final int initNumber;
  final Function(int) counterCallback;
  final void Function()? increaseCallback;
  final void Function()? decreaseCallback;
  final int minNumber;
  final Color? color;
  final Color? colorText;

  const CounterView({
    super.key,
    required this.initNumber,
    required this.counterCallback,
    this.increaseCallback,
    this.decreaseCallback,
    required this.minNumber,
    this.color,
    this.colorText,
  });

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late int _currentCount;
  late Function _counterCallback;
  late Function _increaseCallback;
  late Function _decreaseCallback;
  late int _minNumber;

  @override
  void initState() {
    _currentCount = widget.initNumber;
    _counterCallback = widget.counterCallback;
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
    _minNumber = widget.minNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final design = DesignSystem.of(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.width,
          vertical: 6.height,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: design.secondary300,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12),
          color: widget.color ?? design.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _createIncrementDicrementButton(
              Icons.remove,
              () => _dicrement(),
              design,
            ),
            Text(
              _currentCount.toString(),
              style: design
                  .caption(
                    color: widget.colorText ?? design.secondary100,
                  )
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            _createIncrementDicrementButton(
              Icons.add,
              () => _increment(),
              design,
            ),
          ],
        ),
      ),
    );
  }

  void _increment() {
    setState(() {
      _currentCount++;
      _counterCallback(_currentCount);
      _increaseCallback();
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > _minNumber) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
    });
  }

  Widget _createIncrementDicrementButton(
    IconData icon,
    Function() onPressed,
    FoodAppDesign design,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 32.0,
          minHeight: 32.0,
        ),
        child: Icon(
          icon,
          color: design.secondary100,
          size: 16.0.fontSize,
        ),
      ),
    );
  }
}
