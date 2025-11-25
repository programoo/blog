import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    document.addEventListener("turbo:load", () => {
      const targetId = new URLSearchParams(window.location.search).get("reply_element_id")
      if (targetId) {
        const el = document.getElementById("reply-element-" + targetId)
        if (el) el.scrollIntoView({ behavior: "smooth" })
      }
    })
  }
}
