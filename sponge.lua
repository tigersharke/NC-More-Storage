-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local form = "nc_optics_glass_edges.png^(nc_tree_tree_side.png^[mask:nc_optics_tank_mask.png)"

local glass = "nc_optics_glass_glare.png" --^(" .. form .. ")"

local sponge = "nc_sponge.png^nc_sponge_living.png^(nc_terrain_water.png^[opacity:96)"

local side = "("..sponge..")^("..glass..")" --^("..form..")"

minetest.register_node(modname .. ":shelf_sponge", {
	description = "Aquarium",
	tiles = {form, side},
	drawtype = "glasslike_framed",
	selection_box = nodecore.fixedbox(),
	collision_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		totable = 1,
		scaling_time = 60,
		silica = 1,
		silica_clear = 1,
		moist = 1,
		coolant = 1,
		stack_as_node = 1,
	},
	paramtype = "light",
	stack_max = 1,
	sunlight_propagates = true,
	air_pass = false,
	sounds = nodecore.sounds("nc_optics_glassy")
})

nodecore.register_craft({
		label = "assemble aquarium",
		action = "stackapply",
		indexkeys = {"nc_optics:shelf"},
		wield = {name = "nc_sponge:sponge_living"},
		consumewield = 1,
		nodes = {
			{
				match = {name = "nc_optics:shelf", empty = true},
				replace = modname .. ":shelf_sponge"
			},
		}
	})

nodecore.register_craft({
	label = "break aquarium apart",
	action = "pummel",
	indexkeys = {modname.. ":shelf_sponge"},
	nodes = {
			{
				match = {name = modname.. ":shelf_sponge"},
				replace = "nc_sponge:sponge_living"
			},
		},
	items = {"nc_optics:glass_crude"},
	toolgroups = {cracky = 3, thumpy = 3}
})
