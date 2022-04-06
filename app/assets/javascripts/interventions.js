// app/assets/javascripts/batteries.js

$(function() {

   if ($("building_id#battery").val() == "") {
    $("select#battery option").remove();
    var row = "<option value=\"" + "" + "\">" + "Battery" + "</option>";
    $(row).appendTo("select#battery");
   }
   $("select#building").change(function() {
    var id_value_string = $(this).val();
    if (id_value_string == "") {
     $("select#battery option").remove();
     var row = "<option value=\"" + "" + "\">" + "Battery" + "</option>";
     $(row).appendTo("select#battery");
    } else {
     // Send the request and update course dropdown
     $.ajax({
      dataType: "json",
      cache: false,
      url: '/get_batteries_by_building/' + id_value_string,
      timeout: 5000,
      error: function(XMLHttpRequest, errorTextStatus, error) {
       alert("Failed to submit : " + errorTextStatus + " ;" + error);
      },
      success: function(data) {
       // Clear all options from course select
       $("select#battery option").remove();
       //put in a empty default line
       var row = "<option value=\"" + "" + "\">" + "Battery" + "</option>";
       $(row).appendTo("select#battery");
       // Fill course select
       $.each(data, function(i, j) {
        row = "<option value=\"" + j.id + "\">" + j.title + "</option>";
        $(row).appendTo("select#battery");
       });
      }
     });
    }
   });

  });