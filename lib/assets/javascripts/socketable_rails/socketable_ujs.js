(function(window, $) {
  window.Url = {
    path: window.location.pathname,
    host_with_port: window.location.host
  };

  window.Socketable = function() {
    var selector, dispatcher, jqSelector;
    selector = 'form[data-websocket]';

    return {
      dispatcher: function() {
        if(typeof dispatcher !== 'object') {
          dispatcher = new WebSocketRails(Url.host_with_port + "/websocket");
        }
        return dispatcher;
      },
      exists: function() {
        return $(selector).length > 0;
      },
      data: function() {
        return $(selector).serialize() + "&path=" + $(selector).attr('action');
      },
      onDefaultAction: function(fn) {
        $(selector).submit(function(e) {
          e.preventDefault();
          fn();
        });
      }
    };
  }();
})(window, jQuery);
