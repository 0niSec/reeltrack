import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container"];
  static values = { debug: Boolean };

  connect() {
    if (this.debugValue) {
      console.log("Modal controller connected");
      console.log("Container target found:", this.hasContainerTarget);
    }
  }

  open(event) {
    event.preventDefault();
    console.log("Opening modal");
    this.containerTarget.querySelector(".hidden")?.classList.remove("hidden");
    document.body.classList.add("overflow-hidden");
  }

  close() {
    console.log("Closing modal");
    this.containerTarget
      .querySelector(":not(.hidden)")
      ?.classList.add("hidden");
    document.body.classList.remove("overflow-hidden");
  }

  closeBackground(event) {
    if (event.target === event.currentTarget) {
      this.close();
    }
  }
}
