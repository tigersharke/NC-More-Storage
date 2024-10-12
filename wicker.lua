-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
minetest.register_alias(modname.. ":shelf_wicker_basket",	"wc_basket:shelf_wicker")
------------------------------------------------------------------------
local bark = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"
local wick = "nc_flora_wicker.png^(" .. bark .. ")"
------------------------------------------------------------------------
minetest.register_node(modname .. ":shelf_wicker", {
		description = "Wicker Shelf",
--		tiles = {bark, wick},
		tiles = {bark, wick},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			snappy = 1,
			visinv = 1,
			flammable = 2,
			fire_fuel = 3,
			storebox = 1,
			totable = 1,
			basketable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		sounds = nodecore.sounds("nc_tree_sticky"),
		storebox_access = function(pt) return pt.above.y == pt.under.y end,
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":shelf_wicker" then
				return nodecore.stack_get(pos)
			end
		end
	})
	

nodecore.register_craft({
	label = "assemble wicker shelves",
	indexkeys = {"nc_flora:wicker"},
	nodes = {
		{match = "nc_flora:wicker", replace = "air"},
		{x = -1, match = "nc_woodwork:form", replace = modname.. ":shelf_wicker"},
		{x = 1, match = "nc_woodwork:form", replace = modname.. ":shelf_wicker"},
		{z = -1, match = "nc_woodwork:form", replace = modname.. ":shelf_wicker"},
		{z = 1, match = "nc_woodwork:form", replace = modname.. ":shelf_wicker"},
	},
})


