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
  var roll_no = document.forms["sign-up"]["Roll-no"].value;
  var phone_no = document.forms["sign-up"]["Phone"].value;
  var email_id = document.forms["sign-up"]["email"].value;
  var user_password = document.forms["sign-up"]["password"].value;
  var user_password_confirm = document.forms["sign-up"]["confirm_password"].value;
  if (user_password !== user_password_confirm) {
    alert("Passwords do not match. Try again!");
  } else if (!/^\d{10}$/.test(phone_no)) {
    alert("phone number must be 10 digits in length")
  } else if (!/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,20}$/.test(user_password)) {
    alert("Password must contain atleast on digit, one lowercase and one uppercase alphabets and must be atleast 4 - 20 characters in length!");
  } else if (!/^[1-2][0-9][1-5](CO|IT|EC|EE|ME|MA|CV|CH|CS|MT|BT)([0-9]){3}$/.test(roll_no)) {
    alert("Roll no not right");
  } else {
    alert("Welcome " + user_name + "\nYour Account is Successfully created");
    window.open('', '_blank');
  }

}

function validateLoginForm() {
  var email_id = document.forms["login"]["email"].value;
  var user_password = document.forms["login"]["password"].value;
  if (!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email_id)) {
    alert("You have entered an invalid email address!");
  } else if (!/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,20}$/.test(user_password)) {
    alert("Password must contain atleast on digit, one lowercase and one uppercase alphabets and must be atleast 4 - 20 characters in length!")
  } else {
    alert("Login Successful");
    window.open('sign-up.html', '_blank');
  }
}

function validateEmailForm() {
  var email_id = document.forms["collect-email"]["email"].value;
  if (email_id != "") {
    alert("Congratulations!\n" + email_id + " has been subscibed");
  }
}

function validateFeedbackForm() {
  var message = document.getElementById("user_input").value;
  // alert(message);
  var user_name = document.forms["feedback"]["name"].value;
  // alert(user_name);
  var city_name = document.getElementsByName("city")[0].value;
  // alert("City: " + city_name);
  document.getElementById('display').innerHTML = message;
}

function validateFeedbackForm2() {
  var message = document.getElementById("user_input2").value;
  alert(message);
  var email_id = document.forms['feedback2']['email'].value;
  if (!/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email_id)) {
    alert("You have entered an invalid email address! it must be like abc@xyz.com");
  }
  var comments = document.forms['feedback2']['comments'].value;
  if (message == null) {
    alert("comments cant be blank");
  }

}
var imgArray = new Array();

imgArray[0] = new Image();
imgArray[0].src = 'images/img/1.jpg';

imgArray[1] = new Image();
imgArray[1].src = 'images/img/2.jpg';

imgArray[2] = new Image();
imgArray[2].src = 'images/img/3.jpg';

imgArray[3] = new Image();
imgArray[3].src = 'images/img/4.jpg';

/*------------------------------------*/

function nextImage(element) {
  var img = document.getElementById(element);

  for (var i = 0; i < imgArray.length; i++) {
    if (imgArray[i].src == img.src) // << check this
    {
      if (i === imgArray.length - 1) {
        document.getElementById(element).src = imgArray[0].src;
        break;
      }
      document.getElementById(element).src = imgArray[i + 1].src;
      break;
    }
  }
}

function prevImage(element) {
  var img = document.getElementById(element);

  for (var i = imgArray.length - 1; i >= 0; i--) {
    if (imgArray[i].src == img.src) // << check this
    {
      if (i === 0) {
        document.getElementById(element).src = imgArray[imgArray.length - 1].src;
        break;
      }
      document.getElementById(element).src = imgArray[i - 1].src;
      break;
    }
  }
}

function is_empty(x) {
  return (
    (typeof x == 'undefined') ||
    (x == null) ||
    (x == false) //same as: !x
    ||
    (x.length == 0) ||
    (x == "") ||
    (x.replace(/\s/g, "") == "") ||
    (!/[^\s]/.test(x)) ||
    (/^\s*$/.test(x))
  );
}