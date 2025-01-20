import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["star", "input"];

  connect() {
    this.updateStars();
  }

  updateStars() {
    const rating = parseFloat(this.inputTarget.value) || 0;
    this.starTargets.forEach((star) => {
      const starValue = parseFloat(star.dataset.value);
      const isActive = starValue <= rating;
      const svg = star.querySelector("svg");

      // Remove both possible colors first
      svg.classList.remove("text-primary-400", "text-primary-500");
      // Add the appropriate color
      svg.classList.toggle("text-primary-500", isActive);
      svg.classList.toggle("text-neutral-600", !isActive);
    });
  }

  mouseEnter(event) {
    const hoverValue = parseFloat(event.currentTarget.dataset.value);
    this.starTargets.forEach((star) => {
      const starValue = parseFloat(star.dataset.value);
      const shouldHighlight = starValue <= hoverValue;
      const svg = star.querySelector("svg");

      // Remove both possible colors first
      svg.classList.remove("text-primary-400", "text-primary-500");
      // Use primary-400 for hover state
      svg.classList.toggle("text-primary-400", shouldHighlight);
      svg.classList.toggle("text-neutral-600", !shouldHighlight);
    });
  }

  mouseLeave() {
    this.updateStars();
  }

  setRating(event) {
    this.inputTarget.value = event.currentTarget.dataset.value;
    this.updateStars();
    const label = this.element.querySelector("label");
    label.textContent = "Rated";

    // Auto-submit the form
    this.element.closest("form").requestSubmit();
  }

  clearRating() {
    this.inputTarget.value = 0;
    this.updateStars();
    const label = this.element.querySelector("label");
    label.textContent = "Rating";

    // Auto-submit the form
    this.element.closest("form").requestSubmit();
  }
}
