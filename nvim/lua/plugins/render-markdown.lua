require("render-markdown").setup({
    file_types = { "markdown", "rmd", "rmarkdown", "tex" },
    code = {
        enabled = true,
        sign = false,
        width = "full",
    },
    latex = { enabled = false },
    heading = { enabled = false },
    dash = { enabled = false },
    bullet = { enabled = false },
    checkbox = { enabled = false },
    quote = { enabled = false },
    pipe_table = { enabled = false },
    link = { enabled = false },
    sign = { enabled = false },
})
