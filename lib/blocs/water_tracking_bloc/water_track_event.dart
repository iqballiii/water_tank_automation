part of 'water_track_bloc.dart';

class WaterTrackEvent extends Equatable {
  final int? waterLevel;
  const WaterTrackEvent({this.waterLevel});

  @override
  List<Object> get props => [waterLevel!];
}
