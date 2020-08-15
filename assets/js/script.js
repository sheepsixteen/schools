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
}

function closeModal() {
  passwordModal.setAttribute('aria-hidden', 'true')
  passwordInput.setAttribute('aria-invalid', 'false')

  window.localStorage.setItem('entered-password', 'yes')
}

function wrongPassword() {
  passwordInput.setAttribute('aria-invalid', 'true')
}

(() => {
  addFirewall()
})()

