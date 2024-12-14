import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/filter_params_entity.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterInitial(FilterParamsEntity()));

  void updateFilter(FilterParamsEntity filterParams) {
    emit(FilterUpdated(filterParams));
  }

  void clearFilter() {
    emit(const FilterCleared(FilterParamsEntity()));
  }

  int getFilterCount() {
    final filterParams = state.filterParams;
    return filterParams.props.where((element) => element != null).length;
  }
}
