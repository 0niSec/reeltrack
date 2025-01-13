import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button", "menu"];

  toggle() {
    this.menuTarget.classList.toggle("hidden");
  }

  // Optional: Close when clicking outside
  clickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
    }
  }

  connect() {
    document.addEventListener("click", this.clickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.clickOutside.bind(this));
  }
}
