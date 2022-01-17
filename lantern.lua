-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local glass = "nc_optics_glass_edges.png^(nc_tree_tree_side.png^[mask:nc_optics_tank_mask.png)"

local glow = "nc_lux_base.png^(" ..glass.. ")"

minetest.register_node(modname .. ":lantern", {
		description = "Lantern",
		drawtype = "allfaces",
		tiles = {glow},
		selection_box = nodecore.fixedbox(),
		collision_box = nodecore.fixedbox(),
		groups = {
			cracky = 3,
			totable = 1,
			scaling_time = 50
		},
		paramtype = "light",
		light_source = 9,
		sounds = nodecore.sounds("nc_optics_glassy"),
		on_ignite = function(pos)
			if minetest.get_node(pos).name == modname .. ":lantern" then
				return nodecore.stack_get(pos)
			end
		end
	})

nodecore.register_craft({
		label = "assemble lantern",
		action = "stackapply",
		indexkeys = {"nc_optics:shelf_float"},
		wield = {name = "nc_torch:torch_lit_1"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_optics:shelf_float", empty = true},
				replace = modname .. ":lantern"
			},
		}
	})
