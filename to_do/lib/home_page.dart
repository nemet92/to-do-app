import 'package:flutter/material.dart';
import 'package:to_do/const/service_page.dart';
import 'package:to_do/const/toDoModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ProjectLoading<MyHomePage> {
  List<TodoModel>? items;
  late final ProjectService projectService;
  @override
  void initState() {
    projectService = GeneralService();
    sendItemApi();
    super.initState();
  }

  Future<void> sendItemApi() async {
    changeWaitValue();
    items = await projectService.sendItemApi();
    changeWaitValue();
  }

  bool checkBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("To Do"),
        ),
        body: Center(
          child: isWait
              ? const CircularProgressIndicator(
                  color: Colors.red,
                )
              : ListView.builder(
                  itemCount: items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color(items?[index].changeColorValue ?? 0),
                        child: ListTile(
                          leading: const CircleAvatar(
                            radius: 16,
                          ),
                          title: Text(items?[index].id.toString() ?? "Error"),
                          trailing: Wrap(
                            children: [
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              Checkbox(value: checkBox, onChanged: ((value) {}))
                            ],
                          ),
                          subtitle: Text(items?[index].email ?? "e"),
                        ),
                      ),
                    );
                  }),
        ));
  }
}

abstract class ProjectLoading<T extends StatefulWidget> extends State<T> {
  bool isWait = false;
  void changeWaitValue() {
    setState(() {
      isWait = !isWait;
    });
  }
}
