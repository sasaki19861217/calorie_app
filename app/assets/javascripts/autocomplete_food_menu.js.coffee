$ ->
  $("#food_menu_field").autocomplete
    source: (req, res) ->
      document.result_data = {}
      $.ajax
        url: "/foods/autocomplete_food_menu/" + encodeURIComponent(req.term),
        dataType: "json",
        success: (data) ->
          document.result_data = data
          
          options = [];
          for title, calorie of data
            options.push({
              label: title + ' / ' + calorie + '[kcal]',
              value: title
            });
          res(options);
    ,
    select: (event, ui) ->
      setTimeout ->
        calorie = document.result_data[$("#food_menu_field").val()]
        $("#food_calorie").val(calorie)
    autoFocus: true,
    delay: 300,
    minLength: 2