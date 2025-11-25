import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["panel"]

    connect() {
        console.log("PANEL CONTROLLER CONNECTED #########################");
    }

    toggle(event) {
        event.stopPropagation(); // prevent bubbling
        this.panelTarget.classList.toggle("d-none");

        // Close panel if clicking outside
        if (!this.boundClickOutside) {
            this.boundClickOutside = this.closeOutside.bind(this)
            document.addEventListener("click", this.boundClickOutside)
        }
    }

    closeOutside(event) {
        if (!this.element.contains(event.target)) {
            this.panelTarget.classList.add("d-none");
            document.removeEventListener("click", this.boundClickOutside)
            this.boundClickOutside = null
        }
    }
}
