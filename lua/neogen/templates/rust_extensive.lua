local i = require("neogen.types.template").item

return {
    { nil, "! $1", { no_results = true, type = { "file" } } },
    { nil, "", { no_results = true, type = { "file" } } },

    { nil, "/ $1", { no_results = true, type = { "func", "class" } } },

    { nil, "/ $1", { type = { "func", "class" } } },
    { nil, "/", { type = { "class", "func" } } },
    { nil, "/ # Arguments", { type = { "class", "func" } } },
    { nil, "/", { type = { "class", "func" } } },
    { i.Parameter, "/ * `%s`: $1", { type = { "class" } } },
    { i.Parameter, "/ * `%s`: $1", { type = { "func" } } },
    -- { i.HasThrow, "/ # Errors", { type = { "func" } } },
    -- { i.HasThrow, "/", { type = { "func" } } },
    -- { i.HasThrow, "/ * `%s`: $1", { type = { "func" } } },
}
