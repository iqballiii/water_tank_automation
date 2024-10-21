part of 'water_track_bloc.dart';

enum WaterTrackStatus {
  initial,
  loading,
  success,
  failure,
}

class WaterTrackState extends Equatable {
  const WaterTrackState({
    this.errorMessage,
    this.waterLevel,
    required this.status,
  });
  final WaterTrackStatus status;
  final int? waterLevel;
  final String? errorMessage;

  @override
  List<Object> get props => [
        status,
        waterLevel ?? 0,
        errorMessage ?? '',
      ];
}
