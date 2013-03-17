$(function() {
  if (Socketable.exists()) {
    Socketable.onDefaultAction(function() {
      Socketable.dispatcher().trigger('request', Socketable.data());
    });
  }
});
