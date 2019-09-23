import {Controller} from "stimulus";

export default class extends Controller {
  connect() {
    setInterval(() => {
      this.element.contentWindow.location.reload();
    }, 60 * 1000)
  }
}
