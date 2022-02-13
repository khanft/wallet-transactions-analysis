// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import Rails from "@rails/ujs"
Rails.start()
import "./controllers"
import jquery from "jquery"
window.jQuery = jquery
window.$ = jquery
import * as bootstrap from "bootstrap"



let popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))  
let popoverList = popoverTriggerList.map(function (popoverTriggerEl) {  
  return new bootstrap.Popover(popoverTriggerEl)  
})  