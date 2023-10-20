import 'package:flutter/material.dart';

class OffsetInput extends StatefulWidget {
  const OffsetInput({
    required this.title,
    required this.onSubmittedDx,
    required this.onSubmittedDy,
    required this.initialOffset,
    super.key,
  });

  final Offset initialOffset;
  final String title;
  final void Function(String dx)? onSubmittedDx;
  final void Function(String dy)? onSubmittedDy;

  @override
  State<OffsetInput> createState() => _OffsetInputState();
}

class _OffsetInputState extends State<OffsetInput> {

  late TextEditingController controllerDx;
  late TextEditingController controllerDy;

  @override
  void initState() {
    super.initState();
    controllerDx = TextEditingController()..text = widget.initialOffset.dx.toString();
    controllerDy = TextEditingController()..text = widget.initialOffset.dy.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: 360,
        height: 30,
        child: Row(
          children: [
            Text("${widget.title} (", style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(width: 10,),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controllerDx,
                style: Theme.of(context).textTheme.bodyLarge,
                onSubmitted: widget.onSubmittedDx,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Colors.greenAccent), //<-- SEE HERE
                  ),
                ),
              ),
            ),
            Text(", ", style: Theme.of(context).textTheme.titleMedium,),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controllerDy,
                onSubmitted: widget.onSubmittedDy,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Colors.greenAccent), //<-- SEE HERE
                  ),
                ),
              ),
            ),
            Text(" )", style: Theme.of(context).textTheme.titleMedium,),
          ],
        ));
  }
}