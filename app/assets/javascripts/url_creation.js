$(document).ready(function() {
  $newUrlForm =  $("#new-url-form");

  var updateUrls = function(data) {
    var urlsList = $("#urls-list");
    urlsList.replaceWith(data);
  }

  var disableSubmitButton = function(setTo) {
    var $button = $("#submit-new-url");
    $button.prop("disabled", setTo);
  };

  var submitForm = function(event) {
    event.preventDefault();
    disableSubmitButton(true);

    var request = $.ajax({
      type: "POST",
      data: $newUrlForm.serialize(),
      url: $newUrlForm.attr("action")
    });

    request.done(updateUrls);

    request.complete(function() {
      disableSubmitButton(false);
      $newUrlForm.trigger("reset");
    });
  };

  $newUrlForm.on("submit", submitForm);
});
