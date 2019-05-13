
function onSelectReportType(ele){
    var form = $(ele).parent().parent();
    var label = $(form).find(".additional_msg");
    var select = $(form).find(".additional_msg_select");

    switch (ele.value) {
        case "donation":
        case "request":
            label.text("Resource Type:");
            select.find('option').remove();
            select.append($("<option></option>")
                .attr("value","")
                .text("Choose the resource type"));
            selectValues = ['water', 'food', 'money', 'medicine', 'cloth',
                'rescue/volunteer'];
            $.each(selectValues, function(index,value) {
                select.append($("<option></option>")
                    .attr("value",value)
                    .text(value));
            });
            break;
        case "damage":
            label.text("Damage Type:");
            select.find('option').remove();
            select.append($("<option></option>")
                .attr("value","")
                .text("Choose the damage type"));
            selectValues = ['polution', 'building damage', 'road damage', 'casualty',
                'other'];
            $.each(selectValues, function(index,value) {
                select.append($("<option></option>")
                    .attr("value",value)
                    .text(value));
            });
            break;
        default:
            $(form).find(".additional_msg_div").css("visibility", "hidden");
            return;
    }
    $(form).find(".additional_msg_div").css("visibility", "visible");
}

function queryReport(event) {
    event.preventDefault(); // stop form from submitting normally

    var a = $("#query_report_form").serializeArray();
    a.push({ name: "tab_id", value: "1" });
    a = a.filter(function(item){return item.value != '';});
    $.ajax({
        url: 'HttpServlet',
        type: 'POST',
        data: a,
        success: function(reports) {
            console.log("reports here: ", reports)
            mapInitialization(reports);
        },
        error: function(xhr, status, error) {
            alert("Status: " + status + "\nError: " + error);
        }
    });
}
function createReport(){
    console.log("PLACE", place);
    event.preventDefault(); // stop form from submitting normally

    var a = $("#create_report_form").serializeArray();
    console.log("HERE", a)
    a.push({ name: "tab_id", value: "0" });
    a.push({ name: "latitude", value: place.geometry.location.lat() });
    a.push({ name: "longitude", value: place.geometry.location.lat() });
    a = a.filter(function(item){return item.value != '';});
    $.ajax({
        url: 'HttpServlet',
        type: 'POST',
        data: a,
        success: function(reports) {
            alert("Report created successfully!")
            showAllReports();
            onPlaceChanged( ()=> document.getElementById("create_report_form").reset()); // fire onPlaceChanged here in the callback for createreport, after mapinit and BEFORE the form is reset
            //document.getElementById("create_report_form").reset();
            document.getElementById("additional_msg_div").css("visibility", "hidden");
        },
        error: function(xhr, status, error) {
            alert("createReport Status: " + status + "\nError: " + error);
        }
    });
}

//query reports
$("#query_report_form").on("submit",queryReport);
//create_report
$("#create_report_form").on("submit",createReport);