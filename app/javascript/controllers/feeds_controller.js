import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="feeds"
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

        if (response.ok) {
            const html = await response.text()
            this.listTarget.insertAdjacentHTML("beforeend", html)
            this.loading = false
            this.listTarget.dataset.nextPage = parseInt(nextPage) + 1;
        }
    }
}
