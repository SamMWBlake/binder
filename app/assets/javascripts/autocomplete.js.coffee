$ ->
  $(".autocomplete-song-titles").autocomplete
    minLength: 1
    select: (event, ui) ->
      $(".autocomplete-artist-names").val(ui.item.value_artist)
    source: (request, response) ->
      $.getJSON("/songs",
        starts_with: request.term
      ).done((data) ->
        response $.map(data, (song) ->
          label: song.title + " (" + song.artist + ")"
          value: song.title
          value_artist: song.artist
        )
      ).fail ->
        response []

  $(".autocomplete-artist-names").autocomplete
    minLength: 1
    source: (request, response) ->
      $.getJSON("/artists",
        starts_with: request.term
      ).done((data) ->
        response $.map(data, (artist) -> artist.name)
      ).fail ->
        response []
