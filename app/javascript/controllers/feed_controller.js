// feed_controller.js
import { Controller } from "@hotwired/stimulus"
import axios from "axios";

export default class extends Controller {
  static targets = [
    "url",
    "rssFeedUrlInput",
    "nameField",
    "nameInput",
    "rssFeedTruncationField",
    "rssFeedTruncationInput",
    "loader",
    "submitButton",
    "checkButton"
  ];

  initialize(){
    if(this.urlTarget.value){ this.check(); }
  }

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

        this.rssFeedTruncationFieldTarget.classList.remove("hidden");
        // TODO: make sure to remove this, there is no need for feed url on front-end side. Everything could be determined on a back-end.
        this.rssFeedUrlInputTarget.value = data.feed_url;
        this.nameInputTarget.value = data.name;
      })
      .finally(() => {
        this.loaderTarget.classList.add("hidden");
        this.checkButtonTarget.classList.remove("hidden");
        this.submitButtonTarget.classList.remove("btn--disabled");
        this.submitButtonTarget.classList.remove("hidden");

        var event = document.createEvent("Event");
        event.initEvent("checkedFeed", true, true);
        this.element.dispatchEvent(event);
      });
  }
}
