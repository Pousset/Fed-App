
class Events {
  String? event;
  String? eventName;
  dynamic startEventDateTime;
  dynamic endEventDateTime;
  String? descriptionEvent;
  String? urlImg;

  dynamic base64Event;

  Events(
      {
       this.event,
       this.eventName,
       this.startEventDateTime,
       this.endEventDateTime,
       this.descriptionEvent,
       this.base64Event,
       this.urlImg
      });
}
