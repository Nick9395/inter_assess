import { Controller } from "@hotwired/stimulus"

// 空の追加枠は隠しておき、ボタンで次の1件を出す。
export default class extends Controller {
  static targets = [ "slot", "addButton" ]

  connect() {
    this.syncAddButton()
  }

  add(event) {
    event.preventDefault()
    const nextSlot = this.slotTargets.find((slot) => slot.hidden)
    if (!nextSlot) return

    nextSlot.hidden = false
    this.syncAddButton()
  }

  syncAddButton() {
    if (!this.hasAddButtonTarget) return

    this.addButtonTarget.hidden = this.slotTargets.every((slot) => !slot.hidden)
  }
}
