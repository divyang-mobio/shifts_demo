import 'package:flutter/material.dart';

dateTimeWidgets(context) async {
  DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 10));
  if (date != null) {
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
    if (time != null) {
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    } else {
      return null;
    }
  } else {
    return null;
  }
}

Future<dynamic> bottomSheet(context, {required List<String> data}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 300,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: data
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: MaterialButton(
                          shape: const Border(
                              bottom: BorderSide(color: Colors.grey, width: 1)),
                          child: Text(e),
                          onPressed: () => Navigator.pop(context, e),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    },
  );
}

textFieldWidget(context,
    {required IconData leadingIcon,
    required TextEditingController controller,
    required String hintText,
    required String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 8),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Icon(leadingIcon, size: 35, color: Theme.of(context).hintColor),
      const SizedBox(width: 20),
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
            const SizedBox(height: 10),
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width * .8,
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: hintText)),
            )
          ]),
    ]),
  );
}

listTile(context,
    {required IconData leadingIcon,
    required bool isTrailing,
    required String subTitle,
    required GestureTapCallback onTap,
    required String title}) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: ListTile(
            leading:
                Icon(leadingIcon, size: 35, color: Theme.of(context).hintColor),
            title: Text(title, style: Theme.of(context).textTheme.headline6),
            subtitle: Text(subTitle, style: const TextStyle(fontSize: 17)),
            trailing: isTrailing
                ? const Icon(Icons.keyboard_arrow_down, size: 35)
                : null),
      ),
      Divider(
        thickness: 1,
        indent: MediaQuery.of(context).size.width * .17,
        color: Colors.grey.shade600,
      ),
    ],
  );
}

materialButton(context,
    {required VoidCallback onPressed, required String title, Color? color}) {
  return SizedBox(
    height: 50,
    width: MediaQuery.of(context).size.width * .9,
    child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textColor: Colors.white,
        color:color ?? const Color.fromARGB(255, 0, 158, 61),
        onPressed: onPressed,
        child: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
  );
}
