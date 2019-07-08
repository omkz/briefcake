import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "items", "toggle" ]

  toggle() {
    this.itemsTarget.classList.toggle("nav__items--visible");
    this.toggleTarget.classList.toggle("nav__toggle--toggled");

    if(this.toggleTarget.textContent == "menu") {
      this.toggleTarget.textContent = "close"
    } else {
      this.toggleTarget.textContent = "menu"
    }
  }
}

