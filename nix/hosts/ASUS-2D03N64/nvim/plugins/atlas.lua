local spec = require("config.atlas")

spec.opts.providers.github.hostname = "github.astroscale-us.com"
spec.opts.pulls.repo_config.paths = {
  ["ASUS/*"] = "~/source/frigg/*",
  ["ASUS/frigg"] = "~/code/frigg",
}

return spec
