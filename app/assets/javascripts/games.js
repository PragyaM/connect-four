// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


$(function() {
  var gameId = $("#grid").data("game-id");
  var my_turn = $("#grid").data("my-turn")

  var pollAndReloadWhenMyTurn = function() {
    $.getJSON("/games/" + gameId).done(function(result) {
      if (result.my_turn) {
        location.reload();
      }
    });
  };

  if (gameId && !my_turn) {
    setInterval(pollAndReloadWhenMyTurn, 3000);
  }
});


$(function() {
  var waiting_game_count = $("#play_options").data("waiting-game-count");

  var pollAndReloadWhenGamesUpdated = function() {
    $.getJSON("/games/").done(function(result) {
      if (result.waiting_game_count != waiting_game_count) {
        location.reload();
      }
    });

  };
  if (waiting_game_count != null) {
    setInterval(pollAndReloadWhenGamesUpdated, 3000);
  }
});
