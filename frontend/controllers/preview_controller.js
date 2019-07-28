import { Controller } from "stimulus";
import { debounce } from "lodash";

export default class extends Controller {
  static targets = ["iframe"];

  connect() {
    const debouncedRefresh = debounce(this.refreshFrame.bind(this), 500);
    this.element.addEventListener("keyup", debouncedRefresh);
    this.element.addEventListener("change", debouncedRefresh);
  }

  refreshFrame() {
    let data = {};
    let url = this.data.get("url") + "?";
    this.element.querySelectorAll(".feed-input").forEach(el => {
      data[el.getAttribute("name")] = el.value;
      url += "&" + el.getAttribute("name") + "=" + encodeURI(el.value);
    });

    console.log(url);

    this.iframeTarget.src = url;
  }
}
