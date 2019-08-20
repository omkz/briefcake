// feed_url_controller.js
import { Controller } from "stimulus";
import axios from "axios";

export default class extends Controller {
  static targets = [
    "url",
    "feedUrlInput",
    "loader",
    "checkButton",
    "submitButton"
  ];

  check(event) {
    this.loaderTarget.classList.remove("hidden");
    this.submitButtonTarget.classList.add("btn--disabled");
    this.checkButtonTarget.classList.add("hidden");

    const url = `/feeds/check.json?url=${this.urlTarget.value}`;

    axios
      .get(url)
      .then(response => {
        const data = response.data;
        this.feedUrlInputTarget.value = data.feed_url;
      })
      .finally(() => {
        this.loaderTarget.classList.add("hidden");
        this.checkButtonTarget.classList.remove("hidden");
        this.submitButtonTarget.classList.remove("btn--disabled");
        this.submitButtonTarget.classList.remove("hidden");
      });
  }
}
