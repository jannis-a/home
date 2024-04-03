data "spacelift_current_stack" "this" {}

resource "spacelift_context" "this" {
  name   = "home"
  labels = ["autoattach:home"]
}
