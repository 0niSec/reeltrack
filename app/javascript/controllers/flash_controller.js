import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["message"];
  static values = { dismissAfter: Number };

  connect() {
    if (this.hasDismissAfterValue) {
      setTimeout(() => {
        this.messageTarget.classList.add("opacity-0");
        setTimeout(() => {
          this.element.remove();
        }, 500);
      }, this.dismissAfterValue);
    }
  }
}
