import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["star", "input"];

  connect() {
    this.updateStars();
  }

  updateStars() {
    const rating = parseFloat(this.inputTarget.value) || 0;
    this.starTargets.forEach((star, index) => {
      const starValue = parseFloat(star.dataset.value);
      const isActive = starValue <= rating;
      star.querySelector("svg").classList.toggle("text-primary-500", isActive);
      star.querySelector("svg").classList.toggle("text-neutral-600", !isActive);
    });
  }

  mouseEnter(event) {
    const hoverValue = parseFloat(event.currentTarget.dataset.value);
    this.starTargets.forEach((star, index) => {
      const starValue = parseFloat(star.dataset.value);
      const shouldHighlight = starValue <= hoverValue;
      star
        .querySelector("svg")
        .classList.toggle("text-primary-400", shouldHighlight);
      star
        .querySelector("svg")
        .classList.toggle("text-neutral-600", !shouldHighlight);
    });
  }

  mouseLeave() {
    this.updateStars();
  }

  setRating(event) {
    this.inputTarget.value = event.currentTarget.dataset.value;
    this.updateStars();
  }

  clearRating() {
    this.inputTarget.value = 0;
    this.updateStars();
  }
}
