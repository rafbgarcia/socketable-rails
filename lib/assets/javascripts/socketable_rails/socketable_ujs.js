(function(window, $) {
  window.Socketable = function() {
    var selector, dispatcher, path, host_with_port;

    path           = window.location.pathname;
    host_with_port = window.location.host;
    selector   = 'form[data-websocket]';

    return {
      DEFAULT_EVENT_NAME: 'request',
      dispatcher: function() {
        if(typeof dispatcher !== 'object') {
          dispatcher = new WebSocketRails(host_with_port + "/websocket");
        }
        return dispatcher;
      },
      exists: function() {
        return $(selector).length > 0;
      },
      data: function() {
        // if seletor is form
        return $(selector).serialize() + "&path=" + $(selector).attr('action');
      },
      onDefaultAction: function(fn) {
        // if selector is form
        $(selector).submit(function(e) {
          e.preventDefault();
          fn();
        });
      }
    };
  }();
})(window, jQuery);
