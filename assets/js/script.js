passwords = ['password']

const passwordInput = document.getElementById('spacesheep-site-password')

function addFirewall() {
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
    window.location = document.getElementById("lesson_number").value
  })
}

(() => {
  addFirewall()

  if (window.location.pathname === '/') {
    addLessonForm()
  }
})()

