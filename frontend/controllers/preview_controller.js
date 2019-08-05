import { Controller } from "stimulus";
import { debounce } from "lodash";

export default class extends Controller {
  static targets = ["iframe"];

  connect() {
    const debouncedRefresh = debounce(this.refreshFrame.bind(this), 1000);
    this.element.addEventListener("keyup", debouncedRefresh);
    this.element.addEventListener("change", debouncedRefresh);
    this.element.addEventListener("checkedFeed", this.refreshFrame.bind(this));

    if(this.element.querySelectorAll(".feed-input")[0].value !== ""){
      this.refreshFrame();
    };
  }

  refreshFrame() {
    let data = {};
    let url = this.data.get("url") + "?";

    this.element.querySelectorAll(".feed-input").forEach(el => {
      data[el.getAttribute("name")] = el.value;
      url += "&" + el.getAttribute("name") + "=" + encodeURI(el.value);
    });

    this.iframeTarget.src = url;
  }
}
