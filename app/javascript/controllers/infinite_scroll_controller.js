import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ["list"]

  connect() {
    this.loading = false
    window.addEventListener("scroll", () => this.onScroll())
  }

  onScroll() {
    if (this.loading) return
    if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 300) {
      console.log("####: " + "detected!");
      this.loadMore()
    }
  }

  async loadMore() {
    this.loading = true
    const nextPage = this.listTarget.dataset.nextPage
    const lastPage = this.listTarget.dataset.lastPage
    if (!nextPage) return
    if (parseInt(nextPage) > parseInt(lastPage)) return;

    const response = await fetch(`${this.urlValue}?page=${nextPage}`, {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    })

    console.log("####: " + `${this.urlValue}?page=${nextPage}`);

    if (response.ok) {
      const html = await response.text()
      this.listTarget.insertAdjacentHTML("beforeend", html)
      this.loading = false
      this.listTarget.dataset.nextPage = parseInt(nextPage) + 1;
    }
  }
}
