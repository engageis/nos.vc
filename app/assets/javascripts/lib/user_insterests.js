UserInterests = {};

UserInterests.initialize = function(id, width) {

  $(id).select2({
    minimumInputLength: 0,
    width: width,
    tags: true,
    multiple: true,
    maximumSelectionLength: 2,

    ajax: {
      url: "/interests",
      processResults: function (data, page) {
        return {
          results: data
        };
      },
      cache: true
    },
  });
}

