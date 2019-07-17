// feed_controller.js
import {Controller} from "stimulus";
import axios from "axios";

export default class extends Controller {
  static targets = [
    "url",
    "rssFeedUrlField",
    "rssFeedUrlInput",
    "nameField",
    "nameInput",
    "loader",
    "submitButton",
    "checkButton"
  ];

  check(event) {
    this.loaderTarget.classList.remove("hidden");
    this.submitButtonTarget.classList.add("btn--disabled");
    this.checkButtonTarget.classList.add("hidden");

    const url = `/feeds/check.json?url=${this.urlTarget.value}`;

    axios
      .get(url)
      .then(response => {
        this.nameFieldTarget.classList.remove("hidden");

        const data = response.data;

        this.rssFeedUrlFieldTarget.classList.remove("hidden");
        this.rssFeedUrlInputTarget.value = data.rss_feed_url;
        this.nameInputTarget.value = data.name;
      })
      .finally(() => {
        this.loaderTarget.classList.add("hidden");
        this.checkButtonTarget.classList.remove("hidden");
        this.submitButtonTarget.classList.remove("btn--disabled");
      });
  }
}