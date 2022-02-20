import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_instrument/src/business_logic/blocs/category_filter_select/category_filter_select_bloc.dart';
import 'package:my_instrument/src/data/models/responses/main/category/filter_entry_model.dart';
import 'package:my_instrument/src/presentation/widgets/category_filter_select/category_filter_modal.dart';
import 'package:my_instrument/src/presentation/widgets/custom_list_select.dart';
import 'package:my_instrument/src/presentation/widgets/error_info.dart';
import 'package:my_instrument/src/presentation/widgets/gradient_indeterminate_progress_bar.dart';

class CategoryFilterSelect extends StatelessWidget {
  final int? categoryId;
  final Map<String, FilterEntryModel> filters;
  final void Function(int filterId, FilterEntryModel filterEntry) onTap;

  const CategoryFilterSelect({
    Key? key,
    required this.categoryId,
    required this.filters,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (categoryId == null) {
      return const SizedBox(
        height: 0,
      );
    }

    return BlocBuilder<CategoryFilterSelectBloc, CategoryFilterSelectState>(
      builder: (context, state) => buildFilterSelect(context, state)
    );
  }

  Widget buildFilterSelect(BuildContext context, CategoryFilterSelectState state) {
    if (state.isSuccess) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.filters.length,
        padding: const EdgeInsets.only(bottom: 10),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CustomListSelect(
            title: state.filters[index].getFilterName(context),
            selectedValue:  filters[state.filters[index].filterId.toString()]?.getFilterEntryName(context),
            onPressed: () {
              showCupertinoModalBottomSheet(
                barrierColor: Colors.black.withOpacity(0.8),
                context: context,
                builder: (context) => CategoryFilterModal(
                  title: state.filters[index].getFilterName(context),
                  filterEntries: state.filters[index].filterEntries,
                  filterId: state.filters[index].filterId,
                  selectedValue: filters[state.filters[index].filterId.toString()]?.filterEntryId,
                  onTap: onTap,
                )
              );
            }
          ),
        )
      );
    } else if (state.isLoading) {
      return const Center(
        child: GradientIndeterminateProgressbar(
          height: 75,
          width: 75,
        )
      );
    }

    return const Center(
     child: ErrorInfo(),
    );
  }
}
