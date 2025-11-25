// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

console.log("############################################### POPOVER MUST WORK!");
document.addEventListener("turbo:load", () => {
    document
        .querySelectorAll('[data-bs-toggle="popover"]')
        .forEach((el) => new bootstrap.Popover(el));
});

document.addEventListener("turbo:load", () => {
    const btn = document.getElementById("notificationsPopover");
    if (btn) {
        const content = document.getElementById("notifications-content").innerHTML;

        new bootstrap.Popover(btn, {
            html: true,
            content: content,
            placement: "left",
            container: "body"
        });
    }
});

const popover = new bootstrap.Popover('.popover-dismiss', {
    trigger: 'focus'
})