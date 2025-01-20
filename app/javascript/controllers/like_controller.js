import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["heart", "input"];

  connect() {
    this.updateHeart();
  }

  toggle() {
    const checkbox = this.inputTarget;
    checkbox.checked = !checkbox.checked;
    this.updateHeart();
  }

  updateHeart() {
    const isLiked = this.inputTarget.checked;
    const heart = this.heartTarget;

    if (isLiked) {
      heart.setAttribute("fill", "currentColor");
      heart.setAttribute("stroke", "none");
      const label = this.element.querySelector("label");
      label.textContent = "Liked";

      this.element.closest("form").requestSubmit();
    } else {
      heart.setAttribute("fill", "none");
      heart.setAttribute("stroke", "currentColor");
      heart.classList.remove("text-primary-500");
      heart.classList.add("text-neutral-600");
      const label = this.element.querySelector("label");
      label.textContent = "Like";

      this.element.closest("form").requestSubmit();
    }
  }
}
