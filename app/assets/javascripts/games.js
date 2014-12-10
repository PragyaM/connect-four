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
