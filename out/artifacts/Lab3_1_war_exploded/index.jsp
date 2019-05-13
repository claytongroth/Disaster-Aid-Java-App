<%@ page language= "java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Web Project</title>

  <!-- Custom styles -->
  <link rel="stylesheet" href="css/style.css">

  <!-- JQuery -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.0.1/jquery-migrate.js"></script>


  <!-- Bootstrap -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

 <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&key=AIzaSyBmat5doXTryDW-Z54qC-x1SKjGvoMU50c&signed_in=true&libraries=geometry,places" ></script>


</head>
<body>
<script>
  window.onload = tests();
  function tests() {
    //test_report_submission();
    //test_query_report();
    //create_user_report();
  }

// can be running this one from the RunQuery.jsp
  function test_report_submission() {
    $.ajax({
      url: 'HttpServlet',  // RunQuery.jsp or HttpServlet
      type: 'POST',
      data: { "tab_id": "0",
              "fN": "Jason",
              "lN": "Zhou",
              "is_male": "t",
              "age": "30",
              "blood_type": "AB",
              "tel": "928-777-8856",
              "email": "jasonzhou@gmail.com",
              "contact_fN": "Bill",
              "contact_lN": "Huang",
              "contact_tel": "608-888-9876",
              "contact_email": "billh@gmail.com",
              "report_type": "request",
              "disaster_type": "wildfire",
              "longitude": "-87",
              "latitude": "33",
              "message": "request rescue!!!",
              "additional_message": "rescue/volunteer"
          },
      success: function(data){
        $.each(data, function(i, name) {
          console.log("test_report_submission: ", data);
          console.log("key: " + i + ", value: " + name);
        });
      },
      error: function(xhr, status, error) {
        alert("An AJAX error occured: " + status + "\nError: " + error);
      }
    });
  }
// this function now pertains to the new tab_id "2" that I have set up to run the
  // select * from report query
  function test_query_report() {
    console.log("test_query_report fired")
    $.ajax({
      url: 'HttpServlet',
      type: 'POST',
      data: { 'tab_id': '2'},
      success: function(data){
        console.log("test_query_report success")
        $.each(data, function(i, e) {
          alert(JSON.stringify(e));
        });
      },
      error: function(xhr, status, error) {
        alert("An AJAX error occured in test_query_report: " + status + "\nError: " + error);
      }
    });
  }

  // creating the customized user report in the database
  function create_user_report(){
    console.log("create_user_report fired")
    $.ajax({
      url: 'HttpServlet',
      type: 'POST',
      data: { "tab_id": "0",
        "fN": "Dannis",
        "lN": "Black",
        "report_type": "damage",
        "disaster_type": "hurricane",
        "longitude": "26.89",
        "latitude": "35.12",
        "message": "pollution",
        "additional_message": "pollution"},
      success: function(data){
        console.log("create_user_report complete")
        $.each(data, function(i, name) {
          console.log("key: " + i + ", value: " + name);
        });
      },
      error: function(xhr, status, error) {
        alert("An AJAX error occured: " + status + "\nError: " + error);
      }
    });
  }


</script>

<nav class="navbar navbar-inverse navbar-fixed-top">
  <a class="navbar-brand">Disaster Management Portal</a>
</nav>
<div class="container-fluid">
  <div class="row">
    <div class="sidebar col-xs-3">

      <!-- Tab Navis-->
      <ul class="nav nav-tabs">
        <li class="active"><a href="#create_report" data-toggle="tab">Create Report</a></li>
        <li><a href="#query_report" data-toggle="tab">Query</a></li>
      </ul>

      <!-- Tab panes -->
      <div class="tab-content ">
        <!-- Create Report Tab Panel -->
        <div class="tab-pane active" id="create_report">
          <form id = "create_report_form">
            <div><label>First Name:&nbsp</label><input placeholder="Your first name" name="fN"></div>
            <div><label>Last Name:&nbsp</label><input placeholder="Your last name" name="lN"></div>
            <div>
              <label><input type="radio" name="is_male" value="t">&nbspMale</label>
              <label><input type="radio" name="is_male" value="f">&nbspFemale</label>
            </div>
            <div><label>Age:&nbsp</label><input placeholder="Your age" name="age"></div>
            <div><label>Blood Type:</label>
              <select name="blood_type">
                <option value="">Choose your blood type</option>
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="O">O</option>
                <option value="AB">AB</option>
                <option value="Other">Other</option>
              </select>
            </div>
            <div><label>Tel:&nbsp</label><input placeholder="Your telephone number" name="tel"></div>
            <div><label>Email:&nbsp</label><input placeholder="Your email address" name="email"></div>
            <div><label>Contact's First Name:&nbsp</label><input placeholder="Contact's first name" name="contact_fN"></div>
            <div><label>Contact's Last Name:&nbsp</label><input placeholder="Contact's last name" name="contact_lN"></div>
            <div><label>Contact's Tel:&nbsp</label><input placeholder="Contact's telephone number" name="contact_tel"></div>
            <div><label>Contact's Email:&nbsp</label><input placeholder="Contact's email address" name="contact_email"></div>
            <div><label>Report Type:</label>
              <select onchange="onSelectReportType(this)" name="report_type">
                <option value="">Choose the report type</option>
                <option value="donation">Donation</option>
                <option value="request">Request</option>
                <option value="damage">Damage Report</option>
              </select>
            </div>
            <div class="additional_msg_div" style="visibility: hidden"><label class="additional_msg"></label>
              <select class="additional_msg_select" name="additional_message"></select>
            </div>
            <div><label>Disaster Type:</label>
              <select name="disaster_type">
                <option value="">Choose the disaster type</option>
                <option value="flood">flood</option>
                <option value="wildfire">wildfire</option>
                <option value="earthquake">earthquake</option>
                <option value="tornado">tornado</option>
                <option value="hurricane">hurricane</option>
                <option value="other">other</option>
              </select>
            </div>
            <div><label>Address:</label>
                <input id="autocomplete" placeholder="Address" >
            </div>
            <div><label>Comment:&nbsp</label><input placeholder="Additional message" name="message"></div>
            <button type="submit" class="btn btn-default" id="report_submit_btn">
              <span class="glyphicon glyphicon-star"></span> Submit
            </button>
          </form>
        </div>

        <!-- Query Report Tab Panel -->
        <div class="tab-pane" id="query_report">
          <form id = "query_report_form">
            <div><label>Report Type:</label>
              <select onchange="onSelectReportType(this)" name="report_type">
                <option value="">Choose the report type</option>
                <option value="donation">Donation</option>
                <option value="request">Request</option>
                <option value="damage">Damage Report</option>
              </select>
            </div>
            <div class="additional_msg_div" style="visibility: hidden"><label class="additional_msg"></label>
              <select class="additional_msg_select" name="resource_or_damage"></select>
            </div>
            <div><label>Disaster Type:</label>
              <select name="disaster_type">
                <option value="">Choose the disaster type</option>
                <option value="flood">flood</option>
                <option value="wildfire">wildfire</option>
                <option value="earthquake">earthquake</option>
                <option value="tornado">tornado</option>
                <option value="hurricane">hurricane</option>
                <option value="other">other</option>
              </select>
            </div>
            <button type="submit" class="btn btn-default">
              <span class="glyphicon glyphicon-star"></span> Submit the query
            </button>
          </form>
        </div>
      </div>
    </div>

    <div id="map-canvas" class="col-xs-9"></div>

  </div>
</div>

<script src="js/loadform.js"></script>
<script src="js/loadmap.js"></script>

</body>
</html>