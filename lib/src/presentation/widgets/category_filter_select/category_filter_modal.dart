import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:my_instrument/src/data/models/responses/main/category/filter_entry_model.dart';

class CategoryFilterModal extends StatelessWidget {
  final int filterId;
  final String title;
  final List<FilterEntryModel> filterEntries;
  final int? selectedValue;
  final void Function(int filterId, FilterEntryModel filterEntry) onTap;

  const CategoryFilterModal({
    Key? key,
    required this.filterId,
    required this.title,
    required this.filterEntries,
    required this.selectedValue,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    return Material(
      child: Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => Builder(
            builder: (context) => Scaffold(
              appBar: AppBar(
                shadowColor: Colors.black45,
                backgroundColor: Theme.of(context).backgroundColor,
                title: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 20
                    )
                  ),
                )
              ),
              body: SafeArea(
                child: Container(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.85),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filterEntries.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        onTap(filterId, filterEntries[index]);
                        Navigator.pop(rootContext);
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: ListTile(
                        title: Text(
                          filterEntries[index].getFilterEntryName(context),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        trailing: (selectedValue == filterEntries[index].filterEntryId)
                          ? Icon(
                            LineIcons.checkCircleAlt,
                            color: Theme.of(context).colorScheme.primary,
                          )
                          : null
                      ),
                    )
                  ),
                ),
              )
            )
          )
        ),
      )
    );
  }
}
