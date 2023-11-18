abstract class RemoteBarsEvent {
  const RemoteBarsEvent();
}

class GetBars extends RemoteBarsEvent {
  const GetBars();
}

class GetBarByID extends RemoteBarsEvent {
  final int barId;

  const GetBarByID(this.barId);
}
