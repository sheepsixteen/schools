---
---

# TODO: There's a bug, I think turbolinks is responsible, which runs
# `generatePassword` loads of times after a few clicks

$ = (id) -> document.getElementById(id)

generatePassword = (lesson_name) ->
  # Random number generator, seeded with lesson name
  rng = new Math.seedrandom(lesson_name)

  # TODO: there's probably a cool coffeescript way of doing this
  password = ''

  for [1..5]
    password += String.fromCharCode((rng() * 25) + 65)

  console.log password

  password

setPageAllowed = ->
  pages = JSON.parse(localStorage.getItem('allowed_pages')) || []
  pages.push window.location.pathname
  localStorage.setItem('allowed_pages', JSON.stringify(pages))
  null

isPageAllowed = ->
  pages = JSON.parse(localStorage.getItem('allowed_pages'))

  if pages?
    pages.includes window.location.pathname
  else
    false

requestPassword = ->
  password = generatePassword(window.location.pathname)

  openModal(password)

  # Add event listener to submitting password
  $('submit-password').addEventListener 'click', ->
    passwordInput = $('spacesheep-site-password')

    # If password is correct or "sheep16", close modal and add to cookies
    if passwordInput.value is password or
       passwordInput.value is "sheep16"
      closeModal()
      setPageAllowed()
    else
      wrongPassword()

  null

openModal = (password) ->
  # Open modal
  $('password-modal').setAttribute('aria-hidden', 'false')

  # Make body stay fixed
  document.body.style.position = 'fixed'
  document.body.style.top = "-#{window.scrollY}px"

  null

closeModal = ->
  # Hide modal
  $('password-modal').setAttribute('aria-hidden', 'true')

  # Make password valid
  $('spacesheep-site-password').setAttribute('aria-invalid', 'false')

  # Make body not fixed
  scrollY = document.body.style.top
  document.body.style.position = ''
  document.body.style.top = ''

  window.scrollTo(0, parseInt(scrollY || '0') * -1)

  null

wrongPassword = ->
  $('spacesheep-site-password').setAttribute('aria-invalid', 'true')
  $('wrong-password').style.display = 'block'
  $('wrong-password').setAttribute('aria-hidden', 'false')

setupPassword = ->
  # On the main page, don't ask for a password
  if window.location.pathname == '/'
    return
  else
    if not isPageAllowed()
      requestPassword()

  null

addLessonForm = ->
  if window.location.pathname isnt '/'
    return

  $('lesson_number_form').addEventListener 'submit', (e) ->
    e.preventDefault()

    lessonNumber = $('lesson_number').value
    lesson = document.getElementsByTagName('article')[lessonNumber - 1]
    window.location = lesson.dataset.href

document.addEventListener 'turbolinks:load', ->
  setupPassword()
  addLessonForm()

