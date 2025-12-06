import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {
  static targets = ["alert"]

  connect() {
    console.log("Alert connected");
    // Auto dismiss after 3 seconds
    setTimeout(() => {
      this.close()
    }, 3000)
  }

  close() {
    // Fade out using Bootstrap's JS API
    const bsAlert = bootstrap.Alert.getOrCreateInstance(this.element)
    bsAlert.close()
  }
}
