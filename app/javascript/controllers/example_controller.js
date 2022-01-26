import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [];

  connect() {
    window.addEventListener("scroll", event => {
      this.element.contentWindow.scrollTo({
        top: window.pageYOffset,
        left: 0,
        behavior: "smooth"
      });
    });
  }
}
