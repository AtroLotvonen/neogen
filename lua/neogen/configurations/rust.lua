local extractors = require("neogen.utilities.extractors")
local i = require("neogen.types.template").item
local nodes_utils = require("neogen.utilities.nodes")
local template = require("neogen.template")

return {
    parent = {
        func = { "function_item", "function_signature_item" },
        class = { "struct_item", "trait_item" },
        file = { "source_file" },
    },
    data = {
        func = {
            ["function_item|function_signature_item"] = {
                ["0"] = {
                    extract = function(node)
                        local tree = {
                            {
                                retrieve = "first",
                                node_type = "parameters",
                                subtree = {
                                    {
                                        retrieve = "all",
                                        node_type = "parameter",
                                        subtree = {
                                            {
                                                retrieve = "first",
                                                node_type = "identifier",
                                                extract = true,
                                                as = i.Parameter,
                                            },
                                        },
                                    },
                                    {
                                        retrieve = "all",
                                        node_type = "type_identifier",
                                        extract = true,
                                        as = i.Parameter,
                                    },
                                },
                            },
                            {
                                retrieve = "first",
                                node_type = "generic_type",
                                extract = true,
                                as = i.ReturnTypeHint,
                            },
                        }
                        local nodes = nodes_utils:matching_nodes_from(node, tree)
                        local res = extractors:extract_from_matched(nodes)

                        -- if nodes["generic_type"] then
                        --
                        --     if not vim.tbl_isempty(left) and not vim.tbl_isempty(left[1]:field("attribute")) then
                        --         --Adding it to the list
                        --         local left_attribute = assignment:field("left")[1]:field("attribute")[1]
                        --         left_attribute = helpers.get_node_text(left_attribute)[1]
                        --
                        --         if not vim.startswith(left_attribute, "_") then
                        --             table.insert(results[i.ClassAttribute], left_attribute)
                        --         end
                        --     end
                        -- end
                        return res
                    end,
                },
            },
        },
        file = {
            ["source_file"] = {
                ["0"] = {
                    extract = function()
                        return {}
                    end,
                },
            },
        },
        class = {
            ["struct_item|trait_item"] = {
                ["0"] = {
                    extract = function(node)
                        local tree = {
                            {
                                retrieve = "first",
                                node_type = "field_declaration_list",
                                subtree = {
                                    {
                                        retrieve = "all",
                                        node_type = "field_declaration",
                                        subtree = {
                                            {
                                                retrieve = "all",
                                                node_type = "field_identifier",
                                                extract = true,
                                                as = i.Parameter,
                                            },
                                        },
                                    },
                                },
                            },
                        }
                        local nodes = nodes_utils:matching_nodes_from(node, tree)
                        local res = extractors:extract_from_matched(nodes)
                        return res
                    end,
                },
            },
        },
    },

    template = template
        :config({ use_default_comment = true })
        :add_annotation("rustdoc")
        :add_annotation("rust_alternative")
        :add_default_annotation("rust_extensive"),
}
