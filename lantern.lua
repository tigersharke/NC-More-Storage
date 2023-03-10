-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, ItemStack
    = minetest, nodecore, ItemStack
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local rfcall = function(pos, data)
	local ref = minetest.get_player_by_name(data.pname)
	local wield = ref:get_wielded_item()
	wield:take_item(1)
	ref:set_wielded_item(wield)
end
-- ================================================================== --
local glass = "nc_optics_glass_edges.png^(nc_tree_tree_side.png^[mask:nc_optics_tank_mask.png)"
local glow = "nc_lux_base.png^(" ..glass.. ")"
-- ================================================================== --
minetest.register_node(modname .. ":lantern", {
	description = "Simple Lantern",
	drawtype = "normal",
	tiles = {glow},
	selection_box = nodecore.fixedbox(),
	collision_box = nodecore.fixedbox(),
	groups = {
		cracky = 3,
		totable = 1,
		scaling_time = 50
	},
	light_source = 6,
	stack_max = 1,
	paramtype = "light",
	sunlight_propagates = true,
	sounds = nodecore.sounds("nc_optics_glassy")
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "assemble simple lantern",
	action = "pummel",
	indexkeys = {"nc_optics:shelf_float"},
	wield = {name = "nc_torch:torch_lit_1"},
	after = rfcall,
	nodes = {
		{
			match = {name = "nc_optics:shelf_float", empty = true},
			replace = modname .. ":lantern"
		},
	}
})
--nodecore.register_craft({
--	label = "assemble lantern",
--	action = "stackapply",
--	indexkeys = {"nc_optics:shelf_float"},
--	wield = {name = "nc_torch:torch_lit_1"},
--	consumewield = 1,
--	nodes = {
--		{
--			match = {name = "nc_optics:shelf_float", empty = true},
--			replace = modname .. ":lantern"
--		},
--	}
--})
------------------------------------------------------------------------
nodecore.register_abm({
	label = "Simple Lantern Burn",
	interval = 120,
	chance = 4,
	nodenames = {modname .. ":lantern"},
	action = function(pos)
		nodecore.item_eject(pos, "nc_fire:lump_ash", 1)
		nodecore.sound_play("nc_fire_snuff", {gain = 0.25, pos = pos})
		return minetest.set_node(pos, {name = "nc_optics:shelf_float"})
	end
})
nodecore.register_aism({
	label = "Held Simple Lantern Burn",
	interval = 120,
	chance = 4,
	itemnames = {modname .. ":lantern"},
	action = function(stack, data)
		nodecore.item_eject(data.pos,"nc_fire:lump_ash",1,1,{x = 1, y = 1, z = 1})
		nodecore.sound_play("nc_fire_snuff", {gain = 0.25, pos = pos})
			stack:set_name("nc_optics:shelf_float")
			return stack
	end
})
------------------------------------------------------------------------
