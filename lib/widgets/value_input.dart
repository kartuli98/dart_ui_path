import 'package:flutter/material.dart';

class ValueInput extends StatefulWidget {
  const ValueInput({
    required this.title,
    required this.onSubmittedValue,
    required this.initialValue,
    super.key,
  });

  final double initialValue;
  final String title;
  final void Function(String value)? onSubmittedValue;

  @override
  State<ValueInput> createState() => _ValueInputState();
}

class _ValueInputState extends State<ValueInput> {

  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController()..text = widget.initialValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: 360,
        height: 30,
        child: Row(
          children: [
            Text("${widget.title} =", style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(width: 10,),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                style: Theme.of(context).textTheme.bodyLarge,
                onSubmitted: widget.onSubmittedValue,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Colors.greenAccent), //<-- SEE HERE
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}