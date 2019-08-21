/* Toggle between adding and removing the "responsive" class to topnav when the user clicks on the icon */
function myFunction() {
    var x = document.getElementById("myTopnav");
    if (x.className === "topnav") {
        x.className += " responsive";
    } else {
        x.className = "topnav";
    }
}

// function openPage(pageName, elmnt, color) {
//     // Hide all elements with class="tabcontent" by default */
//     var i, tabcontent, tablinks;
//     tabcontent = document.getElementsByClassName("tabcontent");
//     for (i = 0; i < tabcontent.length; i++) {
//       tabcontent[i].style.display = "none";
//     }
  
//     // Remove the background color of all tablinks/buttons
//     tablinks = document.getElementsByClassName("tablink");
//     for (i = 0; i < tablinks.length; i++) {
//       tablinks[i].style.backgroundColor = "";
//     }
  
//     // Show the specific tab content
//     document.getElementById(pageName).style.display = "block";
  
//     // Add the specific color to the button used to open the tab content
//     elmnt.style.backgroundColor = color;
//   }
  
  // Get the element with id="defaultOpen" and click on it
  // document.getElementById("defaultOpen").click(); 

function validateSignUpForm() {
  var user_name = document.forms["sign-up"]["Name"].value;
  var phone_no = document.forms["sign-up"]["Phone"].value;
  var email_id = document.forms["sign-up"]["email"].value;
  var user_password = document.forms["sign-up"]["password"].value;
  if (user_name != "") {
    alert("Welcome " + user_name +"\nYour Account is Successfully created");
  }
  window.open('', '_blank');
} 

function validateLoginForm() {
  var user_name = document.forms["login"]["Name"].value;
  var phone_no = document.forms["login"]["Phone"].value;
  var email_id = document.forms["login"]["email"].value;
  var user_password = document.forms["login"]["password"].value;
  if (user_name != "") {
    alert("Welcome " + user_name +"\nYour Account is Successfully created");
  }
  window.open('', '_blank');
} 