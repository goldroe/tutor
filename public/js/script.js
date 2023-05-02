let toggleBtn = document.getElementById('toggle-btn');
let body = document.body;
let darkMode = localStorage.getItem('dark-mode');

const enableDarkMode = () =>{
    toggleBtn.classList.replace('fa-sun', 'fa-moon');
    body.classList.add('dark');
    localStorage.setItem('dark-mode', 'enabled');
}

const disableDarkMode = () =>{
    toggleBtn.classList.replace('fa-moon', 'fa-sun');
    body.classList.remove('dark');
    localStorage.setItem('dark-mode', 'disabled');
}

if(darkMode === 'enabled'){
    enableDarkMode();
}

toggleBtn.onclick = (e) =>{
    darkMode = localStorage.getItem('dark-mode');
    if(darkMode === 'disabled'){
        enableDarkMode();
    }else{
        disableDarkMode();
    }
}

let profile = document.querySelector('.header .flex .profile');

document.querySelector('#user-btn').onclick = () =>{
    profile.classList.toggle('active');
    search.classList.remove('active');
}

let search = document.querySelector('.header .flex .search-form');

document.querySelector('#search-btn').onclick = () =>{
    search.classList.toggle('active');
    profile.classList.remove('active');
}

let sideBar = document.querySelector('.side-bar');

document.querySelector('#menu-btn').onclick = () =>{
    sideBar.classList.toggle('active');
    body.classList.toggle('active');
}

document.querySelector('#close-btn').onclick = () =>{
    sideBar.classList.remove('active');
    body.classList.remove('active');
}

window.onscroll = () =>{
    profile.classList.remove('active');
    search.classList.remove('active');
    
    if(window.innerWidth < 1200){
        sideBar.classList.remove('active');
        body.classList.remove('active');
    }
}

function search_tutors() {
    console.log('search_tutors');
    let input = document.getElementById('tutor_searchbar');
    let filter = input.value.toUpperCase();
    let tutors = document.getElementsByClassName('box');
    
    // Loop through all tutor boxes, and hide those who don't match the search query
    for (i = 0; i < tutors.length; i++) {
        let name = tutors[i].getElementsByTagName('h3')[0];
        let name_text = name.innerText || name.textContent;
        if (name_text.toUpperCase().indexOf(filter) > -1) {
            tutors[i].style.display = "";
        } else {
            tutors[i].style.display = "none";
        }
    }
}

function search_courses() {
    console.log('search_courses');
    let input = document.getElementById('course_searchbar');
    let filter = input.value.toUpperCase();
    let courses = document.getElementsByClassName('box');
    
    // Loop through all tutor boxes, and hide those who don't match the search query
    for (i = 0; i < courses.length; i++) {
        let name = courses[i].getElementsByClassName('subject')[0];
        let name_text = name.innerText || name.textContent;
        if (name_text.toUpperCase().indexOf(filter) > -1) {
            courses[i].style.display = "";
        } else {
            courses[i].style.display = "none";
        }
    }
}


function make_subject_list() {
    let subjects = "";
    let checkboxes = document.querySelectorAll("input[type='checkbox']:checked");
    
    checkboxes.forEach((item) => {
        subjects += item.value + ',';
    }) 
    
    subjects = subjects.replace(/,\s*$/, ""); // remove trailing comma
    console.log(subjects);
    
    document.getElementById('subject_list').value = subjects;
    console.log(document.getElementById('subject_list').value);
}


function check_form(form) {
    console.log('check_form');
    if (form.pass.value != "" && form.pass.value == form.c_pass.value) {
        if (form.pass.value.length < 6) {
            alert("Error: Password must contain at least six characters!");
            form.pass.focus();
            return false;
        }
        if (form.pass.value.length > 15) {
            alert("Error: Password must contain at most fifteen characters!");
            form.pass.focus();
            return false;
        }
        re = /[0-9]/;
        if (!re.test(form.pass.value)) {
            alert("Error: password must contain at least one number (0-9)!");
            form.pass.focus();
            return false;
        }
        re = /[a-z]/;
        if (!re.test(form.pass.value)) {
            alert("Error: password must contain at least one lowercase letter (a-z)!");
            form.pass.focus();
            return false;
        }
        re = /[A-Z]/;
        if (!re.test(form.pass.value)) {
            alert("Error: password must contain at least one uppercase letter (A-Z)!");
            form.pass.focus();
            return false;
        }
    } else {
        alert("Error: Please check that you've entered and confirmed your password!");
        form.pass.focus();
        return false;
    }

    return true;
}

if(!RegExp.escape) {
    RegExp.escape = function(s) {
      return String(s).replace(/[\\^$*+?.()|[\]{}]/g, '\\$&');
    };
  }