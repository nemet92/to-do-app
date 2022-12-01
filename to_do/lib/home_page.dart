import 'package:flutter/material.dart';
import 'package:to_do/const/service_page.dart';
import 'package:to_do/const/toDoModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ProjectLoading<MyHomePage> {
  List<Data>? items;
  late final ProjectService projectService;
  @override
  void initState() {
    projectService = GeneralService();
    sendItemApi();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicator.currentState?.show());
    super.initState();
  }

  Future<void> sendItemApi() async {
    changeWaitValue();
    items = await projectService.sendItemApi();
    changeWaitValue();
  }

  Future<void> deleteItemFromApi(int userId) async {
    projectService.removeItem(userId);
  }

  bool checkBox = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: sendItemApi,
          key: _refreshIndicator,
          child: isWait
              ? Container()
              : ListView.builder(
                  itemCount: items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color(items?[index].changeColorValue ?? 0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage("${items?[index].avatar}"),
                            radius: 16,
                          ),
                          subtitle: Text(
                            items?[index].email ?? " Error",
                            style: const TextStyle(color: Colors.white),
                          ),
                          title: Text(
                            "${items?[index].firstName ?? "Error "} ${items?[index].lastName}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    deleteItemFromApi(items?[index].id ?? 0);
                                    _refreshIndicator.currentState?.show();
                                  });
                                },
                                color: Colors.white,
                                icon: const Icon(Icons.delete),
                              ),
                              Checkbox(value: checkBox, onChanged: ((value) {}))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("object");
            const AlertDialog(
              title: Text("dad"),
              actions: [
                TextField(),
                SizedBox(
                  height: 150,
                  width: 15,
                )
              ],
            );
          },
          child: const Icon(Icons.add),
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
