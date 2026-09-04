import { Controller } from "@hotwired/stimulus"

// フラッシュを指定秒後に消す。余白の高さはレイアウト側で固定する。
export default class extends Controller {
  static targets = [ "message", "bar" ]
  static values = { delay: { type: Number, default: 6000 } }

  connect() {
    if (!this.hasMessageTarget) return

    this.hideTimer = setTimeout(() => this.hide(), this.delayValue)
  }

  disconnect() {
    clearTimeout(this.hideTimer)
  }

  hide() {
    this.messageTargets.forEach((element) => {
      element.classList.add("is-hidden")
      element.setAttribute("aria-hidden", "true")
    })

    if (this.hasBarTarget) {
      this.barTarget.classList.remove("is-active")
    }
  }
}
