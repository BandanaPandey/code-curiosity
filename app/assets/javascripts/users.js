$(document).on("ready", ".tool-tip", function(e) {
  console.log('abc');
  return $('[data-toggle="tooltip"]').tooltip();
});