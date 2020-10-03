passwords = ['password']

const passwordInput = document.getElementById('spacesheep-site-password')

String.prototype.hashCode = function() {
    var hash = 0;
    if (this.length == 0) {
        return hash;
    }
    for (var i = 0; i < this.length; i++) {
        var char = this.charCodeAt(i);
        hash = ((hash<<5)-hash)+char;
        hash = hash & hash; // Convert to 32bit integer
    }
    return hash;
}

function addFirewall() {
  const page = window.location.pathname
  const password_for_page = page.hashCode().toString().slice(3)

  console.log(page, password_for_page)

  if (window.localStorage.getItem('entered-password') == 'yes') {
    return
  }

  openModal()

  const submitPasswordButton = document.getElementById('submit-password')

  submitPasswordButton.addEventListener('click', () => {
    if (passwords.includes(passwordInput.value)) {
      closeModal()
    } else {
      wrongPassword()
    }
  })
}

const passwordModal = document.getElementById('password-modal')

function openModal() {
  passwordModal.setAttribute('aria-hidden', 'false')

  // Make body stay fixed
  document.body.style.position = 'fixed';
  document.body.style.top = `-${window.scrollY}px`;
}

function closeModal() {
  passwordModal.setAttribute('aria-hidden', 'true')
  passwordInput.setAttribute('aria-invalid', 'false')

  window.localStorage.setItem('entered-password', 'yes')

  // Make body stay fixed
  const scrollY = document.body.style.top;
  document.body.style.position = '';
  document.body.style.top = '';
  window.scrollTo(0, parseInt(scrollY || '0') * -1);
}

function wrongPassword() {
  passwordInput.setAttribute('aria-invalid', 'true')
}


function addLessonForm() {
  document.getElementById("lesson_number_form").addEventListener('submit', e => {
    e.preventDefault()

    let lessonNumber = document.getElementById("lesson_number").value
    let lesson = document.getElementsByTagName("article")[lessonNumber - 1]
    window.location = lesson.dataset.href
  })
}

document.addEventListener('turbolinks:load', () => {
  addFirewall()

  if (window.location.pathname === '/') {
    addLessonForm()
  }
})

