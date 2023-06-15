import 'package:flutter/material.dart';
import 'package:sherekoo/util/utils.dart';

import '../../model/event/event-model.dart';
import '../../util/app-variables.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;
  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    preferences.init();
    preferences.get('token').then((value) {
      if (widget.event == null) {
        fromDate = DateTime.now();
        toDate = DateTime.now().add(const Duration(hours: 2));
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildingEditActions,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  style: const TextStyle(fontSize: 24),
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), hintText: 'Add Title'),
                  onFieldSubmitted: (_) {},
                  validator: (title) => title != null && title.isEmpty
                      ? 'Title cannot be Empty'
                      : null,
                  controller: _titleController,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildDateTimePicker()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDateTimePicker() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => buildHeader(
        header: 'From',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                  text: Utils.toDate(fromDate ?? DateTime.now()),
                  onClicked: () => pickFromDateTime(pickDate: true)),
            ),
            Expanded(
              child: buildDropdownField(
                  text: Utils.toTime(fromDate ?? DateTime.now()),
                  onClicked: () => pickFromDateTime(pickDate: false)),
            )
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'To',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                  text: Utils.toDate(toDate!),
                  onClicked: () => pickFromDateTime(pickDate: true)),
            ),
            Expanded(
              child: buildDropdownField(
                  text: Utils.toTime(toDate!),
                  onClicked: () => pickFromDateTime(pickDate: false)),
            )
          ],
        ),
      );

  pickFromDateTime({required bool pickDate}) async {
    final date =
        await pickDateTime(fromDate ?? DateTime.now(), pickDate: pickDate);
    if (date == null) return null;

    if (date.isAfter(toDate!)) {
      toDate = DateTime(
          date.year, date.month, date.day, toDate!.hour, toDate!.minute);
    }
    setState(() => fromDate = date);
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      // pick Time

      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    }
  }

  buildHeader({required String header, required Widget child}) {
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(header, style: const TextStyle(fontWeight: FontWeight.bold)),
      child
    ]);
  }

  Widget buildDropdownField(
          {required String text, required VoidCallback onClicked}) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  List<Widget> get buildingEditActions {
    return [
      ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent, shadowColor: Colors.transparent),
          onPressed: () {},
          icon: const Icon(Icons.done),
          label: const Text('Save'))
    ];
  }
}
