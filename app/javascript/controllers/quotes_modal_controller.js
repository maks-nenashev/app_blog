import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]

  open(e) {
    if (e) e.preventDefault()
    this.dialogTarget.showModal()
  }

  close(e) {
    if (e) e.preventDefault()
    this.dialogTarget.close()
  }

  backdropClick(e) {
    if (e.target === this.dialogTarget) {
      this.close()
    }
  }
}