import { Controller } from "@hotwired/stimulus"

// Enter で送信。日本語入力の確定と Shift+Enter の改行は邪魔しない。
export default class extends Controller {
  submitOnEnter(event) {
    if (event.isComposing || event.keyCode === 229) return
    if (event.key !== "Enter" || event.shiftKey) return

    event.preventDefault()
    this.element.requestSubmit()
  }
}
