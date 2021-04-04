// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

import "controllers"

(() => {
  document.addEventListener('DOMContentLoaded', () => {
    initializeDropdownMenus('user-menu')
    initializeCloseBtns()
  })

  const initializeDropdownMenus = (...domIds) => {
    domIds.forEach(domId => {
      const btn = document.getElementById(domId)
      if (btn) btn.addEventListener('click', toggleDropdown)
    })
  }

  const toggleDropdown = e => {
    const btn = e.currentTarget
    const currentExpanded = btn.getAttribute('aria-expanded')
    const menu = document.querySelector(`[aria-labelledby='${btn.id}']`)

    btn.setAttribute('aria-expanded', currentExpanded != 'true')
    menu.classList.toggle('hidden')
  }

  const initializeCloseBtns = () => {
    const closeBtns = document.querySelectorAll('[data-closes]')
    closeBtns.forEach(btn => btn.addEventListener('click', closeTargetElement))
  }

  const closeTargetElement = e => {
    const btn = e.currentTarget
    const element = document.getElementById(btn.dataset.closes)
    element.classList.add('hidden')
  }
})()

// Tailwind CSS
import "stylesheets/application"
