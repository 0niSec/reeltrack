import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  preview(event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        const img = this.element
          .closest("#avatar-container")
          .querySelector("img");
        if (img) {
          img.src = e.target.result;
        } else {
          const container = this.element.closest("#avatar-container");
          container.innerHTML = `<img src="${e.target.result}" class="w-32 h-32 rounded-full">`;
        }
      };
      reader.readAsDataURL(file);
    }
  }
}
