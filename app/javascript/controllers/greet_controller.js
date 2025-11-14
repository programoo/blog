import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="greet"
export default class extends Controller {
  connect() {
  }

  hello() {
    alert("Hello!")
  }

  static targets = ["name"]

  greet() {
    alert(`Hello ${this.nameTarget.value}!`)
  }
}
