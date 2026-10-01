require('leetcode').setup({
    lang = "cpp",
    injector = {
        ["cpp"] = {
            -- A function replaces the plugin's default C++ imports.
            imports = function()
                return {
                    "#include <iostream>",
                    "#include <string>",
                    "#include <vector>",
                    "using namespace std;",
                }
            end,
        },
    },
    theme = {
        ["normal"] = {
            fg = "#EA4AAA",
        },
    },
})
