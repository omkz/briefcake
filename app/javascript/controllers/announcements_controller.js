import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "banner" ]

  dismiss() {
    this.bannerTarget.classList.add("hidden")
    this.setCookie()
  }

  setCookie() {
    const days_to_expire  = 28
    const name            = `_${this.data.get("siteName")}_announcement_${this.data.get("id")}`
    const value           = true
    const expires         = new Date(Date.now() + days_to_expire * 864e5).toUTCString()
    const path            = "/"

    document.cookie       = `${name}=${encodeURIComponent(value)}; expires=${expires}; path=${path}`
  }
}

