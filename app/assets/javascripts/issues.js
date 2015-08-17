// Given a query string "?to=email&why=because&first=John&Last=smith"
// getUrlVar("to")  will return "email"
// getUrlVar("last") will return "smith"

function getUrlVar(key){
  var result = new RegExp(key + "=([^&]*)", "i").exec(window.location.search);
  return result && unescape(result[1]) || "";
}

$(function () {

  if (! $("body").hasClass("issues index"))
    return;

  $scope = getUrlVar("scope") || "open";
  $selector = "li#" +  $scope + "-issues";
  $( $selector ).addClass( "active" );
});

$(function () {
  if (! $("body").hasClass("issues show"))
    return;

  setTimeout( function() {
    if (! $(":target").hasClass("comment"))
      return;

    $( ":target" ).css({ backgroundColor: "white" });
  }, 2000);
});
