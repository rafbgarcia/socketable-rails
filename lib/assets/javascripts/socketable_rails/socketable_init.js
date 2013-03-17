$(function() {
  if (Socketable.exists()) {
    Socketable.onDefaultAction(function() {
      Socketable.dispatcher.trigger(Socketable.DEFAULT_EVENT_NAME, Socketable.data());
    });
  }
});
