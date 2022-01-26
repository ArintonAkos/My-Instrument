part of 'home_page_bloc.dart';

enum HomePageStatus { initial, reloading, success, failure }

extension HomePageStateX on HomePageState {
  bool get isInitial => (status == HomePageStatus.initial);
  bool get isReloading => (status == HomePageStatus.reloading);
  bool get isSuccess => (status == HomePageStatus.success);
  bool get isFailure => (status == HomePageStatus.failure);
}

class HomePageState extends Equatable {
  final HomePageStatus status;

  const HomePageState({
    required this.status
  });

  HomePageState copyWith({
    HomePageStatus? status
  }) {
    return HomePageState(
      status: status ?? this.status
    );
  }

  factory HomePageState.initial() {
    return const HomePageState(
      status: HomePageStatus.initial
    );
  }

  @override
  String toString() {
    return '''
    HomePageState {
      status: $status,
    }
    ''';
  }

  @override
  List<Object> get props => [ status ];

}