import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "wrapper" ]

  close() {
    this.wrapperTarget.classList.add("flashHideAnimation")
  }
}


