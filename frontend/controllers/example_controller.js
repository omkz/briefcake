import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [];

  connect() {
    window.addEventListener("scroll", event => {
      this.element.contentWindow.scrollTo({
        top: event.pageY,
        left: 0,
        behavior: "smooth"
      });
    });
  }
}
