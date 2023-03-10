import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../module/contact.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  late TextEditingController name;
  late TextEditingController phoneNumber;
  @override
  void initState() {
    name = TextEditingController();
    phoneNumber = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  final box = Hive.box<Contacts>('contactsBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hive Demo'),
        ),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box<Contacts> box, _) {
            if (box.values.isEmpty) {
              return const Center(child: Text("No Contacts"));
            } else {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) => Dismissible(
                  key: Key(box.keyAt(index)),
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  onDismissed: (direction) {
                    box.deleteAt(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$box dismissed')));
                  },
                  child: ListTile(
                    // onTap: () => Navi,
                    title: Text(box.getAt(index)!.name.toString()),
                    subtitle: Text(
                      box.getAt(index)!.phoneNumber.toString(),
                    ),
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showForm,
          child: const Icon(Icons.add),
        ));
  }

// 0548790936
  _showForm() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    // initialValue: box.isEmpty?'':box.getAt(index)!.name,
                    controller: name,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: phoneNumber,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await box.put(
                            DateTime.now().toString(),
                            Contacts(
                                name: name.text,
                                phoneNumber: phoneNumber.text));
                        if (!mounted) return;
                        Navigator.of(_).pop();
                        name.clear();
                        phoneNumber.clear();
                      },
                      child: const Text('AddTo'))
                ],
              ),
            ));
  }
}
