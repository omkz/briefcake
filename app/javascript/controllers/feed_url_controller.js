// feed_url_controller.js
import { Controller } from "@hotwired/stimulus"
import axios from "axios";

export default class extends Controller {
  static targets = [
    "url",
    "feedUrlInput",
    "loader",
    "checkButton",
    "submitButton",
    "name"
  ];

  check(event) {
    this.submitButtonTarget.classList.add("btn--disabled");
    let item = event.target.closest(".nested-fields")

    // Find the one of these targets that is actually in the nested field group the click came from.
    let loader = this.loaderTargets.find(loader => item.contains(loader))
    let checkButton = this.checkButtonTargets.find(checkButton => item.contains(checkButton));
    let urlTarget = this.urlTargets.find(url => item.contains(url));
    let feedUrlInputTarget = this.feedUrlInputTargets.find(feedUrlInput => item.contains(feedUrlInput));
    let nameTarget = this.nameTargets.find(name => item.contains(name));

    loader.classList.remove("hidden");
    checkButton.classList.add("hidden");

    const cleanup = () => {
      loader.classList.add("hidden");
      checkButton.classList.remove("hidden");
      this.submitButtonTarget.classList.remove("btn--disabled");
      this.submitButtonTarget.classList.remove("hidden");
    }


    if ( ! /^https:\/\//.test(urlTarget.value) ) {
      console.log("target url is likely invalid")
      alert(`Invalid url ${urlTarget.value}. Please make sure your url starts with https://`)
      cleanup()
      return
    }

    const url = `/feeds/check.json?url=${urlTarget.value}`;

    axios
      .get(url)
      .then(response => {
        const data = response.data;
        feedUrlInputTarget.value = data.feed_url;
        nameTarget.value = data.name
      })
      .finally(cleanup);

  }
}
