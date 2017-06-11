$(function() {
  var root_topic = window.broker_root_topic;
  var broker_url = 'ws://' + window.broker_host;
  var broker_port = window.broker_ws_port;

  var client = mqtt.connect(broker_url, {'port': broker_port});
  client.subscribe(root_topic + '/#');

  client.on('message', function (topic, message, packet) {
    switch_id = topic.split('/').slice(-1).pop();
    switch_status = message == 'ON' ? true : false;
    switch_control = $('#' + switch_id);
    if(switch_control.prop('checked') == switch_status) return;
    switch_control.data('is_retained', packet['retain']);
    switch_control.prop('checked', switch_status).flipswitch('refresh');
  })

  $('.dimmer').on('slidestop', function(event, ui) {
    var dimmer_value = $(this).val();
    var dimmer_id = $(this).attr('id');
  });

  $('.switch').on('change', function(event) {
    if($(this).data('is_retained')) {
      $(this).data('is_retained', false);
      return;
    }
    switch_status = $(this).is(':checked');
    switch_id = $(this).attr('id');
    topic = [root_topic, switch_id].join('/');
    message = switch_status ? 'ON' : 'OFF';
    options = { 'retain': true };
    client.publish(topic, message, options);
  });
});
