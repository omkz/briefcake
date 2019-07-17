// feed_controller.js
import { Controller } from "stimulus";
import axios from "axios";

export default class extends Controller {
  static targets = [
    "url",
    "rssFeedUrlField",
    "rssFeedUrlInput",
    "nameField",
    "nameInput"
  ];

  check(event) {
    this.rssFeedUrlFieldTarget.classList.add("hidden");

    const url = `/feeds/check.json?url=${this.urlTarget.value}`;

    console.log("check", url);
    axios
      .get(url)
      .then(response => {
        this.nameFieldTarget.classList.remove("hidden");

        const data = response.data;
        if (data.rss_feed_url) {
          this.rssFeedUrlFieldTarget.classList.remove("hidden");
          this.rssFeedUrlInputTarget.value = data.rss_feed_url;
        }

        if (data.name) {
          this.nameInputTarget.value = data.name;
        }
      })
      .catch(error => {
        console.error(error);
      });
  }

  connect() {
    console.log(this.rssFeedUrlFieldTarget);
  }
}
