import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SelectBottomSheet extends StatelessWidget {

  final bool reverse;

  const SelectBottomSheet({Key? key, this.reverse = false}) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    return Material(
        child: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (context2) => Builder(
              builder: (context) => CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                    leading: Container(), middle: Text('Modal Page')),
                child: SafeArea(
                  bottom: false,
                  child: ListView(
                    shrinkWrap: true,
                    controller: ModalScrollController.of(context),
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: List.generate(
                          100,
                              (index) => ListTile(
                            title: Text('Item'),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CupertinoPageScaffold(
                                    navigationBar: CupertinoNavigationBar(
                                      backgroundColor: Theme.of(context).colorScheme.secondary,
                                      middle: Text('New Page'),
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        MaterialButton(
                                          onPressed: () =>
                                              Navigator.of(rootContext).pop(),
                                          child: Text('touch here'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
        ));
  }




 /* Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
              leading: Container(), middle: const Text('Filters')),
          child: SafeArea(
            bottom: false,
            child: ListView(
              reverse: reverse,
              shrinkWrap: true,
              controller: ModalScrollController.of(context),
              physics: ClampingScrollPhysics(),
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    title: Text("Guitar"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CupertinoPageScaffold(
                            navigationBar: CupertinoNavigationBar(
                              middle: Text('New Page'),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  child: Text('touch here'),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                  ListTile(
                    title: Text("Drums"),
                      onTap: () => showCupertinoModalBottomSheet(
                        expand: true,
                        isDismissible: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            SelectBottomSheet(reverse: reverse),
                      )
                  ),
                  ListTile(
                    title: Text("Violin"),
                      onTap: () => showCupertinoModalBottomSheet(
                        expand: true,
                        isDismissible: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            SelectBottomSheet(reverse: reverse),
                      )
                  ),
                ]
                  ).toList(),
            ),
          ),
        ));
  } */
}
