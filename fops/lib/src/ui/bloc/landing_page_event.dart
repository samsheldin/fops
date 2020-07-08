import 'package:equatable/equatable.dart';

abstract class LandingPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends LandingPageEvent {
  final bool force;
  Fetch(this.force);
  @override
  List<Object> get props => [force];
}

class FetchAll extends LandingPageEvent {}

class AppointmentEssentials extends LandingPageEvent {
  // final List<PlansList> plansList;
  // AppointmentEssentials(this.plansList);

  // @override
  // List<Object> get props => [plansList];
}
