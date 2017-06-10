$(function(){
  var topic = 'home_auto';
  var broker_url = 'ws://' + window.broker_host
  var broker_port = window.broker_ws_port

  var client = mqtt.connect(broker_url, {'port': broker_port}) // you add a ws:// url here
  client.subscribe(topic + '/#');

  client.on('message', function (topic, payload) {
    switch_id = topic.split('/').slice(-1).pop();
    switch_status = payload == 'ON' ? true : false
    $('#' + switch_id).prop('checked', switch_status).flipswitch('refresh');
  })

  $('.dimmer').on('slidestop', function(event, ui) {
    var dimmer_value = $(this).val();
    var dimmer_id = $(this).attr('id');
  });

  $('.switch').on('change', function(event) {
    switch_status = $(this).is(':checked');
    switch_id = $(this).attr('id');
    topic = [topic, switch_id].join('/');
    message = switch_status ? 'ON' : 'OFF';
    options = { 'retain': true };
    client.publish(topic, message, options);
  });
});
