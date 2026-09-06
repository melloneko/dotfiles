return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        "tokyodark",
        "onenord",
        "lackluster",
        "monochrome",
        -- nightfox.nvim ships several variants under one plugin:
        "nightfox",
        "dayfox",
        "dawnfox",
        "duskfox",
        "nordfox",
        "terafox",
        "carbonfox",
        "solarized-osaka",
      },
      livePreview = true,
    })
  end,
}
